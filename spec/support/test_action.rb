class TestAction < Kugutsu::Action
  def enable
    @event_bus.add_event_listener(:complete_test_action, method(:complete))
    
    @event_bus.dispatch_event(:test_action_enabled, @id)
  end

  def complete
    @event_bus.remove_event_listener(:complete_test_action, method(:complete))
    
    @event_bus.dispatch_event(:test_action_completed, @id)

    super
  end
end

