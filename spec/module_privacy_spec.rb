require "rspec"
require "ready"



RSpec.describe "B" do


  let(:main_obj) do


    module PrivateMethodsModule
      METHODS_CONST = "text from #mth0"

      extend Ready::ModulePrivacy

      def mth0
        METHODS_CONST
      end

    end


    class Main2Class
      MAIN_CONST = 'Main2Class text "%s"'

      include PrivateMethodsModule

      def prob_mt
        format(MAIN_CONST, mth0)
      end

    end

    Main2Class.new
  end



  it "cb test" do
    expect(main_obj.prob_mt).to eq(Main2Class::MAIN_CONST % [PrivateMethodsModule::METHODS_CONST])
    expect { main_obj.mth0 }.to raise_error(NoMethodError, /private/)
  end

end
