require File.dirname(__FILE__) + '/../spec_helper'

describe 'Finexclub::Manager' do
  before do
    @core = mock_core
    @manager = Finexclub::Manager.new(@core)
    @manager.db = mock_mongo
  end

  describe 'mongo' do
    before do
      @mongo = mock('mongo')
      @manager.db = @mongo
    end
    it 'should provide mongo instance' do
      @manager.db.should == @mongo
    end
    it 'should have collection accessor' do
      @mongo.stub!(:collection).and_return(coll = mock('coll'))
      @manager.collection.should == coll 
    end
  end

  describe '.find' do
    it 'should call find on collection and return Cursor' do
      @manager.collection.should.receive(:find).with({:date => "2010-10-01"}, {}).and_return(c = mock('cursor'))
      @manager.find(:date => "2010-10-01")
    end
  end

  describe '.find_one' do
    it 'should call find on collection' do
      @manager.collection.should.receive(:find_one).with({:date => "2010-10-01", :symbol => "eurusd" }, {}).and_return({})
      @manager.find_one(:date => "2010-10-01", :symbol => "eurusd").class == Finexclub::Chart
    end

    it 'should return nil if nothing found' do
      @manager.collection.should.receive(:find_one).with({:date => "2010-10-01", :symbol => "eurusd"}, {}).and_return(nil)
      @manager.find_one(:date => "2010-10-01", :symbol => "eurusd").should == nil
    end
  end

  describe '.last_updated' do
    before do
      @cursor = mock('cursor', :first => {"updated" => 123}) 
    end

    it 'should search for the latest timestamp in collection' do
      @manager.collection.should.receive(:find).with({}, :fields => {:updated => 1}, :sort => [['updated', :desc]], :limit => 1).and_return(@cursor)
      @manager.last_updated.should == Time.at(123)
    end

    it 'should return nil if nothing found' do
      @manager.collection.stub!(:find).and_return(mock('cursor', :first => nil))
      @manager.last_updated.should == nil 
    end
  end

  describe '.add_signal' do
    before do
      class Omega < Finexclub::Signal
        field :symbol, :symbol
        field :updated, :timestamp
        field :foo, :string

        doc_fields :foo, :updated
      end
    end

    it 'should update collection' do
      #Mon Oct 04 18:10:20 0700 2010
      ts = 1286190620

      Finexclub::Signal.stub!(:handler_for).with(:omega).and_return(Omega)
      @manager.collection.should.receive(:update).with(
        {
          :date => '2010-10-04',
          :symbol => 'eurusd'
        },
        {
          "$push" => {:omega => {:foo => "bar", :updated => 1286190620}},
          "$set" => {:updated => 1286190620}
        },
        :upsert => true
      )
      
      Timecop.travel(Time.at(ts))
      @manager.add_signal(:omega, {"foo" => "bar", "symbol" => "EURUSD"})
    end
  end

  describe 'Cursor' do
    before do
      @mongo_cursor = mock('mongo_cursor')
      class Foo; end
      @cursor = Finexclub::Manager::Cursor.new(@core, Foo, @mongo_cursor)
    end
  end
end
