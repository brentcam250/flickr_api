class PagesController < ApplicationController
    def show
        render template: "pages/#{params[:page]}"
    end

    def base
        @flickr = Flickr.new(ENV["flickr_key"], ENV["flickr_secret"])
    end
end
