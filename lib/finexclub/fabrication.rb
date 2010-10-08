module Finexclub
  module Fabrication
    def raw_alpha_hash(options = {})
      {"symbol" => "EURUSD", "index"=>"2", "direction"=>"1"}.merge(options)
    end

    def raw_zeta_hash(options={})
      {
        "symbol" => "EURUSD",
        "up_support" => "1.124", 
        "up_resist" => "1.123",
        "down_support" => "1.124",
        "down_resist" => "1.123",
        "screenshot_filename" => "egg.png"
      }.merge(options)
    end

    def chart_factory(options = {})
      date = options.delete(:date) || Time.now
      {
        :symbol => "eurusd",
        :timeframe => "h1",
        :date => date.respond_to?(:strftime) ? date.strftime('%Y-%m-%d') : date,
        :alpha => (0..23).map {|h| self.alpha_factory(:time => Time.local(Time.now.year, Time.now.month, Time.now.day, h, 1))},
        :zeta => (0..23).map {|h| self.zeta_factory(:time => Time.local(Time.now.year, Time.now.month, Time.now.day, h, 1))}
      }.merge(options)
    end
   
    def alpha_factory(options = {})
      time = options[:time] || Time.now
      {
        :direction => 1,
        :index => 30 + rand(70),
        :time => time.respond_to?(:strftime) ? time.strftime('%H:%M') : time
      }.merge(options)
    end

    def zeta_factory(options = {})
      time = options[:time] || Time.now
      {
        :up_support => (1.1 + rand),
        :up_resist => 1.1 + rand,
        :down_support => 1.1 + rand,
        :down_resist => 1.2 + rand,
        :screenshot_uid => "ololo"
      }.merge(options)
    end

    def clear_signals
      Finexclub.signals.collection.remove
    end
  end
end
