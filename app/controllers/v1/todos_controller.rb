module V1
class TodosController < ApplicationController
    before_action :set_todo, only: [:show, :update, :destroy]

    # GET /todos
    def index
      # Before auth
      # @todos = Todo.all
      # After auth
      # @todos = current_user.todos
      # After paginating
      @todos = current_user.todos.paginate(page: params[:page], per_page: 20)
      
      json_response(@todos)
    end

    # POST /todos
    def create
      # Before auth
      # @todo = Todo.create!(todo_params)
      # After auth
      @todo = current_user.todos.create!(todo_params)
      
      json_response(@todo, :created)
    end

    # GET /todos/:id
    def show
      json_response(@todo)
    end

    # PUT /todos/:id
    def update
      @todo.update(todo_params)
      head :no_content
    end

    # DELETE /todos/:id
    def destroy
      @todo.destroy
      head :no_content
    end

    private

    def todo_params
      # whitelist params
      # Before auth
      # params.permit(:title, :created_by)
      # After auth
      params.permit(:title)

    end

    def set_todo
      @todo = Todo.find(params[:id])
    end
  end
end