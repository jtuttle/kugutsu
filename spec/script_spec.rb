require "spec_helper"

RSpec.describe Kugutsu::Script do
  let(:scene_file) { File.new("spec/fixtures/valid_scene.json") }
  let(:script) { Kugutsu::Script.new }

  describe "loading a valid scene file" do
    it "does not raise an error" do
      script.load_scene_file(scene_file)
    end
  end

  describe "enabling actions" do
    before do
      script.load_scene_file(scene_file)
    end
    
    it "enables events with no conditions" do
      enabled_action_ids = []
      script.event_bus.add_event_listener(
        :test_action_enabled,
        -> (action_id) { enabled_action_ids << action_id }
      )
      
      script.enable_actions

      expect(enabled_action_ids).to eq(["test_1"])
    end
  end
  
  describe "completing an action" do
    before do
      script.load_scene_file(scene_file)
      script.enable_actions
    end
    
    it "enables new actions whose conditions are met" do
      enabled_action_ids = []
      script.event_bus.add_event_listener(
        :test_action_enabled,
        -> (action_id) { enabled_action_ids << action_id }
      )
      
      script.event_bus.dispatch_event(:complete_test_action)

      expect(enabled_action_ids).to eq(["test_2"])
    end
  end
end
