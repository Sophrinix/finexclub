require "mongo"
require "ap"

module Finexclub
  class Manager

    attr_reader :core
    attr_accessor :db

    def initialize(core)
      @core = core
    end

    def collection
      raise("No db configured") if db.nil?
      db.collection('charts')
    end

    def find(query, opts = {})
      Cursor.new(core, Chart, collection.find(query, opts))
    end

    def find_one(query, opts = {})
      return nil unless doc = collection.find_one(query, opts)
      chart = Chart.new(core)
      chart.build(doc)
      chart
    end

    def last_updated
      c = collection.find({}, :fields => {:updated => 1}, :sort => [['updated', :desc]], :limit => 1).first
      c.nil?? nil : Time.at(c["updated"])
    end

    def add_signal(signal_type, params)
      signal = Signal.build(core, signal_type, params.merge(:updated => Time.now))
      c = {
        :symbol => signal.symbol,
        :date => signal.updated_at.strftime("%Y-%m-%d")
      }
      collection.update(c, {"$push" => {signal_type => signal.to_doc}, "$set" => {:updated => signal.updated}}, :upsert => true)
    end

    class Cursor
      include Enumerable
      attr_accessor :mongo_cursor
      attr_reader :core
      
      def initialize(core, obj_class, mongo_cursor)
        @core         = core
        @obj_class    = obj_class
        @mongo_cursor = mongo_cursor
      end

      #def method_missing(name, *args)
        #@mongo_cursor.send name, *args
      #end
      
      # Is the cursor empty? This method is much more efficient than doing cursor.count == 0
      def empty?
        @mongo_cursor.has_next? == false
      end
      
      def next_document
        if doc = @mongo_cursor.next_document
          obj = @obj_class.new(core)
          obj.build(doc)
          obj
        end
      end
      
      alias :next :next_document
      
      def each
        @mongo_cursor.each do |doc|
          obj = @obj_class.new(core)
          obj.build(doc)
          yield(obj)
        end
      end
      
      def current_limit
        @mongo_cursor.limit
      end
      
      def limit(number_to_return)
        @mongo_cursor.limit(number_to_return); self
      end
      
      def current_skip
        @mongo_cursor.skip
      end
      
      def skip(number_to_skip)
        @mongo_cursor.skip(number_to_skip); self
      end
      
      def sort(key_or_list, direction = nil)
        @mongo_cursor.sort(key_or_list, direction); self
      end
    end
  end
end
