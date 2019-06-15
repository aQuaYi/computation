require_relative "all"

Machine.new(
    Assign.new(:x, Add.new(Variable.new(:x), Number.new(1))),
    {x: Number.new(2)}
).run

Machine.new(
    Add.new(
        Multiply.new(Number.new(1), Number.new(2)),
        Multiply.new(Number.new(3), Number.new(4))
    )
).run

Machine.new(
    LessThan.new(Number.new(5), Add.new(Number.new(2), Number.new(2)))
).run

Machine.new(
    Add.new(Variable.new(:x), Variable.new(:y)),
    {x: Number.new(3), y: Number.new(4)}
).run

