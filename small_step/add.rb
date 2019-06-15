# frozen_string_literal: true

require_relative 'number'

class Add < Struct.new(:left, :right)
  def to_s
    "#{left} + #{right}"
  end

  def inspect
    "«#{self}»"
  end

  def reducible?
    true
  end

  def reduce(environment)
    if left.reducible?
      left_reduce,  environment = left.reduce(environment)
      [Add.new(left_reduce, right), environment]
    elsif right.reducible?
      right_reduce, environment = right.reduce(environment)
      [Add.new(left, right_reduce), environment]
    else
      [Number.new(left.value + right.value), environment]
    end
  end
end
