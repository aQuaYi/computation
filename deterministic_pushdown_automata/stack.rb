# frozen_string_literal: true

# after modify stack, generate new stack
Stack = Struct.new(:contents) do
  def push(character)
    # new character in the head
    Stack.new([character] + contents)
  end

  def pop
    # drop head
    Stack.new(contents.drop(1))
  end

  def top
    contents.first
  end

  def inspect
    "#<Stack (#{top})#{contents.drop(1).join}>"
  end
end
