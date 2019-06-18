# frozen_string_literal: true

Sequence = Struct.new(:first, :second) do
  def to_s
    "#{first}; #{second}"
  end

  def inspect
    "«#{self}»"
  end

  def to_ruby
    "-> e { (#{second.to_ruby}).call((#{first.to_ruby}).call(e)) }"
  end
end
