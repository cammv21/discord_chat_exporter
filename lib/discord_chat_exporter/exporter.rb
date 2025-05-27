require "discordrb"
require "json"

module DiscordChatExporter
  class Exporter
    def initialize(token:, channel_id:)
      @bot_token = token
      @channel_id = channel_id
    end

    def export(filename = "export_chat.txt", format: :txt)
      bot = Discordrb::Bot.new token: @bot_token, intents: [:servers, :server_messages]

      bot.ready do
        channel = bot.channel(@channel_id)
        raise "Canal no encontrado" unless channel

        all_messages = []
        before_id = nil

        loop do
          begin
            messages = channel.history(100, before_id)
          rescue => e
            puts "Error al obtener mensajes: #{e.class} - #{e.message}"
            puts e.backtrace
            break
          end

          break if messages.empty?

          all_messages.concat(messages)
          before_id = messages.last.id
          sleep 1
          break if messages.size < 100
        end

        case format
        when :json
          messages_data = all_messages.reverse.map do |msg|
            {
              id: msg.id,
              timestamp: msg.timestamp,
              author: msg.author.distinct,
              content: msg.content,
              attachments: msg.attachments.map(&:url),
              stickers: msg.respond_to?(:stickers) ? msg.stickers.map(&:name) : [],
              embeds: msg.embeds.map { |e| e.title || nil }.compact
            }
          end

          File.open(filename, 'w') do |f|
            f.write(JSON.pretty_generate(messages_data))
          end
        else # :txt
          File.open(filename, 'w') do |f|
            all_messages.reverse.each do |msg|
              line = "[#{msg.timestamp}] #{msg.author.distinct}:"
              line += " #{msg.content}" if msg.content && !msg.content.empty?
              unless msg.attachments.empty?
                line += " [Archivos: #{msg.attachments.map(&:url).join(', ')}]"
              end
              unless msg.respond_to?(:stickers) ? msg.stickers.empty? : true
                line += " [Stickers: #{msg.stickers.map(&:name).join(', ')}]"
              end
              unless msg.embeds.empty?
                line += " [Embeds: #{msg.embeds.map { |e| e.title || 'embed' }.join(', ')}]"
              end
              f.puts line
            end
          end
        end

        puts "Exportación completada. Mensajes guardados en #{filename}"
        exit
      end

      bot.run
    end
  end
end