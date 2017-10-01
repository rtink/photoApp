class PicsController < ApplicationController
  before_action :find_pic, only: [:show, :edit, :update, :destroy, :upvote]
  before_action :authenticate_user!, except: [:index, :show]
  
  def index
    @pics = Pic.all.order("created_at DESC")
  end
  
  def show
  end
  
  def new
    @pic = current_user.pics.build
  end
  
  def create
    @pic = current_user.pics.build(pic_params)
    
    if @pic.save
      flash[:success] = "Congrats! Pic was posted!"
      redirect_to @pic
    else
      flash[:danger] = "Oops! Pic was not posted. Try again."
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @pic.update(pic_params)
      flash[:warning] = "Yea! Pic was updated!"
      redirect_to @pic
    else
      flash[:danger] = "Yikes! Pic was not updated. Try again."
      render 'edit'
    end
  end
  
  def destroy
    @pic.destroy
    flash[:danger] = "Your pic was deleted!" 
    redirect_to root_path
  end
  
  def upvote
    @pic.upvote_by current_user
    redirect_back fallback_location: root_path
  end
  
  private
  
  def pic_params
    params.require(:pic).permit(:title, :description, :image)
  end
  
  def find_pic
    @pic = Pic.find(params[:id])
  end
  
end
