# frozen_string_literal: true

class While < Struct.new(:condition, :body)
  def to_s
    "while (#{condition}) { #{body} }"
  end

  def inspect
    "«#{self}»"
  end

  def to_ruby
    '-> e {' \
      " while (#{condition.to_ruby}).call(e); e = (#{body.to_ruby}).call(e); end;" \
      ' e' \
      ' }'
  end
end
