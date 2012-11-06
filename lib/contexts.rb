require 'data.rb'
require 'roles.rb'

class LogIntoDropboxAccount
  def initialize(app_key, app_secret, authorize=lambda {}, on_success=lambda{}, on_failure=lambda {})
    @app_key=app_key
    @app_secret=app_secret
    @authorize=authorize
    @on_success=on_success
    @on_failure=on_failure 
  end
  def run
    account = DropboxAccount.new(app_key:@app_key, app_secret:@app_secret, id:1)
    account.extend(Store)
    account.extend(DBSession)
    @auth_url = account.get_authorize_url
    @authorize.call(@auth_url)
    account.authorize
    account.store
  end
end
class DownloadResource
  def initialize(resource, on_success=lambda{|meta| meta}, on_failure=lambda{})
    @resource = resource
    @on_success = on_success
    @on_failure = on_failure
  end
  def run
    account = Store.find_by_id(DropboxAccount, 1)
    account.extend(DBSession)
    resource = Resource.new(uri: @resource)
    resource.extend(Download)
    resource.extend(Store)
    meta = resource.download(account.client)
    resource.store
    @on_success.call(meta)
  end
end
