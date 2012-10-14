module TestHelpers
  def self.establish_database_connection
    ActiveRecord::Base.establish_connection(
      :adapter  => 'sqlite3',
      :database => "test/db/test_database.sqlite3" 
    )
  end
end
if !@establish 
  TestHelpers::establish_database_connection
  require "database_helpers"
  @establish=true
end
