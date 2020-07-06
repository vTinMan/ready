require "rspec"
require "ready"



RSpec.describe "Multi" do


  let(:cb_class) do

    module MdC
      extend Ready::Dependency

      dependency { UtilC.new }

      provide :calc
    end


    class UtilC

      def calc
        @a ||= 0
        @a += 1
      end

    end


    class ClC

      include MdC
      injection :current, alias: :util_b

      def test_mt
        calc
      end

    end


    ClC
  end

  let(:cb_obj1) { cb_class.new }
  let(:cb_obj2) { cb_class.new }

  it "cb test" do
    expect(cb_obj1.test_mt).to eql(1)
    expect(cb_obj1.test_mt).to eql(2)
    expect(cb_obj1.test_mt).to eql(3)

    expect(cb_obj2.test_mt).to eql(1)
    expect(cb_obj2.test_mt).to eql(2)
    expect(cb_obj2.test_mt).to eql(3)
  end

end
