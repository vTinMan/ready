module Ready


  module Injection

    private

    def injection(_modl, options={})
      if _modl == :current
        modl = ancestors.detect {|ancestor| ancestor.is_a?(Module) && ancestor.is_a?(Ready::Dependency) }
        method_name = options[:current]
      elsif
        modl = _modl
      end
      unless defined?(modl) && modl
        # TODO arguments error
        raise ArgumentError, "arguments should be ......."
      end

      if options[:alias]
        method_name = options[:alias]
        class_eval <<-RUBY
          def #{method_name}
            tg = @ready_objects[#{modl.name}] if @ready_objects
            tg ||= #{modl.name}.ready_inject(self)
            if tg != #{name}
              @ready_objects ||= {}
              @ready_objects[tg] ||= tg
            end
            tg
          end
          private :#{method_name}
        RUBY
      end
    end

  end


end
