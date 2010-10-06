ENV['RACK_ENV'] = 'test'

require File.dirname(__FILE__) + '/../spec_helper'
require 'rack/test'

include Rack::Test::Methods
include Finexclub::Fabrication

Finexclub.configure do |f|
  f.images.screenshot_path = TEST_IMAGES_PATH
  f.signals.db = Mongo::Connection.new.db("finexclub_test")
end

def app
  Finexclub::App
end

def charts
  Finexclub.signals.collection
end

def make_request(url, opts = {})
  post url, opts 
  last_response
end

def date(ts = nil)
  ts ||= Time.now.utc
  ts.strftime("%Y-%m-%d")
end

def alpha_params()
  params = {}
  params[:alpha] = Finexclub::Chart::SYMBOLS.inject([]) {|alpha, symbol| alpha << raw_alpha_hash("symbol" => symbol.upcase)}
  params
end

def zeta_params(options = {})
  #options[:symbol] ||= "EURUSD"
  params = {}
  params[:zeta] = [raw_zeta_hash(options)]
  params
end

describe 'Finexclub::App' do
  describe 'saving Alpha' do
    before do
      charts.remove
    end
    
    it 'should create first signal' do
      response = make_request('/alpha', alpha_params)
      response.status.should == 200

      charts.find().count.should == 28
      charts.find_one(:date => date, :symbol => 'eurusd')["alpha"].size.should == 1
    end

    it 'should add more alpha signals' do
      Timecop.travel
      response = make_request('/alpha', alpha_params)
      response.status.should == 200

      Timecop.travel(1*60*60) #travel 1 hour later
      response = make_request('/alpha', alpha_params)
      response.status.should == 200
      charts.find().count.should == 28
      charts.find_one(:date => date, :symbol => 'eurusd')["alpha"].size.should == 2
    end
  end
  
  describe 'saving Zeta' do
    before do
      charts.remove
    end
    
    it 'should create first zeta signals' do
      response = make_request('/zeta', zeta_params)
      response.status.should == 200

      charts.find().count.should == 1
      charts.find_one(:date => date, :symbol => 'eurusd')["zeta"].size.should == 1
    end
  end

  describe 'keep alive ping' do
  end
end

