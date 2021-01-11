class StaticPagesController < ActionController::Base

    def home
        @flickr = Flickr.new

    end
end
