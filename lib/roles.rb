require 'open-uri'
require 'repository'
require 'dropbox_sdk'
module Download 
  def download(dp_client)
   meta = dp_client.put_file(File.basename(uri), open(uri))
   update_attributes(:path=>meta["path"], :bytes=>meta["bytes"], :size=>meta["size"])
   return meta
  end
end
module Store 
  def store 
   self.id=Repository[self.class].size+1 unless self.id!=nil
   Repository[self.class].store(self)
  end
  def self.find_by_id(type, id)
    Repository[type][id]
  end
  def self.find_all(type)
    Repository[type].search(Repository::Criterion::Factory.all)
  end
end
module DBSession
  def get_authorize_url
    session=DropboxSession.new(self.app_key, self.app_secret)
    session.get_request_token
    @session=session
    session.get_authorize_url
  end
  def authorize
    session.get_access_token
    self.serialized_session = session.serialize
  end
  def client
    make_client unless @client
    @client
  end
  def session=(session)
    puts "session is set..."
    @session=session
  end
  def session 
    make_session unless @session
    @session
  end
  
  private
  def make_client 
    @client = DropboxClient.new(session)
  end
  def make_session
    @session = DropboxSession.deserialize(serialized_session)  
  end
end    
