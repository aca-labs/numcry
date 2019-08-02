# Tools for producing cumulative values across collections.
module Numcry::Accumulate
  extend self

  # Return an `Array` containing the cumulative sum of elements from
  # *collection*.
  #
  # ```
  # cumsum((1..3)) # => [1, 3, 6]
  # ```
  def cumsum(collection : Enumerable(T)) forall T
    accumulate(collection, Reflect(T).first.zero) { |a, b| a + b }
  end

  # Return an `Array` containing the cumulative product of elements from
  # *collection*.
  #
  # ```
  # cumprod((1..3)) # => [1, 2, 6]
  # ```
  def cumprod(collection : Enumerable(T)) forall T
    accumulate(collection, Reflect(T).first.zero + 1) { |a, b| a * b }
  end

  # Accumulate the results of applying the passed block to each element in
  # *collection* and the previous cumulative value, starting with *initial*.
  #
  # ```
  # accumulate((1..3), 10) { |a, b| a + b } # => [11, 13, 16]
  # ```
  def accumulate(collection : Enumerable(T), initial : U, &block : U, T -> U) forall T, U
    Array(U).build(collection.size) do |buffer|
      accum = initial
      collection.each_with_index do |x, i|
        buffer[i] = accum = yield accum, x
      end
      collection.size
    end
  end
end

module Enumerable(T)
  def cumsum
    Numcry::Accumulate.cumsum(self)
  end

  def cumprod
    Numcry::Accumulate.cumprod(self)
  end

  def accumulate(initial : U, &block : U, T -> U) forall U
    Numcry::Accumulate.accumulate(self, initial, &block)
  end
end
