module Kugutsu
  class Action
    include Miru::EventDispatcher
    
    attr_reader :id, :conditions
    attr_accessor :children
    
    def initialize(action_data, event_bus)
      @id = action_data['id']
      @conditions = action_data['conditions'] || []
      @event_bus = event_bus

      @children = []
    end

    def enable
      
    end

    def complete
      dispatch_event(:complete, self)
    end
    
    def transient_effect

    end
    
    def persistent_effect
      
    end

    def to_s
      "<#{self.class} id: #{@id}>"
    end
  end
end
