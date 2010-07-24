# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_anything2_session',
  :secret      => 'c7f35ee5ffbbeed98fd8e7c6726f5375f7fad775190bf6b8fd1531db35d23b64ecca8d78dc3939f02d3223a750bb2c7e74bc4677bbaa866f058410306d5fd9fb'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
