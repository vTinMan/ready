require "rspec"
require "ready"


RSpec.describe "B" do

  let(:main_obj) do
    class DependentClass
      def u_mth
        DependencyModule::MY_STRING.split(DependencyModule::SPLITTER)[0]
      end

      def u2
        DependencyModule::MY_STRING.split(DependencyModule::SPLITTER)[1]
      end

      def uu_mmtthh
        DependencyModule::MY_STRING.split(DependencyModule::SPLITTER)[2]
      end
    end


    module DependencyModule
      MY_STRING = "first text; second text; other text"
      SPLITTER = "; "

      extend Ready::Dependency
      dependency DependentClass
    end

    class MainClass
      include DependencyModule
      ready :my_dependency

      def prob_mt
        [my_dependency.u_mth, my_dependency.u2, my_dependency.uu_mmtthh].join("; ")
      end
    end

    MainClass.new
  end


  it "cb test" do
    expect(main_obj.prob_mt).to eq(DependencyModule::MY_STRING)
    expect { main_obj.my_dependency }.to raise_error(NoMethodError, /private/)
  end

end
