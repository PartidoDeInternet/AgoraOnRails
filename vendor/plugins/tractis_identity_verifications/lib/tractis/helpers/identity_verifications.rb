module Tractis
  module Helpers
    module IdentityVerifications
      def form_for_identity_verification_gateway(api_key, notification_callback, options = {}, &block)
        raise ArgumentError, "This method requires a block" unless block_given?
        notification_callback = case notification_callback
        when Hash
          notification_callback[:only_path] = false
          notification_callback
        else
          notification_callback
        end
      
        form_tag("https://www.tractis.com/verifications") do
          inputs = [
            hidden_field_tag(:api_key, api_key),
            hidden_field_tag(:notification_callback, url_for(notification_callback))
          ]
          inputs << hidden_field_tag(:public_verification, true) if options[:public_verification]
          inputs << capture(&block)
          inputs.join().html_safe
        end
      end
    
      def identity_verification_gateway(button_caption, api_key, notification_callback, options = {})
        capture do
          form_for_identity_verification_gateway(api_key, notification_callback, options) do
            submit_tag button_caption
          end
        end
      end
    end
  end
end
