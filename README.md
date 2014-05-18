app_conf
============
Rails config object for use with YAML, probably.

Use it a like this:
   conf = AppConf::Configurator.new('a' => 'b')
   conf.a
    => "b"

Or perhaps in a Rails initializer:
   AppConfig = AppConf::Configurator.new(YAML.load_file(Rails.root.join('config', 'application.yml'))[Rails.env])

   AppConfig.some_config
    => 'a value defined in config/application.yml'

Or even smashing it into the Rails application config:
   MyRailsApp::Application.configure do
     config.my_rails_app = Configurator.new(YAML.load_file(Rails.root.join('config', 'application.yml'))[Rails.env])
   end

   Rails.configuration.my_rails_app.some_config
    => 'a value defined in config/application.yml'


