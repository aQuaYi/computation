# frozen_string_literal: true

DARule = Struct.new(:state, :character, :next_state,
                    :pop_character, :push_characters) do
  def applies_to?(configuration, character)
    state == configuration.state &&
      pop_character == configuration.stack.top &&
      self.character == character
  end

  def follow(configuration)
    PDAConfiguration.new(next_state, next_stack(configuration))
  end

  def next_stack(configuration)
    popped_stack = configuration.stack.pop

    push_characters.reverse
                   .inject(popped_stack) { |stack, character| stack.push(character) }
  end
end
