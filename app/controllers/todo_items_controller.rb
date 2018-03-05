class TodoItemsController < ApplicationController
  before_action :set_todo_list
  before_action :set_todo_item, except: [:create]

  # def new
	# 	@item = current_user.items.build
  # end
  # def show
  # end

  def create
    # @todo_item = @todo_list.todo_items.create(todo_item_params)
    if current_user.todo_lists.find(set_todo_list.id).todo_items.count>0
	    priority = current_user.todo_lists.find(set_todo_list.id).todo_items.maximum(:priority)+1
	  else
	    priority = 0
    end
    @todo_item = @todo_list.todo_items.create(todo_item_params)
    @todo_item.update_attribute(:priority, priority)
		redirect_to @todo_list
  end

  def edit
  end

  def update
    # @todo_item.update_attribute(:completed_at, Time.now)
    # deadline = @todo_item.deadline
    if @todo_item.update(todo_item_params)
      # @todo_item = @todo_list.todo_items.create(todo_item_params)
      # @todo_item_change = @todo_item.find(deadline: deadline)
      # @todo_item_change.save
      redirect_to @todo_list
      # format.html { redirect_to @todo_item, notice: 'Task was successfully updated.' }
      # format.json { render :show, status: :ok, location: @todo_item }
    else
      flash[:error] = "Todo List item coul not be edited."
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
    # @t = @todo_list.todo_items.find_by(id: params[:id])
	  # @t.destroy
    #
	  # @todo_lists = current_user.todo_lists.order(:id)
	  #   respond_to do |format|
    #     format.html {redirect_to todolists_path}
    #     format.js {render action: 'script.js.erb'}
    #   end
  end

  def complete
    @todo_item.update_attribute(:completed_at, Time.now)
    redirect_to @todo_list #, notice: "Todo item complited"
  end

  def uncomplete
    @todo_item.update_attribute(:completed_at, nil)
    redirect_to @todo_list #, notice: "Todo item uncomplited"
  end

  def priority_up
    @todo_list_cur = current_user.todo_lists.find(@todo_item.todo_list_id)
    if @todo_item.priority != @todo_list_cur.todo_items.minimum(:priority)
  	  @todo_item_to_change=@todo_list_cur.todo_items.find_by(priority: (@todo_item.priority-1))
  	  @todo_item_to_change.priority += 1
  	  @todo_item_to_change.save
  	  @todo_item.priority -= 1
      @todo_item.save
      redirect_to @todo_list
      # @todo_lists = current_user.todo_lists.order(:id)
	    # respond_to do |format|
      #   format.html {redirect_to todolists_path}
      #   format.js {render action: 'script.js.erb'}
      # end
    end
  end

  def priority_down
    @todo_list_cur=current_user.todo_lists.find(@todo_item.todo_list_id)
    if @todo_item.priority != @todo_list_cur.todo_items.maximum(:priority)
  	  @todo_item_to_change=@todo_list_cur.todo_items.find_by(priority: (@todo_item.priority+1))
  	  @todo_item_to_change.priority -= 1
  	  @todo_item_to_change.save
  	  @todo_item.priority += 1
      @todo_item.save
      redirect_to @todo_list
    end
  end

  private
    def set_todo_list
      @todo_list = TodoList.find(params[:todo_list_id])
    end

  	def set_todo_item
  		@todo_item = @todo_list.todo_items.find(params[:id])
  	end

    def todo_item_params
  		params[:todo_item].permit(:content, :deadline, :completed_at)
    end
end
