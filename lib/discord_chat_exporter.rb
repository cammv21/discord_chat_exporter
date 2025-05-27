require "discord_chat_exporter/exporter"

module DiscordChatExporter
  class << self
    attr_accessor :configuration
  end

  # Clase de configuración interna
  class Configuration
    attr_accessor :default_filename, :default_limit, :log_verbose

    def initialize
      @default_filename = "export_chat.txt"
      @default_limit = 100
      @log_verbose = false
    end
  end

  # Método para acceder/configurar la configuración global
  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end
end