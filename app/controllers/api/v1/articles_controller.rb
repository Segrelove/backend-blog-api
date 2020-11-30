module Api
  module V1
    class ArticlesController < ApplicationController
      before_action :authorize_access_request!, except: [:show, :index]
      before_action :set_article, only: [:show, :edit, :update, :destroy]
      
      def index
        @articles = current_author.articles.all

        render json: @articles
      end

      def show
        render json: @article
      end

      #POST /articles/
      def create
        @article = current_author.articles.build(article_params)

        if @article.save
          render json: @article, status: :created
        else
          render json: @article.errors.messages.join(' '), status: :unprocessable_entity
        end
      end

      def update
        if @article.update(article_params)
          render json: @article
        else
          render json: @article.errors.messages.join(' '), status: :unprocessable_entity
        end
      end

      def destroy
        @article.destroy
      end

      private

      def set_article
        @article = current_author.records.find(params[:id])
      end

      def article_params
        params.require(:article).permit(:title, :content, :category_id)
      end
    end
  end
end

