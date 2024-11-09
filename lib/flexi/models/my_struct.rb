# frozen_string_literal: true

class MyStruct
  def self.new(*positional_attrs, **keyword_attrs)
    Class.new do
      attr_reader(*positional_attrs, *keyword_attrs.keys)

      define_method :initialize do |*args, **kwargs|
        if args.size != positional_attrs.size
          raise ArgumentError, "wrong number of arguments (given #{args.size}, expected #{positional_attrs.size})"
        end

        unknown_kwargs = kwargs.keys - keyword_attrs.keys
        raise ArgumentError, "unknown keywords: #{unknown_kwargs.join(', ')}" unless unknown_kwargs.empty?

        positional_attrs.zip(args).each do |attr, value|
          instance_variable_set("@#{attr}", value)
        end

        keyword_attrs.each do |attr, default|
          value = kwargs.key?(attr) ? kwargs[attr] : default
          instance_variable_set("@#{attr}", value)
        end
      end
    end
  end
end
