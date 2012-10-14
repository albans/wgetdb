require 'repository'
require 'data.rb'

uri = "http://users.ecs.soton.ac.uk/srg/publications/pdf/SVM.pdf"

describe Resource, "storing" do
  before do
    @resource = Resource.new(:id=>1, :uri=>uri)
    @repository = Repository[Resource]
  end
  it "Adds a resource to the repository" do
    @repository << @resource
    @repository.size.should be 1
  end
  it "Finds a resource by id" do
    @repository.store(@resource)
    @repository.search(@resource.id)
  end
end
