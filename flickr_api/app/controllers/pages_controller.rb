class PagesController < ApplicationController
    def show
        @flickr = Flickr.new(ENV["flickr_key"], ENV["flickr_secret"])

        if params[:flickr_id]
            @id = params[:flickr_id].to_s
            @list = @flickr.people.getPhotos(@id)
        else
            @list = @flickr.photos.getRecent
        end
        
        if valid_page?
            render template: "pages/#{params[:page]}"            
        else
            render file: "public/404.html", status: :not_found
        end
    end

    private 
    def valid_page?
        File.exists?(Pathname.new(Rails.root + "app/views/pages/#{params[:page]}.html.erb"))
    end
    
    # Only allow a list of trusted parameters through.
    def photo_params
        # params.fetch(:flight, {})
        params.permit(:flickr_id, :page)
    end


end
