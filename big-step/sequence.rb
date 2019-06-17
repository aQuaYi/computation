# frozen_string_literal: true

class Sequence < Struct.new(:first, :second)
  def to_s
    "#{first}; #{second}"
  end

  def inspect
    "«#{self}»"
  end

  def evaluate(environment)
    second.evaluate(first.evaluate(environment))
  end
end
