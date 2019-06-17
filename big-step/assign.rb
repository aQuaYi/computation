# frozen_string_literal: true

require_relative 'doNothing'

class Assign < Struct.new(:name, :expression)
  def to_s
    "#{name} = #{expression}"
  end

  def inspect
    "«#{self}»"
  end

  def evaluate(environment)
    environment.merge({name=> expression.evaluate(environment)})
  end
end
