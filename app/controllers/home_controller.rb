class HomeController < ApplicationController
  def index
    @post = Post.new
    @post = current_user.posts.build if logged_in?
  end

  def home

  end
end
