require "sinatra/base"
require "ap"

module Finexclub
  class App < Sinatra::Base

    configure :development do
      Finexclub.configure do |f|
        f.signals.db = Mongo::Connection.new.db("finexclub_dev")
        f.images.screenshot_path = ENV['SCREENSHOT_PATH']
      end
    end

    configure :production do
      Finexclub.configure do |f|
        f.signals.db = Mongo::Connection.from_uri(ENV['MONGOHQ_URL']).db(ENV['MONGOHQ_DB'])
        f.images.screenshot_path = ENV['SCREENSHOT_PATH']
        f.images.configure_with(:heroku, ENV['S3_BUCKET'])
      end
    end

    post "/:signal" do
      signal_type = params[:signal].to_sym
      ap params[signal_type]
      Finexclub.store(signal_type, params[signal_type]) 
      status 200
    end
  end
end
