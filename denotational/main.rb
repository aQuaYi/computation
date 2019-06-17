# frozen_string_literal: true

require_relative 'all'

puts Number.new(5).to_ruby

puts Boolean.new(false).to_ruby

puts '-----------------------------------------'

proc = eval(Number.new(5).to_ruby)
puts proc.call({})

proc = eval(Boolean.new(false).to_ruby)
puts proc.call({})

puts '-----------------------------------------'

expression = Variable.new(:x)
puts expression.to_ruby

proc = eval(expression.to_ruby)
puts proc.call(x: 7)

puts '-----------------------------------------'

# Add.new(Variable.new(:x), Number.new(1)).to_ruby
# LessThan.new(Add.new(Variable.new(:x), Number.new(1)), Number.new(3)).to_ruby

environment = { x: 3 }
puts environment

proc = eval(Add.new(Variable.new(:x), Number.new(1)).to_ruby)
puts proc.call(environment)

proc = eval(
  LessThan.new(Add.new(Variable.new(:x), Number.new(1)), Number.new(3)).to_ruby
)
puts proc.call(environment)

puts '-----------------------------------------'

puts statement = While.new(
  LessThan.new(Variable.new(:x), Number.new(5)),
  Assign.new(:x, Multiply.new(Variable.new(:x), Number.new(3)))
)

puts statement.to_ruby

proc = eval(statement.to_ruby)
puts proc.call(x: 1)

puts '-----------------------------------------'
