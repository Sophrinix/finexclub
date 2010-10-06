module Finexclub
  class Signal
    include Finexclub::Document
    attr_reader :core

    def initialize(core, meta = {})
      @core = core
      apply_meta(meta)
    end

    class << self
      def handler_for(signal_type)
        #class_name = signal_type.to_s.gsub(/\/(.?)/) { "::#{$1.upcase}" }.gsub(/(?:^|_)(.)/) { $1.upcase }
        class_name = signal_type.to_s.gsub(/^(.)/) { $1.upcase }
        Finexclub::Signals.const_get(class_name)
      end

      def build(core, signal_type, params)
        signal = handler_for(signal_type).new(core)
        signal.build(params)
        signal
      end
    end

  end
end

