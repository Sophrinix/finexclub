module Finexclub
  module Document

    def self.included(base)
      base.class_eval do
        include InstanceMethods
        extend ClassMethods

        def _id=(value)
        end
      end
    end

    module ClassMethods
      def define_attr_reader(name)
        define_method "#{name}" do
          instance_variable_get("@#{name}")
        end
      end

      def define_attr_writer(name, converter = nil)
        define_method "#{name}=" do |value|
          value = converter.nil?? value : converter.call(value)
          instance_variable_set("@#{name}", value)
        end
      end

      def define_symbol_fields(name)
        define_attr_reader(name)
        define_attr_writer(name, lambda{|x| x.downcase})
      end

      def define_integer_fields(name)
        define_attr_reader(name)
        define_attr_writer(name, lambda{|x| x.to_i})
      end

      def define_float_fields(name)
        define_attr_reader(name)
        define_attr_writer(name, lambda{|x| x.to_f})
      end

      def define_string_fields(name)
        define_attr_reader(name)
        define_attr_writer(name, lambda{|x| x.to_s})
      end

      def define_timestamp_fields(name)
        define_attr_reader(name)
        define_attr_writer(name, lambda{|x| x.to_i})

        define_method "#{name}_at" do
          timestamp = instance_variable_get("@#{name}")
          Time.at(timestamp).utc
        end

        define_method "#{name}_date" do
          send("#{name}_at").strftime("%Y-%m-%d")
        end
      end

      def define_image_fields(name)
        define_attr_reader(name)
        define_attr_writer(name)

        define_method "#{name}_filename=" do |filename|
          image_uid = core.images.store(filename)
          instance_variable_set("@#{name}", image_uid)
        end

        define_method "#{name}_image" do
          image_uid = instance_variable_get("@#{name}")
          core.images.fetch(image_uid)
        end
      end

      def field(name, field_type)
        meta[name] = field_type
        send "define_#{field_type}_fields", name
      end

      def meta
        @meta ||= {}
      end

      def export_fields
        @doc_fields ||= []
      end

      def doc_fields(*fields)
        @doc_fields = fields
      end
    end

    module InstanceMethods
      def apply_meta(meta)
        meta.each do |name, field_type|
          self.class.field(name, field_type)
        end
      end

      def build(params)
        params.each do |key, value|
          send "#{key}=", value
        end
      end

      def to_doc
        doc = {}
        self.class.export_fields.each { |name| doc[name] = send(name) }
        doc
      end
    end
  end
end

