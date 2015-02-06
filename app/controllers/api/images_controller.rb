module API
  class ImagesController < ApplicationController
    protect_from_forgery with: :null_session
    respond_to :json, :html, :xml
    
    def index
      respond_with Image.all
    end

  end
end
