require "rspec"
require "ready"


RSpec.describe "Multi" do

  let(:calc_class) do
    module CalcDependency
      extend Ready::Dependency
      dependency { CalcUtil.new }
    end


    class CalcUtil
      def initialize
        @a ||= 0
      end

      def calc
        @a += 1
      end
    end


    module CalcDependency2
      extend Ready::Dependency
      dependency { CalcUtil2.new }
    end


    class CalcUtil2
      def initialize
        @a ||= 0
      end

      def calc
        @a += 2
      end
    end


    class MainCalc
      include CalcDependency
      ready :calc1

      include CalcDependency2
      ready :calc2

      def test
        calc1.calc
      end

      def test2
        calc2.calc
      end
    end

    MainCalc
  end

  let(:calc_obj1) { calc_class.new }
  let(:calc_obj2) { calc_class.new }

  it "cb test" do
    expect(calc_obj1.test).to eql(1)
    expect(calc_obj1.test).to eql(2)
    expect(calc_obj1.test).to eql(3)

    expect(calc_obj1.test2).to eql(2)
    expect(calc_obj1.test2).to eql(4)
    expect(calc_obj1.test2).to eql(6)

    expect(calc_obj2.test).to eql(1)
    expect(calc_obj2.test).to eql(2)
    expect(calc_obj2.test).to eql(3)

    expect(calc_obj2.test2).to eql(2)
    expect(calc_obj2.test2).to eql(4)
    expect(calc_obj2.test2).to eql(6)
  end
end
