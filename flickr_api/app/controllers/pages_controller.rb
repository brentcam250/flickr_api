class PagesController < ApplicationController
    def show
        @flickr = Flickr.new(ENV["flickr_key"], ENV["flickr_secret"])
        @list = @flickr.photos.getRecent

        if valid_page?
            render template: "pages/#{params[:page]}"            
        else
            render file: "public/404.html", status: :not_found
        end
    end

    # def home
    #     @flickr = Flickr.new(ENV["flickr_key"], ENV["flickr_secret"])
    # end

    private 
    def valid_page?
        File.exists?(Pathname.new(Rails.root + "app/views/pages/#{params[:page]}.html.erb"))
    end


end
