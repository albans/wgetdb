require 'active_record'
module DatabaseHelpers
  def self.make_db
    ActiveRecord::Schema.define do 
      if (!table_exists?(:resources))
        create_table (:resources) do |t|
          t.column :uri, :string
          t.column :path, :string
          t.column :size, :string
          t.column :bytes, :integer
        end
      end
    end
  end
end
if !@database_created
  DatabaseHelpers::make_db
  @database_created=true
end
