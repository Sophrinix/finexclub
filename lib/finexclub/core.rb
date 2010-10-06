require 'singleton'

module Finexclub
  class Core
    include Singleton

    attr_reader :images
    attr_reader :signals

    def initialize
      @images = Images.new(self)
      @signals = Manager.new(self)
    end

    def configure(&block)
      yield self
      self
    end

    def store(signal_type, params)
      params = params.is_a?(Array) ? params : [params]
      params.each do |s|
        signals.add_signal(signal_type, s)
      end
    end

    def find(symbol, date)
      if symbol == :all
        signals.find(:date => date)
      else
        signals.find_one(:date => date, :symbol => symbol)
      end
    end
  end
end

