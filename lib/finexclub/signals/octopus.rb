module Finexclub
  module Signals

    class Octopus < Signal
      field :symbol, :symbol
      field :updated, :timestamp
      field :action, :string
      field :take_profit, :float
      field :profit, :integer
      field :stop_loss, :float
      field :loss, :integer
      field :index, :integer
      field :screenshot, :image

      doc_fields :updated, :action, :take_profit, :profit, :stop_loss, :loss, :index, :screenshot
    end

  end
end
