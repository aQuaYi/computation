# frozen_string_literal: true

DFARulebook = Struct.new(:rules) do
  def next_state(state, character)
    rule_for(state, character).follow
  end

  def rule_for(state, character)
    rules.find { |rule| rule.applies_to?(state, character) }
  end
end
