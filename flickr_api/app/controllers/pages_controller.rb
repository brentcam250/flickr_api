class PagesController < ApplicationController
    def show
        @flickr = Flickr.new(ENV["flickr_key"], ENV["flickr_secret"])

        unless params[:flickr_id].nil? || params[:flickr_id].empty?
            begin 
                @params = {user_id: params[:flickr_id]}
                @list = @flickr.people.getPhotos(@params)
            rescue Flickr::FailedResponse => e 
                flash.now.notice = "No user found "
                #just output the recent photos in this case
                @list = @flickr.photos.getRecent

            end

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
        # params.require(:photos).permit(:flickr_id, :page)
        params.require(:id).permit(:flickr_id)
    end


end
