require "rspec"
require "ready"



RSpec.describe "A" do


  let(:ca_obj) do

    module MdA
      extend Ready::Dependency
      provide :my_method
      provide :mt2, :mmtthh
    end


    class << MdA
      def my_method
        'text from my_method'
      end

      def mt2
        'text from mt2'
      end

      def mmtthh
        'text from mmtthh'
      end
    end


    class ClA
      include MdA

      def prob_mt
        puts my_method
        puts mt2
        puts mmtthh
      end
    end

    ClA.new
  end



  it "ClA test" do
    ca_obj.prob_mt
    expect { ca_obj.my_method }.to raise_error(NoMethodError, /private/)
    expect { ca_obj.mt2 }.to raise_error(NoMethodError, /private/)
    expect { ca_obj.mmtthh }.to raise_error(NoMethodError, /private/)
  end


end
