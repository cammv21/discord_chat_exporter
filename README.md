# DiscordChatExporter

Exporta mensajes de un canal de Discord a un archivo de texto usando la gema `discordrb`.

## Instalación

Agrega esto a tu Gemfile:

```ruby
gem 'discord_chat_exporter'
```

O instala la gema directamente:

```sh
gem build discord_chat_exporter.gemspec
gem install ./discord_chat_exporter-0.1.0.gem
```

## Uso

Desde la línea de comandos:

```sh
discord_chat_exporter TOKEN CHANNEL_ID [ARCHIVO_SALIDA]
```

En código Ruby:

```ruby
require "discord_chat_exporter"
exporter = DiscordChatExporter::Exporter.new(token: "TU_TOKEN", channel_id: 123456789012345678)
exporter.export("archivo.txt")
```