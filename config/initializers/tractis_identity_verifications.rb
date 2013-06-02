require 'tractis_identity_verifications/tractis/identity_verifications'
require 'tractis_identity_verifications/tractis/helpers/identity_verifications'

ActionView::Base.send(:include, Tractis::Helpers::IdentityVerifications)