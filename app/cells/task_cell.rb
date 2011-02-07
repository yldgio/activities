class TaskCell < Cell::Rails

  def summary
    @from = params[:from] || Time.now#.beginning_of_week
    @summary = Task::RECURRING.inject({}){|sum, schedule|
      sum[schedule.to_sym] ||= {}
      sum[schedule.to_sym][:due_tasks] = Task.recurring(schedule)
      sum[schedule.to_sym][:activities] = Activity.summary(schedule, @from)
      sum
    }
    render
  end

end
