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
