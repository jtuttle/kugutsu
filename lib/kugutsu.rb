require "kugutsu/version"

module Kugutsu
  begin
    require 'pry-byebug'
  rescue LoadError
    # development dependencies
  end

  require 'json'
  require 'set'

  require 'miru'

  Gem.find_files("kugutsu/**/*.rb").each { |path| require path }
end
