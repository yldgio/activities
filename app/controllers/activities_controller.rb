class ActivitiesController < ApplicationController
  before_filter :find_tasks
  def index
  end
  def show
    raise 'not implemented'
  end
  def create
    @activity = Activity.new(params[:activity])
    if @activity.save
      flash[:notice] = "activity for #{@activity.task.name} created"
    else
      flash[:errors] = @activity.errors
    end
    render :action=>:index      
  end
  def update
    @activity = Activity.find(params[:id])
    if @activity.update_attributes(params[:activity])
      flash[:notice] = "activity for #{@activity.task.name} updated"
    else
      flash[:errors] = @activity.errors
    end
    render :action=>:index      
  end
private
  def find_tasks
    @recurring = params[:recurring] || 'daily'
    @tasks = Task.recurring(@recurring).order('name')
  end
end
