require 'data.rb'
require 'contexts.rb'
require 'repository'
APP_KEY='APP_KEY'
APP_SECRET='APP_SECRET'
AUTH_URL='AUTH_URL'

def auth_url=(auth_url)
  @auth_url = auth_url
end
describe LogIntoDropboxAccount do
  before do
    @auth_url=nil
    @context = LogIntoDropboxAccount.new(APP_KEY, APP_SECRET, method(:auth_url=))
    DBSession.stub :extended do |base|
      base.should_receive(:get_authorize_url).once.and_return(AUTH_URL)
    end
  end
  
  it 'creates a pending DropboxAccount' do
    @context.run
    Repository[DropboxAccount].size.should be(1)
  end 
  it 'should notify success callback with auth_url as argument' do
    @context.run
    @auth_url.should be(AUTH_URL)
  end
end
