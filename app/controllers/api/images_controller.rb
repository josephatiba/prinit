module API
  class ImagesController < ApplicationController
    protect_from_forgery with: :null_session
    respond_to :json, :html, :xml
    
    def index
      @images = Image.all
      respond_with Image.all
    end

    def show
      @image = Image.find(params[:id])
    end

    def new
      @image = Image.new
    end

    def create
      @image = Image.new(image_params)

      if @image.save
        redirect_to images_path
      else
        render 'new'
      end
    end

    def edit
      @image = Image.find(params[:id])
    end

    def update
      if @image.update(image_params)
        redirect_to @image
      else
        render 'edit'
      end
    end

    def destroy
      image.destroy
      redirect_to root_path
    end

    private

    def image_params
      params.require(:image).permit(:url, :name, :private, :image)
    end

  end
end
