class Activity < ActiveRecord::Base
  belongs_to :task
  belongs_to :author, :class_name=>"User", :foreign_key=>:user_id
  validates_presence_of :task_id
  STATUS = %w(completed error waiting)
  validates_inclusion_of :status, :in => STATUS

  def self.from_task(_task, from=Time.now)
    create!(:task=>_task, :name=>_task.name, :description=>_task.description, :status=>'waiting', :created_at=>from)
  end
  def self.summary(recurring, from=Time.now)
    rng = Task.recurring_range(recurring, from)
    self.select('COUNT(*) as num, activities.status, DATE(activities.created_at) as created_at')
          .joins(:task)
          .where("tasks.recurring = ? AND activities.created_at BETWEEN ? AND ?", recurring, rng.begin, rng.end)
          .group('DATE(activities.created_at), activities.status')
  end

#    self.select('COUNT(*) as num, activities.status, DATE(activities.created_at) as created_at')
#          .joins(:task)
#          .where("tasks.recurring = 'daily' AND activities.created_at BETWEEN ? AND ?", from, from.end_of_day)
#          .group('DATE(activities.created_at), activities.status')


end
