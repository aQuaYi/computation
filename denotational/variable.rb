# frozen_string_literal: true

Variable = Struct.new(:name) do
  def to_s
    name.to_s
  end

  def inspect
    "«#{self}»"
  end

  def to_ruby
    "-> e { e[#{name.inspect}] }"
  end
end
