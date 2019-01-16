# Lolcommits Glitch
Glitch it up.

![glitch commit](https://github.com/tooluser/lolcommits-glitch/raw/master/assets/images/96385860786.jpg)
![glitch commit](https://github.com/tooluser/lolcommits-glitch/raw/master/assets/images/ab409ebe370.jpg)

## Installation

Follow the [install guide](https://github.com/mroth/lolcommits#installation) for
lolcommits first. Then run the following:

	$ gem build lolcommits-glitch.gemspec
    $ gem install lolcommits-glitch

Next configure and enable this plugin with:

    $ lolcommits --config -p glitch
    # set enabled to `true` and configure other options as you like

## Requirements
Lolcommits Glitch uses RMagick, which relies upon ImageMagick 6. If you have only 7 installed, you will receive an error about a missing header. To install 6 in parallel with 7:

```
PKG_CONFIG_PATH=/usr/local/Cellar/imagemagick@6/6.9.10-14/lib/pkgconfig/ gem install rmagick -v '2.16.0' -- --with-opt-lib=/usr/local/Cellar/imagemagick@6/6.9.10-14/lib/ --with-opt-include=/usr/local/Cellar/imagemagick/6.9.10-14/include/ImageMagick-6/
```

There is no need to unlink 7. 

## Development

Check out this repo and run `bin/setup`, this will install dependencies and
generate docs. Run `bundle exec rake` to run all tests and generate a coverage
report.

You can also run `bin/console` for an interactive prompt that will allow you to
experiment with the gem code.

## Tests

In the spirit of glitching, there are no tests. 

## License

The gem is available as open source under the terms of
[LGPL-3](https://opensource.org/licenses/LGPL-3.0).
