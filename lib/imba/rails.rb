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

      initializer 'imba.asset_paths', :after => 'sprockets.environment', :group => :all do |app|
        app.assets.append_path Imba::Source::BROWSER_PATH.to_s
      end

      initializer 'imba.compiler' do |app|
        app.assets.register_mime_type 'text/imba', extensions: ['.imba'], charset: :unicode
        app.assets.register_transformer 'text/imba', 'application/javascript', Transformer.new(app.config.imba.compiler_options)
      end
    end
  end
end
