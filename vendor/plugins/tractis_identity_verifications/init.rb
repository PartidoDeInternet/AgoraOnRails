# Include hook code here
require 'tractis/identity_verifications'
require 'tractis/helpers/identity_verifications'

ActionView::Base.send(:include, Tractis::Helpers::IdentityVerifications)