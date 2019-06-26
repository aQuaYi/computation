# frozen_string_literal: true

require_relative 'lc_call'
require_relative 'lc_function'
require_relative 'lc_variable'

one =
  LCFunction.new(:p,
                 LCFunction.new(:x,
                                LCCall.new(LCVariable.new(:p), LCVariable.new(:x))))

puts one

increment =
  LCFunction.new(:n,
                 LCFunction.new(:p,
                                LCFunction.new(:x,
                                               LCCall.new(
                                                 LCVariable.new(:p),
                                                 LCCall.new(
                                                   LCCall.new(LCVariable.new(:n), LCVariable.new(:p)),
                                                   LCVariable.new(:x)
                                                 )
                                               ))))

puts '---increment--------------------------------'

puts increment

add =
  LCFunction.new(:m,
                 LCFunction.new(:n,
                                LCCall.new(LCCall.new(LCVariable.new(:n), increment), LCVariable.new(:m))))

puts '---add--------------------------------------'

puts add

puts '--------------------------------------------'

expression = LCVariable.new(:x)
puts expression

puts expression.replace(:x, LCFunction.new(:y, LCVariable.new(:y)))

puts expression.replace(:z, LCFunction.new(:y, LCVariable.new(:y)))

expression =
  LCCall.new(
    LCCall.new(
      LCCall.new(
        LCVariable.new(:a),
        LCVariable.new(:b)
      ),
      LCVariable.new(:c)
    ),
    LCVariable.new(:b)
  )
puts expression

puts expression.replace(:a, LCVariable.new(:x))

puts expression.replace(:b, LCFunction.new(:x, LCVariable.new(:x)))

puts '--------------------------------------------'

expression =
  LCFunction.new(:y,
                 LCCall.new(LCVariable.new(:x), LCVariable.new(:y)))
puts expression

puts expression.replace(:x, LCVariable.new(:z))

puts expression.replace(:y, LCVariable.new(:z))

puts '---只会替换相关变量----------------------------'

expression =
  LCCall.new(
    LCCall.new(LCVariable.new(:x), LCVariable.new(:y)),
    LCFunction.new(:y, LCCall.new(LCVariable.new(:y), LCVariable.new(:x)))
  )
puts expression

puts expression.replace(:x, LCVariable.new(:z))

puts expression.replace(:y, LCVariable.new(:z))

puts '---模拟一个函数被调用---------------------------'

function =
  LCFunction.new(:x,
                 LCFunction.new(:y,
                                LCCall.new(LCVariable.new(:x), LCVariable.new(:y))))
puts expression

argument = LCFunction.new(:z, LCVariable.new(:z))
puts argument

puts function.call(argument)

puts '---一加一------------------------------------'

expression = LCCall.new(LCCall.new(add, one), one)
puts expression

while expression.reducible?
  puts expression
  expression = expression.reduce
end; puts expression

inc = LCVariable.new(:inc)
zero = LCVariable.new(:zero)

expression = LCCall.new(LCCall.new(expression, inc), zero)

while expression.reducible?
  puts expression
  expression = expression.reduce
end; puts expression

puts '---treetop------------------------------------'
require 'treetop'
Treetop.load('lambda_calculus')

parse_tree = LambdaCalculusParser.new.parse('-> x { x[x] }[-> y { y }]')
puts parse_tree

expression = parse_tree.to_ast
puts expression

puts expression.reduce
