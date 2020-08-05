module Ready

  module ModulePrivacy

    def self.included(base)
      # TODO only for modules
      # raise unless base.is_a? Module
      # TODO set all methods as private
      # ...
    end

    def method_added(method_name)
      super
      private method_name
    end


  end

end
