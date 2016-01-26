require "imba/rails/version"

require "rails/engine"

require "imba/source"
require "imba/template"

module Imba
  module Rails
    class Transformer
      def initialize(options = {})
        @options = options
      end

      def call(input)
        Imba::Template.new(input[:name], @options) { input[:data] }.render
      end
    end

    class ImbaOptions
      attr_accessor :compiler_options
    end

    class Engine < ::Rails::Engine
      # TODO: not make this global?
      config.imba = ImbaOptions.new

      def configure_assets(app)
        if config.respond_to?(:assets) && config.assets.respond_to?(:configure)
          # Rails 4.x
          config.assets.configure do |env|
            yield env
          end
        else
          # Rails 3.2
          yield app.assets
        end
      end

      initializer 'imba.asset_paths', :after => 'sprockets.environment', :group => :all do |app|
        configure_assets app do |env|
          env.append_path Imba::Source::BROWSER_PATH.to_s
        end
      end

      initializer 'imba.compiler' do |app|
        configure_assets app do |env|
          env.register_mime_type 'text/imba', extensions: ['.imba'], charset: :unicode
          env.register_transformer 'text/imba', 'application/javascript', Transformer.new(app.config.imba.compiler_options)
        end
      end
    end
  end
end
