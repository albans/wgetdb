require 'open-uri'
require 'repository'
require 'dropbox_sdk'
module Download 
  def download(dp_client)
   meta = dp_client.put_file(open(uri))
   update_attributes(:path=>meta[:path], :bytes=>meta[:bytes], :size=>meta[:size])
  end
end
module Store 
  def store 
   Repository[self.class].store(self)
  end
  def self.find_by_id(type, id)
    Repository[type][id]
  end
end
module DBSession
  def get_authorize_url
    session = DropboxSession.new(self.app_key, self.app_secret)
    session.get_request_token
    self.serialized_session = session.serialize
    session.get_authorize_url
  end
  def client
    make_client unless @client
    @client
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
