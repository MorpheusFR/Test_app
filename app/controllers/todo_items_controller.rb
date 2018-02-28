class TodoItemsController < ApplicationController
  before_action :set_todo_list
  before_action :set_todo_item, except: [:edit, :update, :destroy]

  def create
		@todo_item = @todo_list.todo_items.create(todo_item_params)
		redirect_to @todo_list
  end

  def edit
  end

  def update
    if @todo_item.update(todo_item_params)
      redirect_to @todo_list
      # format.html { redirect_to @todo_item, notice: 'Task was successfully updated.' }
      # format.json { render :show, status: :ok, location: @todo_item }
    else
      # flash[:error] = "Todo List item coul not be edited."
      render 'edit'
    end
  end

  def destroy
    if @todo_item.destroy
      flash[:success] = "Todo List item was deleted."
    else
      flash[:error] = "Todo List item coul not be deleted."
    end
    redirect_to @todo_list
  end

  def complete
    @todo_item.update_attribute(:completed_at, Time.now)
    redirect_to @todo_list, notice: "Todo item complited"
  end

  def priority_up
  end

  def priority_down
  end

  private
    def set_todo_list
  		@todo_list = TodoList.find(params[:todo_list_id])
  	end

  	def set_todo_item
  		@todo_item = @todo_list.todo_items.find(params[:id])
  	end

  	def todo_item_params
  		params[:todo_item].permit(:content)
    end
end
