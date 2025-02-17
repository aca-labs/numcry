require "./stats"

# Methods for computing correlation coefficients between `Enumerable`
# collections.
module Numcry::Correlate
  extend self

  # Compute the covariance between two collections *a* and *b*.
  def cov(a : Enumerable(T), b : Enumerable(U), ddof = 0.0) forall T, U
    raise ArgumentError.new("sizes must be uniform") if a.size != b.size
    e = a.mean.to_i64 * b.mean.to_i64
    a.zip(b).sum { |x, y| x.to_i64 * y.to_i64 - e } / (a.size - ddof)
  end

  # Compute the Pearson correlation coefficient for *a* and *b*.
  def corrcoef(a : Enumerable, b : Enumerable, ddof = 0.0)
    cov(a, b, ddof) / (Stats.std(a, ddof) * Stats.std(b, ddof))
  end
end

module Enumerable(T)
  def cov(other : Enumerable, ddof = 0.0)
    Numcry::Correlate.cov self, other, ddof
  end

  def corrcoef(other : Enumerable, ddof = 0.0)
    Numcry::Correlate.corrcoef self, other, ddof
  end
end
