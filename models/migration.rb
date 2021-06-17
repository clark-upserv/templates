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

  end 
end
