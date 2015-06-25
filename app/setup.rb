require 'bundler/setup'

require '/users/bryanp/code/pakyow/libs/pakyow/pakyow-support/lib/pakyow-support'
require '/users/bryanp/code/pakyow/libs/pakyow/pakyow-core/lib/pakyow-core'
require '/users/bryanp/code/pakyow/libs/pakyow/pakyow-presenter/lib/pakyow-presenter'
require '/users/bryanp/code/pakyow/libs/pakyow/pakyow-mailer/lib/pakyow-mailer'
require '/users/bryanp/code/pakyow/libs/pakyow/pakyow-realtime/lib/pakyow-realtime'
require '/users/bryanp/code/pakyow/libs/pakyow/pakyow-ui/lib/pakyow-ui'

# require 'pakyow'
require 'sequel'

$db = Sequel.sqlite

$db.create_table :messages do
  primary_key :id
  String :body
end

Pakyow::App.define do
  configure :global do
    app.name = 'Pakyow Chat'
  end

  middleware do |builder|
    builder.use Rack::Session::Cookie, key: "#{Pakyow::Config.app.name}.session", secret: 'sekret'
  end
end
