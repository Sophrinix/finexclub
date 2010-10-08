module Finexclub
  class Chart
    SYMBOLS = %w(chfjpy eurchf audusd audcad eurnzd nzdusd gbpchf nzdcad usdcad cadjpy audjpy euraud gbpnzd nzdjpy eurusd usdjpy eurcad cadchf gbpaud gbpusd audchf eurjpy gbpcad usdchf nzdchf audnzd eurgbp gbpjpy)

    include Document

    field :updated, :timestamp
    field :symbol, :symbol
    field :date, :string

    attr_reader :core

    def initialize(core)
      @core = core
      @signals = {}
    end

    [:alpha, :zeta, :octopus, :prognosis].each do |indicator|
      define_method("#{indicator}=") do |arr|
        @signals[indicator] = arr
      end

      define_method(indicator) do
        Signal.build(core, indicator, signals(indicator).last)
      end
    end

    def signals(indicator)
      @signals[indicator]
    end
    
    def to_doc
      {:symbol => symbol, :date => updated_date}
    end
  end
end
