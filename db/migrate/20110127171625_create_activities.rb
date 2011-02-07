class CreateActivities < ActiveRecord::Migration
  def self.up
    create_table :activities do |t|
      t.string :name
      t.text :description
      t.string :type
      t.text :notes
      t.belongs_to :task
      t.string :status

      t.timestamps
    end
  end

  def self.down
    drop_table :activities
  end
end
