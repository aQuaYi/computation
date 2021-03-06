# frozen_string_literal: true

require_relative 'doNothing'

Assign = Struct.new(:name, :expression) do
  def to_s
    "#{name} = #{expression}"
  end

  def inspect
    "«#{self}»"
  end

  def to_ruby
    "-> e { e.merge({ #{name.inspect} => (#{expression.to_ruby}).call(e) }) }"
  end
end
