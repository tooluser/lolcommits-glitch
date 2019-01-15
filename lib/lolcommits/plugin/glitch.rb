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
        
        glitch_image = glitch_image(in_image)

        glitch_image.write runner.main_image
      end

      def enabled?
        super
      end

      def configure_options!
        super
      end

      def default_options
        {
          glitch_level: 7,
        }
      end

      def valid_configuration?
        @configuration != nil && @configuration[:glitch_level] != nil
      end

      private

      private def glitch_image(image)
        glitch_image = image.dup
        debug "Out Image: #{glitch_image.inspect}"
        
        width = image.columns
        height = image.rows
        
        debug "Glitching #{width} x #{height} #{config_option(:glitch_level)} times"
        
        config_option(:glitch_level).times do
          start_x = rand(0...width)
          start_y = rand(0...height)

          debug "   …Glitching…"

          case rand(1..4)
          when 1
            glitch_image.composite!(image, start_x, start_y, COMPOSITE_OPERATORS.sample)
          when 2
            glitch_image.composite!(image, -start_x, start_y, COMPOSITE_OPERATORS.sample)
          when 3
            glitch_image.composite!(image, start_x, -start_y, COMPOSITE_OPERATORS.sample)
          when 4
            glitch_image.composite!(image, -start_x, -start_y, COMPOSITE_OPERATORS.sample)
          end
        end

        glitch_image
      end
    end
  end
end