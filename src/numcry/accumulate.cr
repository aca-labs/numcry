module Numcry::Accumulate
  extend self

  # Returns as `Array` of cumulative values, starting from zero.
  #
  # ```
  # accumulate((1..3)) # => [1, 3, 6]
  # ```
  def accumulate(collection : Enumerable(T)) forall T
    accumulate collection, Reflect(T).first.zero
  end

  # Returns as `Array` of cumulative values for the *collection*, starting
  # from *initial*.
  #
  # ```
  # accumulate((1..3), 10) # => [11, 13, 16]
  # ```
  def accumulate(collection, initial)
    accumulate(collection, initial) { |a, b| a + b }
  end

  # Returns an `Array` of cumulative values of applying *block* to each element
  # in the collection and the previous accumulated value, starting with zero.
  #
  # ```
  # accumulate((1..3)) { |a, b| a - b } # => [-1, -3, -6]
  # ```
  def accumulate(collection : Enumerable(T), &block) forall T
    accumulate(collection, Reflect(T).first.zero) { |a, b| yield a, b }
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
  def accumulate
    Numcry::Accumulate.accumulate(self)
  end

  def accumulate(initial)
    Numcry::Accumulate.accumulate(self, initial)
  end

  def accumulate(&block : T, T -> T)
    Numcry::Accumulate.accumulate(self, &block)
  end

  def accumulate(initial : U, &block : U, T -> U) forall U
    Numcry::Accumulate.accumulate(self, initial, &block)
  end
end
