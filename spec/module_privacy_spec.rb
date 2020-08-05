require "rspec"
require "ready"



RSpec.describe "B" do


  let(:main_obj) do


    module MethodsModule
      CONST_0 = "text from #mth0"

      extend Ready::ModulePrivacy

      def mth0
        CONST_0
      end

    end


    class Main2Class

      include MethodsModule

      def prob_mt
        mth0
      end

    end

    Main2Class.new
  end



  it "cb test" do
    expect(main_obj.prob_mt).to eq(MethodsModule::CONST_0)
    expect { main_obj.mth0 }.to raise_error(NoMethodError, /private/)
  end

end
