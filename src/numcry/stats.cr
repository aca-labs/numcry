require "math"

# Extensions for the `Enumerable` module to support common stats methods.
module Numcry::Stats
  extend self

  # Compute the mean for values contained within *collection*.
  #
  # ```
  # mean(1..6) # => 3.5
  # ```
  def mean(collection : Enumerable(T)) forall T
    collection.sum / collection.size.to_f
  end

  # Compute the variance across values contained in *collection*.
  #
  # Default normalisation (N) is applied such that this may be used directly on
  # collections representing the full population. When working with a sample,
  # *ddof* may be used to specify a delta degrees of freedom and correct bias.
  #
  # ```
  # var(1..6) # => 2.917
  # ```
  def var(collection : Enumerable(T), ddof = 0.0) forall T
    return 0.0 if collection.size == 0
    u = mean collection
    collection.sum { |x| (x - u) ** 2 } / (collection.size - ddof)
  end

  # Compute the standard deviation for values within *collection*.
  #
  # ```
  # std(1..6) # => 1.708
  # ```
  def std(collection : Enumerable(T), ddof = 0.0) forall T
    Math.sqrt var(collection, ddof)
  end
end

module Enumerable(T)
  def mean
    Numcry::Stats.mean self
  end

  def var(ddof = 0.0)
    Numcry::Stats.var self, ddof
  end

  def std(ddof = 0.0)
    Numcry::Stats.std self, ddof
  end
end
