require "dragonfly"

module Finexclub
  class Images
    extend Forwardable

    attr_reader :core
    attr_reader :app
    attr_accessor :screenshot_path

    def_delegators :app, :configure, :configure_with, :fetch
    
    def initialize(core)
      @core = core
      @app = Dragonfly[:images]
      @app.configure_with(:rmagick) do |c|
        c.url_path_prefix = "/media"
      end
    end

    def store(filename)
      path = File.expand_path(File.join(screenshot_path, filename))
      app.store(File.new(path))
    end

    class Middleware < Dragonfly::Middleware
      def initialize(app, path_prefix = nil)
        path_prefix ||= Dragonfly[:images].url_path_prefix
        super(app, :images, path_prefix)
      end
    end
  end
end

