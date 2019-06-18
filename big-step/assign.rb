# frozen_string_literal: true

require_relative 'doNothing'

Assign = Struct.new(:name, :expression) do
  def to_s
    "#{name} = #{expression}"
  end

  def inspect
    "«#{self}»"
  end

  def evaluate(environment)
    environment.merge(name: expression.evaluate(environment))
  end
end
