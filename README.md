
Dependency Injection (DI) for Ruby.
-----------------------------------

Gem 'Ready' realise Dependency Injection on pure Ruby without using special containers. It set DSL for using Dependency Injection design pattern.



### Common example


    module DependencyModule

      extend Ready::Dependency

      dependency { DependentClass.new }

      provide :di2

    end


    class DependentClass

      def di_mth
        "text from #u_mth"
      end

      def di2
        "text from #u2"
      end

    end


    class MainClass

      include DependencyModule
      # you need alias, for use dependency by name
      injection :current, alias: :my_dependency

      def test_method
        puts di2
        puts my_dependency.di_mth
      end

    end


    MainClass.new.test_method



#### Private-only

Where is include, there is use.


``MainClass.new.my_dependency # NoMethodError: private method `my_dependency' called``

``MainClass.new.di2 # NoMethodError: private method `di2' called``






### Module example

By default dependency is module itself.


    module DependentModule

      extend Ready::Dependency

      provide :my_method

    end


    class << DependentModule

      def my_method
        'text from my_method'
      end

    end


    class MainClass

      include DependentModule

      def run
        puts my_method
      end

    end


    MainClass.new.run

