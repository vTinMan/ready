
The simplest implementation of DI and IoC
-----------------------------------------

Gem 'Ready' implements DI on pure Ruby using no special containers.
This is the simplest implementation of Dependency injection and Inversion of Control, in Ruby style.


### Dependency injection example

    class DependentClass
      def di_method
        "text from #di_method"
      end
    end
    
    
    module DependencyModule
      extend Ready::Dependency
      dependency DependentClass
    end
    
    
    class MainClass
      include DependencyModule
      ready :my_dependency

      def test_method
        puts my_dependency.di_method
      end
    end
    
    MainClass.new.test_method
