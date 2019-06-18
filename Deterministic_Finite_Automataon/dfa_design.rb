# frozen_string_literal: true

require_relative 'dfa'

DFADesign = Struct.new(:start_state, :accept_states, :rulebook) do
  def to_dfa
    DFA.new(start_state, accept_states, rulebook)
  end

  def accepts?(string)
    to_dfa.tap { |dfa| dfa.read_string(string) }.accepting?
  end
end
