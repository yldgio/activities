class ModifyActivitiesAndTasks < ActiveRecord::Migration
  def self.up
    rename_column :tasks, :schedule, :recurring
    add_column :activities, :user_id, :int
    add_column :activities, :duration, :int
  end

  def self.down
    rename_column :tasks, :recurring, :schedule
    remove_column :activities, :user_id
    remove_column :activities, :duration
  end
end
