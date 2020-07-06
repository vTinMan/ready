require "rspec"
require "ready"



RSpec.describe "B" do


  let(:cb_obj) do

    module MdB
      extend Ready::Dependency

      dependency { UtilB.new }

      provide :u_mth, :uu_mmtthh
      provide :u2, as: :b_mt2
    end


    class UtilB

      def u_mth
        "text from #u_mth"
      end

      def u2
        "text from #u2"
      end

      def uu_mmtthh
        "text from #uu_mmtthh"
      end

    end


    class ClB

      include MdB
      injection :current, alias: :util_b
      # or TODO
      # injection MB, as: :util_b

      def prob_mt
        puts util_b.u2
        puts u_mth
        puts b_mt2
        puts uu_mmtthh
      end

    end


    ClB.new
  end



  it "cb test" do
    cb_obj.prob_mt
    expect { cb_obj.util_b }.to raise_error(NoMethodError, /private/)
    expect { cb_obj.b_mt2 }.to raise_error(NoMethodError, /private/)
  end

end
