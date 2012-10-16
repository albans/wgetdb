require 'data.rb'
require 'roles.rb'
require 'dropbox_sdk'

APP_KEY = '95tfrq6cyqes4jn'
APP_SECRET = 'wg9y3lfv2djaeti'
describe DBSession do
  describe "get_authorize_url" do
    it 'return a url for a valid dropbox account' do
      account = DropboxAccount.new(app_key: APP_KEY, app_secret: APP_SECRET)
      account.extend DBSession
      account.get_authorize_url.should_not be nil      
    end
  end
  describe "client" do
    it 'build client from deserialized session' do
      client = double("client")
      DropboxSession.should_receive(:deserialize).once.and_return(double("session"))
      DropboxClient.should_receive(:new).once.and_return(client)
      account = DropboxAccount.new(serialized_session: 'i am a serialized session')
      account.extend DBSession
      account.client.should be client
    end 
    it 'returns cached client when available' do
      client = double("client")
      DropboxSession.should_receive(:deserialize).once.and_return(double("session"))
      DropboxClient.should_receive(:new).once.and_return(client)
      account = DropboxAccount.new(serialized_client: 'i am a serialized session')
      account.extend DBSession
      account.client.should be client
      account.client.should be client
    end
  end
end
