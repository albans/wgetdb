require 'data.rb'
require 'contexts.rb'

APP_KEY='APP_KEY'
APP_SECRET='APP_SECRET'

describe LogIntoDropboxAccount do
  before do
    @context = LogIntoDropboxAccount.new(APP_KEY, APP_SECRET)
  end

  it 'creates a pending DropboxAccount and return notify success callback with auth url' do
    
  end 
end
