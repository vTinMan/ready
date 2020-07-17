module Ready


  module Injection

    private

    def ready(method_name)
      unless method_name.is_a?(String) || method_name.is_a?(Symbol)
        raise ArgumentError, "method_name should be String or Symbol"
      end
      modl = ancestors.detect {|ancestor| ancestor.is_a?(Module) && ancestor.is_a?(Ready::Dependency) }
      unless modl
        raise StandardError, "ready allow only when included dependency module"
      end

      class_eval <<-RUBY
        def #{method_name}
          tg = @ready_objects[#{modl.name}] if @ready_objects
          tg ||= #{modl.name}.ready_inject(self)
          if tg != #{modl.name}
            @ready_objects ||= {}
            @ready_objects[#{modl.name}] ||= tg
          end
          tg
        end
        private :#{method_name}
      RUBY
    end

  end


end
