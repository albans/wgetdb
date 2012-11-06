require 'data.rb'
require 'roles.rb'
require 'dropbox_sdk'

APP_KEY='APP_KEY'
APP_SECRET='APP_SECRET'
AUTHORIZE_URL='AUTHORIZE_URL'
SERIALIZED='s'
describe DBSession do
  describe "get_authorize_url" do
    it 'return a url for a valid dropbox account' do
      session = double("session")
      session.should_receive(:get_request_token)
      session.should_receive(:get_authorize_url).and_return(AUTHORIZE_URL)
      DropboxSession.should_receive(:new).once.and_return(session)
      account = DropboxAccount.new(app_key: APP_KEY, app_secret: APP_SECRET)
      account.extend DBSession
      account.get_authorize_url.should_not be nil      
    end
  end
  describe 'authorize' do
    it 'get the sessions access token' do
      session = double("session")
      session.should_receive(:get_access_token)
      session.should_receive(:serialize).and_return('serialized')
      DropboxSession.should_receive(:deserialize).and_return(session)
      account = DropboxAccount.new(app_key: APP_KEY, app_secret: APP_SECRET, serialized_session: SERIALIZED)
      account.extend DBSession
      account.authorize
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
