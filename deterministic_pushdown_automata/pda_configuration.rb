# frozen_string_literal: true

PDAConfiguration = Struct.new(:state, :stack) do
  STUCK_STATE = Object.new

  def stuck
    PDAConfiguration.new(STUCK_STATE, stack)
  end

  def stuck?
    state == STUCK_STATE
  end
end
