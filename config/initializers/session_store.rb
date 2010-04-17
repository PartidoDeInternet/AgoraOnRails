# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_demos_session',
  :secret      => 'dedd7af343937bf139cdc60bd38fd56abe87be2fa1f2573f2c4e65abcb6deb1b42b5fde68a527c4b3c876276cdceb28236c8f53b8d09940be0540fddadcff2b8'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
