module Finexclub
  module Signals

    class Alpha < Signal
      field :symbol, :symbol
      field :updated, :timestamp
      field :index, :integer
      field :direction, :integer

      doc_fields :updated, :index, :direction

      def trend
        direction == 1 ? :bullish : :bearish
      end
      
      def stability
        case index
          when 100 then :confirmed
          when 90..99 then :high
          when 80..89 then :medium
          when 70..79 then :low
          else :unstable
        end
      end
    end

  end
end
