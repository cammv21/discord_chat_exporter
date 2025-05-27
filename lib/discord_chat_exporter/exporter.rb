require "discordrb"

module DiscordChatExporter
  class Exporter
    def initialize(token:, channel_id:)
      @bot_token = token
      @channel_id = channel_id
    end

    def export(filename = "export_chat.txt")
      bot = Discordrb::Bot.new token: @bot_token

      bot.ready do
        channel = bot.channel(@channel_id)
        raise "Canal no encontrado" unless channel

        all_messages = []
        before_id = nil

        loop do
          messages = channel.history(100, before_id)
          break if messages.empty?

          all_messages.concat(messages)
          before_id = messages.last.id
          sleep 1
          break if messages.size < 100
        end

        File.open(filename, 'w') do |f|
          all_messages.reverse.each do |msg|
            f.puts "[#{msg.timestamp}] #{msg.author.distinct}: #{msg.content}"
          end
        end

        puts "Exportación completada. Mensajes guardados en #{filename}"
        exit
      end

      bot.run
    end
  end
end