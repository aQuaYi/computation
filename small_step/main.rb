# frozen_string_literal: true

require_relative 'all'

Machine.new(
  Assign.new(:x, Add.new(Variable.new(:x), Number.new(1))),
  x: Number.new(2)
).run

puts '-----------------------------------------'

Machine.new(
  Add.new(
    Multiply.new(Number.new(1), Number.new(2)),
    Multiply.new(Number.new(3), Number.new(4))
  )
).run

puts '-----------------------------------------'

Machine.new(
  LessThan.new(Number.new(5), Add.new(Number.new(2), Number.new(2)))
).run

puts '-----------------------------------------'

Machine.new(
  Add.new(Variable.new(:x), Variable.new(:y)),
  x: Number.new(3), y: Number.new(4)
).run

puts '-----------------------------------------'

Machine.new(
  If.new(
    Variable.new(:x),
    Assign.new(:y, Number.new(1)),
    Assign.new(:y, Number.new(2))
  ),
  x: Boolean.new(true)
).run

puts '-----------------------------------------'

Machine.new(
  If.new(Variable.new(:x), Assign.new(:y, Number.new(1)), DoNothing.new),
  x: Boolean.new(false)
).run

puts '-----------------------------------------'

Machine.new(
  Sequence.new(
    Assign.new(:x, Add.new(Number.new(1), Number.new(1))),
    Assign.new(:y, Add.new(Variable.new(:x), Number.new(3)))
  ),
  {}
).run

puts '-----------------------------------------'

Machine.new(
  While.new(
    LessThan.new(Variable.new(:x), Number.new(5)),
    Assign.new(:x, Multiply.new(Variable.new(:x), Number.new(3)))
  ),
  x: Number.new(1)
).run

puts '-----------------------------------------'

# uncomment to execute

# Machine.new(
#   Sequence.new(
#     Assign.new(:x, Boolean.new(true)),
#     Assign.new(:x, Add.new(Variable.new(:x), Number.new(1)))
#   ),
#   {}
# ).run

puts '-----------------------------------------'

Machine.new(
  Add.new(Number.new(1),
          Add.new(Number.new(2),
                  Add.new(Number.new(3),
                          Add.new(Number.new(4),
                                  Add.new(Number.new(5), Number.new(6)))))),
  x: Number.new(2)
).run
