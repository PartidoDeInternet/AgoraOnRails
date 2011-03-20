require 'tractis/http'

module Tractis
  module IdentityVerifications
    def self.included(base) # :nodoc:
      base.send(:private, :valid_tractis_identity_verification!)
    end
    PARAMS_NOT_FORWARDED = [:format, :action, :controller]
    
    # Doc
    def valid_tractis_identity_verification!(api_key, params)
      parameters = {}
      params.each do |key, value|
        key = key.to_sym
        parameters[key] = value unless PARAMS_NOT_FORWARDED.include?(key)
      end
      parameters[:api_key] = api_key

      response = Tractis::HTTP::Request(:POST, '/data_verification', parameters)
      if response.code.to_s == '200'
        return true
      else
        raise Tractis::InvalidVerificationError
      end
    end
    
  end
  
  class InvalidVerificationError < Exception # :nodoc
  end
end
