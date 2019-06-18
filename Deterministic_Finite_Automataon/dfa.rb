# frozen_string_literal: true

DFA = Struct.new(:current_state, :accept_states, :rulebook) do
  def accepting?
    accept_states.include?(current_state)
  end

  def read_character(character)
    self.current_state = rulebook.next_state(current_state, character)
  end

  def read_string(string)
    string.chars.each do |char|
      read_character(char)
    end
  end
end
