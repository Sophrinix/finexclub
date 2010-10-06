module Finexclub
  module Signals

    class Zeta < Signal
      field :symbol, :symbol
      field :updated, :timestamp

      field :up_support,   :float
      field :up_resist,    :float
      field :down_support, :float
      field :down_resist,  :float
      field :screenshot,   :image

      doc_fields :up_support, :up_resist, :down_support, :down_resist, :screenshot, :updated

      def up_channel?
        up_support != 0 && up_resist != 0
      end
      
      def down_channel?
        down_support != 0 && down_resist != 0
      end
    end

  end
end
