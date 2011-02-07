class CreateTasks < ActiveRecord::Migration
  def self.up
    create_table :tasks do |t|
      t.string :name
      t.text :description
      t.string :type
      t.string :schedule
      t.text :notes
      t.text :settings

      t.timestamps
    end
  end

  def self.down
    drop_table :tasks
  end
end
