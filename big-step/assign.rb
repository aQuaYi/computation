# frozen_string_literal: true

require_relative 'doNothing'

class Assign < Struct.new(:name, :expression)
  def to_s
    "#{name} = #{expression}"
  end

  def inspect
    "«#{self}»"
  end

  def reducible?
    true
  end

  def reduce(environment)
    if expression.reducible?
expression_reduce, environment= expression.reduce(environment)
      [Assign.new(name, expression_reduce), environment]
    else
      [DoNothing.new, environment.merge(name => expression)]
    end
  end
end
