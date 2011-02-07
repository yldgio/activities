class Task < ActiveRecord::Base
  RECURRING = %w(daily weekly monthly)
  has_many :activities, :order => 'activities.created_at DESC'
  validates_inclusion_of :recurring, :in => RECURRING

  scope :recurring, lambda {|schedule| 
                       RECURRING.include?(schedule) ? where(:recurring=>schedule) : all
                    }
  def self.recurring_range(schedule, from=Time.now)
    from = from.beginning_of_day
    case schedule
      when 'daily'
        (from..from.end_of_day)
      when 'weekly'
        (from.beginning_of_week..from.end_of_week)
      when 'monthly'
        (from.beginning_of_month..from.end_of_month)
    end
  end
  def self.setup_activities
    Task.all.each do |task|
      task.recurring_activity
    end
  end
  def recurring_activity(from=Time.now)
    #FIXME: kind of hack, until we have a scheduled job that calls setup_activities every day
    recurring_activities(from).first || Activity.from_task(self, from)
  end

  def recurring_activities(from=Time.now)
    rng = recurring_range(from)
    self.activities.where('activities.created_at BETWEEN ? AND ?', rng.begin, rng.end)
  end
  def recurring_start(from=Time.now)
    recurring_range(from).begin
  end
  def recurring_range(from=Time.now)
    Task.recurring_range(self.recurring, from)
  end

end
