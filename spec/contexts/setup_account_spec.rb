require 'data.rb'
require 'contexts.rb'
require 'repository'
APP_KEY='APP_KEY'
APP_SECRET='APP_SECRET'

def auth_url=(auth_url)
  @auth_url = auth_url
end
describe LogIntoDropboxAccount do
  before do
    @auth_url=nil
    @context = LogIntoDropboxAccount.new(APP_KEY, APP_SECRET, method(:auth_url=))
  end
  
  it 'creates a pending DropboxAccount' do
    @context.run
    Repository[DropboxAccount].size.should be(1)
  end 
  it 'should notify success callback with auth_url as argument' do
  end
end
