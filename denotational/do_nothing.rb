# frozen_string_literal: true

DoNothing = Struct.new do
  def to_s
    'do-nothing'
  end

  def inspect
    "«#{self}»"
  end

  def ==(other)
    other.instance_of?(DoNothing)
  end

  def to_ruby
    '-> e { e }'
  end
end
