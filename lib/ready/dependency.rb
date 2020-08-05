module Ready


  module Dependency

    include Ready::ModulePrivacy


    def ready_inject(obj)
      return self unless @inject_target
      @inject_target.is_a?(Proc) ? @inject_target.call(obj) : @inject_target.new
    end


  private


    def included(base)
      base.class_eval do
        extend Ready::Injection
      end
    end


    def dependency(*args, &block)
      # TODO addition arguments
      @inject_target = block_given? ? block.to_proc : args[0]
    end

  end


end
