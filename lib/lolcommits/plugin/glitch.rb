require 'lolcommits/plugin/base'
require "rmagick"
include Magick

module Lolcommits
  module Plugin
    class Glitch < Base
      
      COMPOSITE_OPERATORS = [
        Magick::AddCompositeOp,
        Magick::AtopCompositeOp,
        Magick::BumpmapCompositeOp,
        Magick::ColorBurnCompositeOp,
        Magick::ColorDodgeCompositeOp,
        Magick::ColorizeCompositeOp,
        Magick::HardLightCompositeOp,
        Magick::HueCompositeOp,
        Magick::InCompositeOp,
        Magick::LightenCompositeOp,
        Magick::LinearBurnCompositeOp,
        Magick::LinearDodgeCompositeOp,
        Magick::LinearLightCompositeOp,
        Magick::LuminizeCompositeOp,
        Magick::MultiplyCompositeOp,
        Magick::PegtopLightCompositeOp,
        Magick::PinLightCompositeOp,
        Magick::PlusCompositeOp,
        Magick::ReplaceCompositeOp,
        Magick::SaturateCompositeOp,
        Magick::SoftLightCompositeOp,
        Magick::VividLightCompositeOp,
        Magick::XorCompositeOp,
      ]

      def initialize(runner: nil, name: nil, config: nil)
        super
      end

      def run_post_capture
        debug "In Image: '#{runner.main_image}'"
        
        images = Magick::Image.read(runner.main_image)        
        in_image = images.first
        
        debug "In Image: #{in_image.inspect}"
        debug "Glitching…"
        
        out_image = in_image.dup
        
        debug "Out Image: #{out_image.inspect}"
        
        width = in_image.columns
        height = in_image.rows
        
        debug "Glitching #{width} x #{height} #{config_option(:glitch_level)} times"
        
        config_option(:glitch_level).times do
          start_x = rand(0...width)
          start_y = rand(0...height)

          debug "   …Glitching…"

          case rand(1..4)
          when 1
            out_image.composite!(in_image, start_x, start_y, COMPOSITE_OPERATORS.sample)
          when 2
            out_image.composite!(in_image, -start_x, start_y, COMPOSITE_OPERATORS.sample)
          when 3
            out_image.composite!(in_image, start_x, -start_y, COMPOSITE_OPERATORS.sample)
          when 4
            out_image.composite!(in_image, -start_x, -start_y, COMPOSITE_OPERATORS.sample)
          end
        end

        out_image.write runner.main_image
      end

      def enabled?
        super
      end

      ##
      # Prompts the user to configure all plugin options.
      #
      # Available options can be defined in an Array (@options instance var)
      # and/or a Hash (by overriding the `default_options` method).
      #
      # By default (on initialize), `@options` is set with `[:enabled]`. This is
      # mandatory since `enabled?` checks this option is true before running any
      # capture hooks.
      #
      # Using a Hash to define default options allows you to:
      #
      #  - fall back to default values
      #  - define nested options, user is prompted for each nested option key
      #
      # `configure_option_hash` will iterate over all options prompting the user
      # for input and building the configuration Hash.
      #
      # Lolcommits will save this Hash to a YAML file. During the capture
      # process the configuration is loaded, parsed and available in the plugin
      # class as `@configuration`. Or if you want to fall back to default
      # values, you should use `config_option` to dig the hash.
      #
      # Alternatively you can override this method entirely to customise the
      # process. A helpful `parse_user_input` method is available to help parse
      # strings from STDIN (into boolean, integer or nil values).
      #
      # @return [Hash] the configured plugin options
      #
      def configure_options!
        super
      end

      ##
      # Returns a hash of default options to be presented to the user when
      # configuring (with `configure_options!`.
      #
      # @return [Hash] with the default option names (keys) and values
      #
      def default_options
        {
          glitch_level: 7,
        }
      end

      ##
      # Returns true/false indicating if the plugin has been correctly
      # configured.
      #
      # The default superclass method simply checks if `@configuration` is
      # present (not empty).
      #
      # By default if this method returns false, plugin hooks will not execute
      # and a warning message is shown prompting the user to re-configure the
      # plugin.
      #
      # Override to define your own configuration checks and/or messaging.
      #
      # @return [Boolean] true/false indicating if plugin is correct configured
      #
      def valid_configuration?
        @configuration != nil && @configuration[:glitch_level] != nil
      end
    end
  end
end