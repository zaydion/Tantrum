class PostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy

  def index
    @post = Post.all
  end


  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "your rant has been posted."
       redirect_to '/'
    else
      flash[:alert] = "Your rant might have been too long.. 240 characters max."
      redirect_to new_user_path
    end
  end

  def destroy
    @post.destroy
    flash[:success] = "your rant has been deleted."
    redirect_to '/'
  end




  private

  def post_params
    params.require(:post).permit(:content)
  end

  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    redirect_to '/' if @post.nil?
  end
end

