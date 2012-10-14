class Resource
  def initialize(properties)
    update_attributes(properties)
  end
  def update_attributes(properties)
    @id = properties[:id]
    @uri = properties[:uri]
    @path = properties[:path]
    @bytes = properties[:bytes]
    @size = properties[:size]
  end
  def id=(id)
    @id = id
  end
  def id
    @id
  end
  def uri=(uri)
    @uri = uri
  end
  def uri
    @uri
  end
  def path=(path)
    @path = path
  end
  def path
    @path
  end
  def bytes=(bytes)
    @bytes = bytes
  end
  def bytes
    @bytes
  end
  def size=(size)
    @size = size
  end
  def size
    @size
  end
end

class DropboxAccount
  def initialize(properties)
    update_attributes(properties)
  end
  def update_attributes(properties)
    @id = properties[:id]  
    @app_key = properties[:app_key]  
    @app_secret = properties[:app_secret]  
    @serialized_client = properties[:serialized_client]  
    @serialized_session = properties[:serialized_session]  
  end
  def id=(id)
    @id=id
  end
  def serialized_session=(serialized_session)
    @serialized_session = serialized_session
  end
  def serialized_session
    @serialized_session
  end 
  def id
    @id
  end
  def app_key=(app_key)
    @app_key = app_key
  end
  def app_key
    @app_key
  end
  def app_secret=(app_secret)
    @app_secret = app_secret
  end
  def app_secret
    @app_secret
  end
  def serialized_client=(serialized_client)
    @serialized_client = serialized_client
  end
  def serialized_client
    @serialized_client
  end
end
