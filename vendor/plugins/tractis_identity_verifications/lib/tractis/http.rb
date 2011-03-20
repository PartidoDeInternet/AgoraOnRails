require 'net/http'
require 'net/https'

module Tractis
  class HTTP
    HOST = 'www.tractis.com'
    PORT = 443
    
    def self.Request(method, path, params={}, &block)
      path = build_path(method, path, params)
      
      socket = Net::HTTP.new(HOST, PORT)
      socket.use_ssl = true if PORT == 443
      
      socket.start do |http|
        request = RequestForMethod(method).new(path, {
          'Accept' => 'application/xml',
          'Host' => HOST
        })
        if !params.empty?
          request.set_form_data(params)
        end
        
        yield(request) if block_given?
        
        DEBUG(request)
        
        reply = http.request(request)
        
        DEBUG(reply)
        
        return reply
      end
    end
    
    def self.build_path(method, path, params) # :nodoc:
      if method == :GET && !params.empty?
        query = path.split('?')
        path  = query.shift
        query<< params.collect {|key,value| "#{key}=#{value}" }
        path << '?' << query.join('&')
        params.clear
      end
      return path
    end
    
    # Returns the correct net/http class for the given method
    def self.RequestForMethod(method) # :nodoc:
      case method
      when :POST
        Net::HTTP::Post
      when :PUT
        Net::HTTP::Put
      when :DELETE
        Net::HTTP::Delete
      when :GET
        Net::HTTP::Get
      else
        raise ArgumentError("invalid method: #{method}\n  Valid methods are :POST, :PUT, :DELETE and :GET")
      end
    end
    
    DEBUGGED_HEADERS = [
      'authorization',
      'status',
      'content-type',
      'accept',
      'content-length',
      'host',
      'location'
    ] # :nodoc:
    
    def self.DEBUG(debug) # :nodoc:
      if debug.kind_of?(Net::HTTPRequest)
        RAILS_DEFAULT_LOGGER.debug "#{debug.method} #{debug.path} HTTP/1.1"
      else
        RAILS_DEFAULT_LOGGER.debug "HTTP/#{debug.http_version} #{debug.code} #{debug.message}"
      end
      
      debug.each_key do |key|
        next unless DEBUGGED_HEADERS.include?(key)
        header = key.split('-').collect {|word| word.capitalize }.join('-')
        RAILS_DEFAULT_LOGGER.debug "#{header}: #{debug[key]}"
      end
      
      RAILS_DEFAULT_LOGGER.debug
      RAILS_DEFAULT_LOGGER.debug debug.body if debug.body
      RAILS_DEFAULT_LOGGER.debug
    end
  end
end
