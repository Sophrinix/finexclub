require File.dirname(__FILE__) + '/../spec_helper'

describe 'Finexclub::Signals::Zeta' do
  before do
    @core = mock_core
    @zeta = Finexclub::Signals::Zeta.new(@core)
  end

  it 'should have meta' do
    Finexclub::Signals::Zeta.meta.should == {
      :updated => :timestamp,
      :symbol => :symbol,
      :up_support => :float,
      :up_resist => :float,
      :down_support => :float,
      :down_resist => :float,
      :screenshot => :image
    }
  end

  it 'should build from doc' do
    @zeta.build(:up_support => 1.1, :up_resist => 1.2, :down_support => 2.1, :down_resist => 2.2, :symbol => "eurusd", :screenshot => "image_uid")
    @zeta.up_support.should == 1.1
    @zeta.up_resist.should == 1.2
    @zeta.down_support.should == 2.1
    @zeta.down_resist.should == 2.2
    @zeta.symbol.should == "eurusd"
    @zeta.screenshot.should == "image_uid"
  end
  
  it 'should respond to #up_channel? / #down_channel' do
    @zeta.build(:up_support => 0, :up_resist => 0)
    @zeta.up_channel?.should == false

    @zeta.build(:down_support => 0, :down_resist => 0)
    @zeta.down_channel?.should == false
  end

  it 'should export valid doc' do
    @core.images.stub!(:store).and_return('image_uid')
    @zeta.build("up_support" => "1.1", "up_resist" => "1.2", "down_support" => "2.1", "down_resist" => "2.2", "updated" => 123, "screenshot_filename" => "egg.png")
    @zeta.to_doc.should == {
      :updated => 123,
      :up_support => 1.1, 
      :up_resist => 1.2, 
      :down_support => 2.1, 
      :down_resist => 2.2, 
      :screenshot => 'image_uid'
    }
  end
end

