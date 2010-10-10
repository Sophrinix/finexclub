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

    def find(symbol_or_array, date)
      case symbol_or_array
      when :all
        signals.find(:date => date)
      when Array
        signals.find(:date => date, :symbol => {:$in => symbol_or_array})
      when String
        signals.find_one(:date => date, :symbol => symbol_or_array)
      end
    end
  end
end

