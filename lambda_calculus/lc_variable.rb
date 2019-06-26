# frozen_string_literal: true

LCVariable = Struct.new(:name) do
  def to_s
    name.to_s
  end

  def inspect
    to_s
  end

  def replace(name, replacement)
    if self.name == name
      replacement
    else
      self
    end
  end

  def callable?
    false
  end

  def reducible?
    false
  end
end
