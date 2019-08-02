require "./../spec_helper"

describe Numcry::Stats do
  describe ".cov" do
    a = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    b = [9, 8, 7, 6, 5, 4, 3, 2, 1]
    it { cov(a, a).should be_close(a.var, 1e-10) }
    it { cov(a, b, ddof: 1).should be_close(-7.500, 1e-3) }
    it { cov(a, b).should eq(cov b, a) }
  end
end

describe Enumerable do
  describe "#cov" do
    a = [0, 3, 4]
    b = [1, 2, 4]
    c = [3, 4, 5]
    it { a.cov(a, ddof: 1).should be_close(4.333, 1e-3) }
    it { a.cov(b, ddof: 1).should be_close(2.833, 1e-3) }
    it { a.cov(c, ddof: 1).should be_close(2.000, 1e-3) }
    it { b.cov(b, ddof: 1).should be_close(2.333, 1e-3) }
    it { b.cov(c, ddof: 1).should be_close(1.500, 1e-3) }
    it { c.cov(c, ddof: 1).should be_close(1.000, 1e-3) }
  end
end
