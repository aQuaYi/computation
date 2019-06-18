# frozen_string_literal: true

Boolean = Struct.new(:value) do
  def to_s
    value.to_s
  end

  def inspect
    "«#{self}»"
  end

  def to_ruby
    "-> e { #{value.inspect} }"
  end
end
