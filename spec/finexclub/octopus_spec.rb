require File.dirname(__FILE__) + '/../spec_helper'

describe 'Finexclub::Signals::Octopus' do
  before do
    @core = mock_core
    @signal = Finexclub::Signals::Octopus.new(@core)
  end

  it 'should have meta' do
    Finexclub::Signals::Octopus.meta.should == {
      :updated => :timestamp,
      :symbol => :symbol,
      :action => :string,
      :take_profit => :float,
      :profit => :integer,
      :stop_loss => :float,
      :loss => :integer,
      :index => :integer,
      :screenshot => :image
    }
  end

  it 'should export valid doc' do
    @core.images.stub!(:store).and_return('image_uid')
    @signal.build("updated" => 123, "action" => "sell", "take_profit" => 1.5, "profit" => 10, "stop_loss" => 1.7, "loss"=>10, "index" => 50, "screenshot_filename"=>"whatever.png")
    @signal.to_doc.should == {
      :updated => 123,
      :action => "sell", 
      :take_profit => 1.5, 
      :profit => 10,
      :stop_loss => 1.7,
      :loss => 10,
      :index => 50,
      :screenshot => "image_uid"
    }
  end
end

