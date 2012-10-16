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
    it 'deserializes client from account when serialized_client is not nil' do
      client = double("client")
      DropboxClient.stub(:deserialize){client}
      account = DropboxAccount.new(serialized_client: 'i am a serialized client')
      account.extend DBSession
      account.client.should be client
    end 
    it 'returns cached client when available' do
      DropboxClient.should_receive(:deserialize).once.and_return(client)
      client = double("client")
      account = DropboxAccount.new(serialized_client: 'i am a serialized client')
      account.extend DBSession
      account.client.should be client
      account.client.should be client
    end
  end
end
