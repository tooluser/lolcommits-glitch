require "lolcommits/plugin/base"
require "rmagick"
require "faker"

include Magick

module Lolcommits
  module Plugin
    class Glitch < Base
      DEFAULT_GLITCH_LEVEL = 7
      DEFAULT_GLITCH_CHANCE = 100

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

      def run_post_capture
        if runner.capture_image?
          images = Magick::Image.read(runner.lolcommit_path)
          glitch_image = image = images.first

          wax_poetic
          if rand(100) < config_option(:glitch_probability)
            debug "Glitching #{width(image)} x #{height(image)} #{config_option(:glitch_level)} times"
            glitch_image = glitch_image(image)
          end

          glitch_image.write runner.lolcommit_path
        else
          debug "no image to glitch for a video or gif lolcommit"
        end
      end

      def default_options
        {
          glitch_level: DEFAULT_GLITCH_LEVEL,
          glitch_probability: DEFAULT_GLITCH_CHANCE,
        }
      end

      def valid_configuration?
        !@configuration.nil? && !@configuration[:glitch_level].nil?
      end

      private

      def wax_poetic
        chance = config_option(:glitch_probability)
        phrase = [
          Faker::Hacker.say_something_smart,
          [Faker::Hacker.ingverb, Faker::Hacker.adjective, Faker::Hacker.noun].join(" "),
          Faker::Company.bs,
          Faker::ChuckNorris.fact,
          "awaiting particle strike",
          "detecting particle spin",
          "flipping #{chance} coins",
          "rolling D#{chance}",
        ].sample
        puts "Glitch probability generator warming up... #{phrase}"
      end

      def glitch_image(image)
        image.dup.tap do |glitch_image|
          config_option(:glitch_level).times do
            debug_glitch_iteration glitch_args = glitch_args_for(image)
            glitch_image.composite!(*glitch_args)
          end
        end
      end

      def debug_glitch_iteration(args)
        debug "…Glitching… with #{"%-#{COMPOSITE_OPERATORS.map(&:to_s).map(&:length).max}s" % args[3]} @ #{args[1..2]}"
      end

      # dont memoize!
      def glitch_args_for(image)
        [
          image,
          glitch_at_x(image),
          glitch_at_y(image),
          COMPOSITE_OPERATORS.sample,
        ]
      end

      # dont memoize!
      def glitch_at_x(image)
        rand(0...width(image)) * [-1, 1].sample
      end

      # dont memoize!
      def glitch_at_y(image)
        rand(0...height(image)) * [-1, 1].sample
      end

      def width(image)
        @width ||= image.columns
      end

      def height(image)
        @height ||= image.rows
      end
    end
  end
end
