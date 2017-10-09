include ActionView::Helpers::TextHelper

class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_comment, only: [:show, :destroy]

  def index
    arr_id = []
    current_user.bikes.each { |bike| arr_id.push(bike.id) }
    @comments = Comment.where('bike_id IN (?)', arr_id)
  end


  def show
  rescue ActiveRecord::RecordNotFound
    flash.now[:danger] = 'Comment does not exist'
    redirect_to bikes_path
  end

  def new
    @comment = Comment.new(name: params[:name], description: params[:description], bike_id: params[:id])
  end

  def create
     @comment = Comment.new(comment_params)
    if @comment.save
      bike = Bike.find(@comment.bike_id)
      BikesMailer.bike_edit(bike, bike.user).deliver_now
      redirect_to bikes_path
    else
      render 'new'
    end
  end

  def destroy
    @comment.destroy
    flash.now[:success] = 'Comment was deleted'
    redirect_to bikes_path
  end

  private

    def get_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:name, :description, :bike_id)
    end

end