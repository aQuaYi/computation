# frozen_string_literal: true

require_relative 'all'

puts Number.new(23).evaluate({})

puts '-----------------------------------------'

puts Variable.new(:x).evaluate(x: Number.new(23))

LessThan.new(
  Add.new(Variable.new(:x), Number.new(2)),
  Variable.new(:y)
).evaluate(x: Number.new(2), y: Number.new(5))

puts '-----------------------------------------'

statement =
  Sequence.new(
    Assign.new(:x, Add.new(Number.new(1), Number.new(1))),
    Assign.new(:y, Add.new(Variable.new(:x), Number.new(3)))
  )
puts statement.evaluate({})

puts '-----------------------------------------'

statement =
  While.new(
    LessThan.new(Variable.new(:x), Number.new(5)),
    Assign.new(:x, Multiply.new(Variable.new(:x), Number.new(3)))
  )
puts statement.evaluate(x: Number.new(1))

puts '-----------------------------------------'
