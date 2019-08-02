# Methods for computing correlation coefficients between `Enumerable`
# collections.
module Numcry::Correlate
  extend self

  # Compute the covariance between two collections *a* and *b*.
  def cov(a : Enumerable(T), b : Enumerable(U), ddof = 0.0) forall T, U
    raise ArgumentError.new("sizes must be uniform") if a.size != b.size
    e = a.mean * b.mean
    a.zip(b).sum { |x, y| x * y - e } / (a.size - ddof)
  end
end

module Enumerable(T)
  def cov(other : Enumerable, ddof = 0.0)
    Numcry::Correlate.cov self, other, ddof
  end
end
