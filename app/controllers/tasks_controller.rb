class TasksController < ApplicationController
	before_action :authenticate_user!
  before_action :set_task, only: [:show, :edit, :update, :destroy]
	respond_to :html

  def index
    @tasks = current_user.tasks
    respond_with(@tasks)
  end

  def show
  end

  def new
    @task = Task.new
  end

  def edit
  end
	
  def create
    @task = current_user.tasks.new(task_params)
    @task.save
    respond_with(@task)
  end
	
	def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end
	
	def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
	
	private
    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:content, :user_id, :priority, :description)
    end
end