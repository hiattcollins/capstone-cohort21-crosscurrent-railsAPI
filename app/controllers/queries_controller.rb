class QueriesController < ApplicationController

  # index, show, new, edit, create, update and destroy

  def index
    @queries = Query.all
    render json: @queries
  end

  def show
    set_query
    render json: @query
  end

  def create
    @query = Query.new(query_params)

    if @query.save
        render json: @query, status: :created, location: @query
      else
        render json: @query.errors, staus: :unprocessable_entity
    end
  end

  def update
    set_query
    if @query.update(query_params)
      redirect_to @query
    else
      render 'edit'
    end
  end

  def destroy
    set_query
    @query.destroy
  end

  private

    def set_query
      @query = Query.find(params[:id])
    end

    def query_params
      params.require(:query).permit(:user_id)
    end

end
