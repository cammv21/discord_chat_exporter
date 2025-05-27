require_relative "discord_chat_exporter/exporter"

module DiscordChatExporter
  class << self
    attr_accessor :configuration
  end

  class Configuration
    attr_accessor :default_filename, :default_limit, :log_verbose

    def initialize
      @default_filename = "export_chat.txt"
      @default_limit = 100
      @log_verbose = false
    end
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end
end