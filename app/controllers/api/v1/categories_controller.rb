module Api
  module V1
    class CategoriesController < ApplicationController
      before_action :set_category, only: [:show, :edit]

      def index
        @categories = Category.all
        render json: @categories
      end

      def show
        render json: @category
      end

      private

      def set_category
        @category = Category.find(params[:id])
      end

      def categories_params
        params.permit(:name, :description)
      end
    end
  end
end
