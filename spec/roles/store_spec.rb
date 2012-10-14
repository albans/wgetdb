require "data.rb"
require "roles.rb"
describe Store, "Resource" do
  before do
    @uri = 'http://users.ecs.soton.ac.uk/srg/publications/pdf/SVM.pdf'
    resource=Resource.new(:uri => @uri, :id=>1)
    @store=resource.extend(Store)
  end
  it 'persists a resource' do
    @store.store
    Repository[Resource].size.should be(1)
  end
end
describe Store, "DropboxAccount" do
  before do
    account=DropboxAccount.new(:id=>1, :app_key=>'007', :app_secret=>'008', :serialized_client=>'the serialized dropbox client')
    @store = account.extend(Store)
  end
  it 'persists a DropboxAccount' do
    @store.store
    Repository[DropboxAccount].size.should be(1)
  end 
  it 'finds the account by id' do
    @store.store
    Store.find_by_id(DropboxAccount, @store.id).should be @store
  end
end
