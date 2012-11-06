require "data.rb"
require "roles.rb"
describe Download, "download" do
  before do
    @uri = 'http://users.ecs.soton.ac.uk/srg/publications/pdf/SVM.pdf'
    resource=Resource.new(:uri => @uri)
    @download = resource.extend(Download)
    @client = double('client')
    @client.stub(:put_file => {"path" => '/SVM.pdf', "bytes" => 8*1024*1024, "size" => '8 Mb'})
  end
  it 'uses the dropbox client to perform the download' do
    @client.should_receive(:put_file).with(anything, anything)
    @download.download(@client)
  end
  it 'extracts the resource information' do
    @download.download(@client)
    @download.path.should eq('/SVM.pdf')
    @download.bytes.should eq(8*1024*1024)
    @download.size.should eq('8 Mb')
  end
end
