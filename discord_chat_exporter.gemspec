Gem::Specification.new do |spec|
  spec.name          = "discord_chat_exporter"
  spec.version       = "0.1.0"
  spec.summary       = "Exporta chats de canales de Discord usando discordrb"
  spec.description   = "Una gema para exportar mensajes de canales de Discord a texto."
  spec.authors       = ["Juan Camilo Muñoz Valencia"]
  spec.email         = ["juanc.munozv021@gmail.com"]
  spec.files         = Dir["lib/**/*.rb"] + ["bin/discord_chat_exporter", "README.md"]
  spec.executables   = ["discord_chat_exporter"]
  spec.require_paths = ["lib"]
  spec.license       = "MIT" # 
  spec.homepage      = "https://github.com/cammv21/discord_chat_exporter" # O el enlace a tu repo/gema
  spec.required_ruby_version = ">= 3.0"
  spec.add_dependency "discordrb", "~> 3.5" # Ajusta a la versión más estable que funcione para ti
end