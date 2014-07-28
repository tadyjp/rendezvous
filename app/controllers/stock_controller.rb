class StockController < ApplicationController

  def show
    @posts = Post.all.count
  end
end
