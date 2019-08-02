require "./../spec_helper"

describe Numcry::Accumulate do
  it "works with an initial value and accumulator function" do
    accumulate((1..3), 10) { |a, b| a + b }.should eq([11, 13, 16])
  end

  it "works with an accumulator function and assumed initial value" do
    accumulate((1..3)) { |a, b| a + b }.should eq([1, 3, 6])
    accumulate((1..3)) { |a, b| a - b }.should eq([-1, -3, -6])
  end

  it "works with an initial value and assumed accumulator function" do
    accumulate([1, 2, 3], 4).should eq([5, 7, 10])
    accumulate([1, 2, 3], 4.5).should eq([5.5, 7.5, 10.5])
  end

  it "works with an assumed accumulater and assumed initial value" do
    accumulate([1, 2, 3]).should eq([1, 3, 6])
  end

  it "handles empty collections" do
    accumulate([] of Int32).should eq([] of Int32)
  end
end

describe Enumerable do
  describe "#accumulate" do
    it { ([] of Int32).accumulate.should eq([] of Int32) }
    it { [1, 2, 3].accumulate.should eq([1, 3, 6]) }
    it { [1, 2, 3].accumulate(4).should eq([5, 7, 10]) }
    it { [1, 2, 3].accumulate(4.5).should eq([5.5, 7.5, 10.5]) }
    it { (1..3).accumulate { |a, b| a + b }.should eq([1, 3, 6]) }
    it { (1..3).accumulate { |a, b| a - b }.should eq([-1, -3, -6]) }
    it { (1..3).accumulate(1.5) { |a, b| a + b }.should eq([2.5, 4.5, 7.5]) }
  end
end
