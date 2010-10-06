require "rubygems"
require "bacon"
require "facon"
require "ap"
require "timecop"
require "chronic"
require File.expand_path(File.dirname(__FILE__) + '/../lib/finexclub')

TEST_IMAGES_PATH = File.expand_path(File.dirname(__FILE__) + "/../samples") 

class Bacon::Context
  include Finexclub::Fabrication

  def mock_core(extra_stubs = {})
    mock('core', {
      :images => mock('images', :store => 'image_uid'),
      :signals => mock('signals')
    }.merge(extra_stubs)
    )
  end

  def mock_mongo(extra_stubs = {})
    mock('mongo', {
      :collection => mock('collection', :update => true)
    }.merge(extra_stubs)
    )
  end

  def test_core
    Finexclub::Core.send(:new)
  end
end

Bacon.summary_on_exit
