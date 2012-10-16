require 'data.rb'
require 'roles.rb'

class LogIntoDropboxAccount
  def initialize(app_key, app_secret, on_success=lambda({}), on_failure=lambda({}))
    @app_key=app_key
    @app_secret=app_secret
    @on_success=on_success
    @on_failure=on_failure 
  end
  def run
    
  end
end
