module Kugutsu
  class Scene
    attr_reader :id, :actions

    def initialize(id, actions)
      @id = id
      @actions = actions
    end
  end
end
