class UpdateUsers < ActiveRecord::Migration
  def self.up
    drop_table :users
    create_table :users do |t|
      t.string :first_name, :default => "", :null => false
      t.string :last_name, :default => "", :null => false
      t.string :role, :null => false
      t.string :email, :null => false
      t.boolean :status, :default => false
      t.string :token, :null => false
      t.string :salt, :null => false
      t.string :crypted_password, :null => false
      t.string :preferences
      t.timestamps
    end
    add_index :users, :email, :unique => true
  end

  def self.down
    drop_table :users
    create_table :users do |t|
      t.string :name
      t.string :login
      t.string :email
      t.string :status
      t.timestamps
    end
  end
end
