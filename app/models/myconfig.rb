require "erb"
require "yaml"

class Myconfig
  include Singleton

  def initialize
    load_myconfig_yml.each do |key, value|
      define_singleton_method(key) { value }
    end
  end

  private def load_myconfig_yml
    path = Rails.root.join("config/myconfig.yml")
    yaml = ERB.new(path.read).result(binding)
    hash = YAML.safe_load(yaml)

    namespace = ENV.fetch("MYCONFIG_NAMESPACE")
    hash.fetch(namespace)
  end
end
