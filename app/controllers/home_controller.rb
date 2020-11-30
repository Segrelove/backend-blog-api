class HomeController < ApplicationController
  def index
    @article = Article.last(5)
    render json: @article
  end
end