require File.dirname(__FILE__) + '/../spec_helper'

describe 'Finexclub::Signals::Prognosis' do
  before do
    @core = mock_core
    @prognosis = Finexclub::Signals::Prognosis.new(@core)
  end

  it 'should have meta' do
    Finexclub::Signals::Prognosis.meta.should == {
      :updated => :timestamp,
      :symbol => :symbol,
      :action => :string,
      :take_profit => :float,
      :profit => :integer,
      :screenshot => :image
    }
  end

  it 'should export valid doc' do
    @core.images.stub!(:store).and_return('image_uid')
    @prognosis.build("updated" => 123, "action" => "sell", "take_profit" => 1.5, "profit" => 10, "screenshot_filename"=>"whatever.png")
    @prognosis.to_doc.should == {
      :updated => 123,
      :action => "sell", 
      :take_profit => 1.5, 
      :profit => 10,
      :screenshot => "image_uid"
    }
  end
end

