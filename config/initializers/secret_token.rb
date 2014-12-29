# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
TaskApp::Application.config.secret_key_base = '72625e243e77eeae36bfeb2a82f1a1692501bf2969e46242f107fc1107b9694efa1cc163779796871159528f65dbe5120e20bf1494f87d9f8968afc7d842edb7'
