module Finexclub
  module Signals

    class Prognosis < Signal
      field :symbol, :symbol
      field :updated, :timestamp
      field :action, :string
      field :take_profit, :float
      field :profit, :integer
      field :screenshot, :image

      doc_fields :updated, :action, :take_profit, :profit, :screenshot
    end

  end
end
