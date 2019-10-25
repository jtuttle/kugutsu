module Kugutsu
  class Script
    attr_reader :event_bus

    def initialize
      @action_index = {}
      @enabled_actions = Set.new
      @completed_actions = {}

      @event_bus = EventBus.new
    end

    def load_scene_file(scene_file)
      scene = SceneParser.new.parse(scene_file, @event_bus)

      scene.actions.each do |action|
        add_action!(action)
      end
    end

    def enable_actions
      @action_index.values.each do |action|
        enable_action(action) if is_enabled?(action)
      end
    end
    
    private
    
    def add_action!(action)
      action.add_event_listener(:complete, method(:on_action_complete))

      action.conditions.each do |parent_id|
        @action_index[parent_id].children << action.id
      end
      
      @action_index[action.id] = action
    end

    def is_enabled?(action)
      !@completed_actions[action.id] &&
        action.conditions.map { |condition| @completed_actions[condition] }.all?
    end

    def enable_action(action)
      if @enabled_actions.include?(action)
        raise StandardError.new("Action #{action.id} already enabled.")
      end
      
      @enabled_actions << action
      action.enable      
    end
    
    def on_action_complete(action)
      @completed_actions[action.id] = true

      action.children.each do |child_id|
        child_action = @action_index[child_id]
        enable_action(child_action) if is_enabled?(child_action)
      end
    end
  end
end
