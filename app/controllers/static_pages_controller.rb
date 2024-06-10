class StaticPagesController < ApplicationController
  before_action :flickr_initilization

  def index
    flickr_id = params[:flickr_id]

    begin
      if flickr_id.present?
        @photos = @flickr.photos.search(user_id: flickr_id, extras: "owner_name")
        @author = true
      else
        @photos = @flickr.photos.getRecent
      end
    rescue Flickr::FailedResponse => e
      @error = "Error with connection to Flickr API: #{e.message}"
      @photos = []
    end
  end

  private

  def flickr_initilization
    @flickr = Flickr.new Figaro.env.flickr_api_key, Figaro.env.flickr_shared_secret
  end
end
