# frozen_string_literal: true

require_relative 'boolean'

If = Struct.new(:condition, :consequence, :alternative) do
  def to_s
    "if (#{condition}) { #{consequence} } else { #{alternative} }"
  end

  def inspect
    "«#{self}»"
  end

  def to_ruby
    "-> e { if (#{condition.to_ruby}).call(e)" \
      " then (#{consequence.to_ruby}).call(e)" \
      " else (#{alternative.to_ruby}).call(e)" \
      ' end }'
  end
end
