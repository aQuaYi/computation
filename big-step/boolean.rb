# frozen_string_literal: true

Boolean = Struct.new(:value) do
  def to_s
    value.to_s
  end

  def inspect
    "«#{self}»"
  end

  def evaluate(_environment)
    self
  end
end
