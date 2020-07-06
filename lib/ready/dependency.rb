module Ready


  module Dependency

    def ready_inject(obj)
      return self unless @inject_target
      @inject_target.is_a?(Proc) ? @inject_target.call(obj) : @inject_target.new(obj)
    end


    private


    def provide(*args)
      if args.count == 1 && (args.first.is_a?(Symbol) || args.first.is_a?(String))
        method_names = [args.first]
        def_names = method_names
      elsif args.count == 2 && args[1].is_a?(Hash) && (args.first.is_a?(Symbol) || args.first.is_a?(String))
        method_names = [args.first]
        options = args.last
        def_names = options[:as] ? [options[:as]] : [args.first]
      elsif args.count > 1 && args.all? {|arg| arg.is_a?(Symbol) || arg.is_a?(String) }
        method_names = args
        def_names = method_names
      else
        # TODO arguments error
        raise ArgumentError, "arguments for provide should be method_names or method_name and options"
      end
      method_names.each_with_index do |method_name, i|
        def_name = def_names[i] || method_name
        module_eval <<-RUBY
          def #{def_name}(*args)
            tg = @ready_objects[#{name}] if @ready_objects
            tg ||= #{name}.ready_inject(self)
            if tg != #{name}
              @ready_objects ||= {}
              @ready_objects[#{name}] ||= tg
            end
            tg.#{method_name}(*args)
          end
          private :#{def_name}
        RUBY
      end

      def included(base)
        base.class_eval do
          extend Ready::Injection
        end
      end
    end


    def dependency(*args, &block)
      # TODO addition arguments
      @inject_target = block_given? ? block.to_proc : args[0]
    end

  end


end
