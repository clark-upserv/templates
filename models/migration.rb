# creating typical table
class Whatever < ActiveRecord::Migration[6.0]
  def change  
    create_table :namespace_resources do |t|
      t.references :attribute, null: false, foreign_key: { to_table: 'samespace_sables' }
      t.references :attribute, null: false, foreign_key: true 
      t.string :attribute, null: false
      t.boolean :attribute, default: false
      
      t.timestamps 
    end 

    add_index :namespace_resources, [:attribute, :attribute_2, :attribute3], unique: true, name: 'section_position_index'
  
  end 
end


# one off additions does not need up or down because down would just be to remove the column  
class Whatever < ActiveRecord::Migration[6.0]
  def change
    add_column :table_name, :attribute, :type, <insert options here>
    add_reference :table_name, :attribute, <insert options here>
  end
end

# one off changes - needs up and down because rails doesn't know what column was like before the change. NOTE: Idk if this is correct
class Whatever < ActiveRecord::Migration[6.0]
  def up
    change_column :table_name, :attribute, :type, <insert options here>
  end

  def down #??? I'm not sure if this is correct but idk
    change_column :table_name, :attribute, :type, <insert options here>
  end
end

# creating table with case insensitive index 
class Whatever < ActiveRecord::Migration[6.0]
  def up
    create_table :namespace_resources do |t|
      # create attributes 
      
      # t.timestamps 
    end 

    # NOTE: this will create an index on the lower (or "downcased") version of the attribute. If you want to have a case sensitive search, you will need to also create a case sensitive index (which can be done with the typtical rails add_index). However, pretty much all of our searches use ILIKE which searches case insensitive so creating an additional case sensitive index is not typically necessary. It would only be necessary to have both indexes if you have a wierd situation where you want case insensitive uniqueness AND case sensitive search (which makes no sense at all but just fyi thought you should know) 
    execute <<-SQL
      CREATE UNIQUE INDEX index_table_name_on_lower_attribute_1_and_attribute_2 ON table_name(LOWER(attribute_1), attribute_2);
    SQL
  end
  
  def down 
    # if migration created table, you can just drop the table and it will drop the table as well as the index (and any foreign keys related to the table, etc.)
    drop_table :namespace_resources
    # if you did not create a table, then you cannot just use drop-table and instead need to remove the specific index
    # remove_index :index_table_name_on_lower_attribute_1_and_attribute_2
  end
end

