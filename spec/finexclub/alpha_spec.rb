require File.dirname(__FILE__) + '/../spec_helper'

describe 'Finexclub::Signals::Alpha' do
  before do
    @core = mock_core
    @alpha = Finexclub::Signals::Alpha.new(@core)
  end

  it 'should provide attribute accessors' do
    @alpha.build("direction" => 1, "index" => 100)
    @alpha.direction.should == 1
    @alpha.index.should == 100
  end

  {
    1 => :bullish,
    -1 => :bearish,
    0 => :bearish
  }.each do |direction, trend|
    it "should return #{trend} trend when direction is #{direction}" do
      @alpha.direction = direction
      @alpha.trend.should == trend
    end
  end

  {
    :confirmed => 100..100,
    :high => 90..99,
    :medium => 80..89,
    :low => 70..79,
    :unstable => 0..60
  }.each do |stability, range|
    it "should return #{stability} stability when index within #{range}" do
      @alpha.index = range.first
      @alpha.stability.should == stability

      @alpha.index = range.last
      @alpha.stability.should == stability
    end 
  end

  it 'should export valid doc' do
    @alpha.build("direction" => 1, "index" => 100, "updated" => 123)
    @alpha.to_doc.should == {:updated => 123, :index => 100, :direction => 1}
  end
end

