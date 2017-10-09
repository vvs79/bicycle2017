include ActionView::Helpers::TextHelper

class BikesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :my_bikes, :edit, :update, :destroy, :not_use]
  before_action :get_bike, only: [:update, :destroy, :select_image, :not_use]
  before_action :check_if_admin, only: [:all]

  def all# for admin
    @bikes = Bike.all
    @comments = Comment.all
  end

  def index
    @bikes = (params[:category_id] && !params[:search]) ? Bike.where(category_id: params[:category_id]) : Bike.all
    @bikes = (user_signed_in?) ? @bikes.used_bikes(current_user.id) : @bikes
    @bikes = @bikes.search_name(params[:search]) if params[:search]
    @bikes = current_user.bikes if params[:my_bikes]
    # if params[:check_my_bikes]
    @bikes = current_user.bikes.map {|bike| delete(bike) if !bike.comment} if params[:check_my_bikes]
    # @bikes.index_by(&:id) if @bikes.kind_of?(Array)
    @bikes = @bikes.paginate(page: params[:page] || 1, per_page: 6).order(updated_at: :desc)
  end

  def show
    @bike = Bike.find(params[:id])
    @image = (@bike.images.count > 0) ? @bike.images[0].url : 'http://i.piccy.info/i9/3880e13ce4a1fe024c880a9cdd712a2d/1507479121/15242/1185977/default_img.jpg'
  rescue ActiveRecord::RecordNotFound
    flash[:danger] = 'Bike does not exist'
    redirect_to bikes_path
  end

  def edit
    @bike = Bike.find(params[:id])
    @image = (@bike.images.count > 0) ? @bike.images[0].url : 'http://i.piccy.info/i9/3880e13ce4a1fe024c880a9cdd712a2d/1507479121/15242/1185977/default_img.jpg'
  rescue ActiveRecord::RecordNotFound
    flash[:danger] = 'Bike does not exist'
    redirect_to bikes_path
  end

  def update
    if @bike.update_attributes(bike_params)
      @bike.comment.destroy
      flash.now[:success] = 'Bike was updated'
      redirect_to bikes_path
    else
      render 'edit'
    end
  end

  def new
    @bike = current_user.bikes.new(user_id: current_user.id, used_bike: '')
  end

  def create
    @bike = current_user.bikes.new(bike_params)
    if @bike.save
      flash.now[:success] = 'Bike was created'
      redirect_to bikes_path
    else
      render 'new'
    end
  end

  def destroy
    @bike.destroy
    flash.now[:success] = 'Bike was deleted'
    redirect_to :back
  end

  def select_image
    @images = Bike.find(params[:id]).images
    @image = params[:image_param]
    render 'show'
  end

  def not_use
    @bike.update(used_bike: @bike.used_bike + ',' + current_user.id.to_s + ',')
    redirect_to bikes_path
  end

  private

    def get_bike
      @bike = Bike.find(params[:id])
    end

    def bike_params
      params.require(:bike).permit(:name, :description, {images: []}, :user_id, :used_bike, :category_id)
    end

end