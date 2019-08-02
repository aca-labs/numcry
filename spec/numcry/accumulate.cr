require "./../spec_helper"

describe Numcry::Accumulate do
  describe ".accumulate" do
    it { accumulate((1..3), 10) { |a, b| a + b }.should eq([11, 13, 16]) }
    it { accumulate((1..3), 0) { |a, b| a - b }.should eq([-1, -3, -6]) }
  end

  describe ".cumsum" do
    it { cumsum((1..3)).should eq([1, 3, 6]) }
    it { cumsum([] of Int32).should eq([] of Int32) }
  end

  describe ".cumprod" do
    it { cumprod((1..3)).should eq([1, 2, 6]) }
    it { cumprod([] of Int32).should eq([] of Int32) }
  end
end

describe Enumerable do
  it { (1..3).accumulate(1.5) { |a, b| a + b }.should eq([2.5, 4.5, 7.5]) }
  it { ([] of Int32).cumsum.should eq([] of Int32) }
  it { [1, 2, 3, 4, 5, 6].cumsum.should eq([1, 3, 6, 10, 15, 21]) }
  it { [1, 2, 3, 4, 5, 6].cumprod.should eq([1, 2, 6, 24, 120, 720]) }
end
