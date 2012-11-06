require 'data.rb'
require 'contexts.rb'
RESOURCE='http://example/resource.pdf'
META={size: 1000}

def download_successfull(o)
  @download_meta = o
end
describe DownloadResource do
  before do 
    client=double('client')
    Download.stub :extended do |base|
      base.should_receive(:download).with(client).and_return(META)
    end
    Store.stub :extended do |base|
      base.should_receive(:store)
    end
    DBSession.stub :extended do |base|
      base.should_receive(:client).and_return(client)
    end
    @context=DownloadResource.new(RESOURCE, method(:download_successfull))
  end
  it 'uses Downloadable role to download resource argument into the dropbox application folder' do
    @context.run
    @download_meta.should be META 
  end
end
