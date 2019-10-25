module Kugutsu
  class SceneParser
    def parse(file, event_bus)
      scene = JSON.parse(file.read)
      
      actions = deserialize_actions(scene['actions'], event_bus)
      
      Scene.new(scene['id'], actions)
    end

    private

    def deserialize_actions(actions_data, event_bus)
      actions_data.map do |action_data|
        klass = to_class_string(action_data['type'])
        Object::const_get(klass).new(action_data, event_bus)
      end
    end

    def to_class_string(action_type_raw)
      action_type_formatted =
        action_type_raw.split(":").
          map { |str| to_pascal_case(str) }.
          join("::")

      "::#{action_type_formatted}Action"
    end

    def to_pascal_case(str)
      str.split("_").map(&:capitalize).join
    end
  end
end
