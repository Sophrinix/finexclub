require File.dirname(__FILE__) + '/../spec_helper'

describe 'Finexclub::Images' do
  before do
    @core = mock_core
    @images = Finexclub::Images.new(@core)
  end

  it 'should initialize Dragonfly application' do
    @images.app.should == Dragonfly[:images]
  end


  describe 'configuring' do
    it 'should allow configuring screenshot_path' do
      @images.screenshot_path = "ololo"
      @images.screenshot_path.should == "ololo"
    end

    it 'should forward configure_with' do
      @images.app.should.receive(:configure_with).with(:rmagick)
      @images.configure_with(:rmagick)
    end

    it 'should forward configure' do
      @images.app.should.receive(:configure)
      @images.configure {|app| }
    end
  end

  describe '.store' do
    before do
      @images.screenshot_path = TEST_IMAGES_PATH
    end

    it 'should store given file using Dragonfly' do
      File.should.receive(:new).with("#{TEST_IMAGES_PATH}/egg.png").and_return(image_file = mock('file'))
      @images.app.should.receive(:store).with(image_file).and_return("image_uid")
      @images.store("egg.png").should == "image_uid"
    end
  end

  describe '.fetch' do
    it 'should respond to .fetch' do
      @images.app.should.receive(:fetch).with('image_uid').and_return(job = mock('job'))
      @images.fetch('image_uid').should == job
    end
  end
end
