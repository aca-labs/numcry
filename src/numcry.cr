require "./numcry/*"

module Numcry
  VERSION = "1.0.0"

  extend self

  include Accumulate
  include Stats
  include Correlate
end
