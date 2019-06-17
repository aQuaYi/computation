# frozen_string_literal: true

class Variable < Struct.new(:name)
  def to_s
    name.to_s
  end

  def inspect
    "«#{self}»"
  end

  def evaluate(environment)
    environment[name]
  end
end
