require File.dirname(__FILE__) + '/../spec_helper'

describe 'Finexclub::Document' do
  before do
    @core = mock_core
    class Foo
      include Finexclub::Document
    end
    @object = Foo.new
    @object.stub!(:core).and_return(@core)
  end

  it 'should swallow when assigned to _id' do
    lambda {
      @object._id = 111
    }.should.not.raise
  end

  describe '.apply_meta' do
    before do
      @meta = {
        :foo => :string,
        :index => :integer,
        :rate => :float,
        :symbol => :symbol,
        :updated => :timestamp,
        :screenshot => :image
      }
    end

    it 'should save meta as class variable' do
      @object.apply_meta(@meta)
      Foo.meta.should == @meta
    end

    [
      :string,
      :integer,
      :float,
      :timestamp,
      :image
    ].each do |field_type|
      it "should define methods for #{field_type} type" do
        Foo.should.receive("define_#{field_type}_fields".to_sym).with(:foo)
        @object.apply_meta({:foo => field_type})
      end
    end
  end

  describe '.to_doc' do
    before do
      class Foo
        field :symbol, :symbol
        field :index, :integer
        field :foo, :string

        doc_fields :foo, :index
      end
      @object = Foo.new
    end

    it 'should only export specified fields' do
      @object.build(:symbol => "eurusd", :index => 100, :foo => "bar")
      @object.to_doc.should == {:index => 100, :foo => "bar"}
    end
  end

  describe '.build' do
    before do
      @object.apply_meta({:foo => :string})
    end

    it 'should assign attribute values from symbols hash' do
      @object.should.receive("foo=".to_sym).with("bar")
      @object.build(:foo => "bar")
    end

    it 'should assign attribute values from string hash' do
      @object.should.receive("foo=".to_sym).with("bar")
      @object.build("foo" => "bar")
    end
  end

  describe 'string fields' do
    before do
      @object.apply_meta({:foo => :string})
    end

    it 'should covert to string' do
      @object.foo = 100 
      @object.foo.should == "100"
    end

    it 'should assign and read strings' do
      @object.foo = "bar"
      @object.foo.should == "bar"
    end
  end
    
  describe 'integer fields' do
    before do
      @object.apply_meta({:foo => :integer})
    end

    it 'should convert integers from strings' do
      @object.foo = "100"
      @object.foo.should == 100
      @object.foo.class.should == Fixnum
    end

    it 'should assign and read integers' do
      @object.foo = 100 
      @object.foo.should == 100
      @object.foo.class.should == Fixnum
    end
  end

  describe 'float fields' do
    before do
      @object.apply_meta({:foo => :float})
    end

    it 'should convert to float from string' do
      @object.foo = "1.1234"
      @object.foo.should == 1.1234
      @object.foo.class.should == Float
    end

    it 'should assign and read floats' do
      @object.foo = 1.5 
      @object.foo.should == 1.5
      @object.foo.class.should == Float
    end
  end

  describe 'timestamp field' do
    before do
      @object.apply_meta({:updated => :timestamp})
    end

    it 'initialize from Time instance' do
      ts = Time.now
      @object.updated = ts
      @object.updated.should == ts.to_i
      @object.updated.class.should == Fixnum
    end

    it 'assign and read timestamp' do
      @object.updated = 123123
      @object.updated.should == 123123
    end

    it 'should provide updated_at as UTC Time' do
      @object.updated = 123123
      @object.updated_at.should == Time.at(123123).utc
    end

    it 'should provide updated_date date' do
      # 2010-10-05
      @object.updated = 1286236800
      @object.updated_date.should == '2010-10-05' 
    end
  end

  describe 'symbol field' do
    before do
      @object.apply_meta({:symbol => :symbol})
    end

    it 'should convert to lowercase' do
      @object.symbol = "EURUSD"
      @object.symbol.should == "eurusd"
    end

    it 'should ignore case if lowercase' do
      @object.symbol = "eurusd"
      @object.symbol.should == "eurusd"
    end
  end

  describe 'image field' do
    before do
      @object.apply_meta({:screenshot => :image})
    end

    it 'should store file if assigned to screenshot_filename' do
      @core.images.should.receive(:store).with("egg.png").and_return("image_uid")
      @object.screenshot_filename = "egg.png"
      @object.screenshot.should == "image_uid"
    end

    it 'should assign and read image id' do
      @object.screenshot = "image_uid"
      @object.screenshot.should == "image_uid"
    end

    it 'should provide access to image' do
      @core.images.should.receive(:fetch).with("image_uid").and_return(img=mock('job'))
      @object.screenshot = "image_uid"
      @object.screenshot_image.should == img
    end
  end
end
