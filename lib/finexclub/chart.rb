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

    def alpha=(arr)
      @signals[:alpha]= arr
    end

    def zeta=(arr)
      @signals[:zeta]= arr
    end

    def signals(type)
      @signals[type]
    end

    def alpha
      Signal.build(core, :alpha, signals(:alpha).last)
    end
    
    def zeta
      Signal.build(core, :zeta, signals(:zeta).last)
    end

    def to_doc
      {:symbol => symbol, :date => updated_date}
    end
  end
end
