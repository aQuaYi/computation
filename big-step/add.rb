# frozen_string_literal: true

require_relative 'number'

Add = Struct.new(:left, :right) do
  def to_s
    "#{left} + #{right}"
  end

  def inspect
    "«#{self}»"
  end

  def evaluate(environment)
    Number.new(
      left.evaluate(environment).value +
      right.evaluate(environment).value
    )
  end
end
