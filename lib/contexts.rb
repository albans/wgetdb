require 'data.rb'
require 'roles.rb'

class LogIntoDropboxAccount
  def initialize(app_key, app_secret, on_success=lambda {}, on_failure=lambda {})
    @app_key=app_key
    @app_secret=app_secret
    @on_success=on_success
    @on_failure=on_failure 
  end
  def run
    account = DropboxAccount.new(app_key:@app_key, app_secret:@app_secret, id:1)
    account.extend(Store)
    account.extend(DBSession)
    @auth_url = account.get_authorize_url
    account.store
    @on_success.call(@auth_url)
  end
end
