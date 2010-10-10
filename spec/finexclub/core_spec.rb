require File.dirname(__FILE__) + '/../spec_helper'

Finexclub.configure do |f|
  f.signals.db = Mongo::Connection.new.db("finexclub_test")
end

describe 'Finexclub::Core' do
  describe '.instance' do
    it 'should create instance if it does not already exists' do
      app = Finexclub::Core.instance
      app.should.be.instance_of Finexclub::Core
    end

    it 'should return an existing instance' do
      app = Finexclub::Core.instance
      Finexclub::Core.instance.should == app
    end

    it 'should work with Finexclub.core' do
      Finexclub.core.should == Finexclub::Core.instance
    end
  end
  
  describe '.new' do
    it 'should not be callable' do
      lambda {
        Finexclub::Core.new
      }.should.raise(NoMethodError)
    end
  end

  describe '.configure' do
    before do
      @core = test_core
    end

    it 'should allow to configure' do
      @core.configure do |f|
        f.should == @core
      end
    end
  end

  describe '#images' do
    before do
      @core = test_core
    end
    it 'should return Images' do
      @core.images.class.should == Finexclub::Images
    end
  end

  describe '#signals' do
    before do
      @core = test_core
    end
    it 'should return Manager' do
      @core.signals.class.should == Finexclub::Manager
    end
  end

  describe '#find' do
    before do
      @core = test_core
    end

    it 'should fetch all charts for given date' do
      @core.signals.should.receive(:find).with({:date => "2010-10-01"}).and_return(c = mock('cursor'))
      @core.find(:all, "2010-10-01").should == c
    end

    it 'should fetch an array of charts for given date' do
      @core.signals.should.receive(:find).with({:symbol => {:$in => ["eurusd", "usdjpy"]}, :date => "2010-10-01"}).and_return(c = mock('cursor'))
      @core.find(["eurusd", "usdjpy"], "2010-10-01").should == c
    end

    it 'should allow fetching signals by date and symbol' do
      @core.signals.should.receive(:find_one).with({:date => "2010-10-01", :symbol => "eurusd"}).and_return(chart = mock('chart'))
      @core.find("eurusd", "2010-10-01").should == chart
    end
  end

  describe '#store' do
    before do
      @core = test_core
    end
    it 'should store each signal given an array of params' do
      @core.signals.should.receive(:add_signal).with(:alpha,p1=mock('p1'))
      @core.signals.should.receive(:add_signal).with(:alpha,p2=mock('p2'))
      @core.store(:alpha, [p1, p2])
    end
    it 'should store signal given signle hash of params' do
      @core.signals.should.receive(:add_signal).with(:alpha,p1=mock('p1'))
      @core.store(:alpha, p1)
    end
  end

end

