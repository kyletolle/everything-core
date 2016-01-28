# Everything
[![Gem Version](https://badge.fury.io/rb/everything-core.svg)](http://badge.fury.io/rb/everything-core)
[![Build Status](https://travis-ci.org/kyletolle/everything-core.svg?branch=master)](https://travis-ci.org/kyletolle/everything-core)
[![Code Climate](https://codeclimate.com/github/kyletolle/everything-core/badges/gpa.svg)](https://codeclimate.com/github/kyletolle/everything-core)
[![Dependency Status](https://gemnasium.com/kyletolle/everything-core.svg)](https://gemnasium.com/kyletolle/everything-core)

For familiarity with a `everything` repository, see the
[intro](http://blog.kyletolle.com/introducing-everything/).

The piece is the most important concept of everything. This is the core for
everything, and other pieces will be components you can add into it.

## Setup

Must define these environment variables:

- `EVERYTHING_PATH` - the full path to your everything repo.


## Installation

Add this line to your application's Gemfile:

```ruby
gem install everything-core
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install everything-core


## Usage

This assumes you have a `EVERYTHING_PATH` environment variable either set in
your shell or in dotenv's `.env` file.

For example, let's assume you have the following folder and file under your
everything path

```
your-piece-here/index.md

# Your Piece Here

The rest of the body of your file...

```

To use the piece from IRB, you could do the following to get the piece's title
and content.

```
require 'everything'

piece_path = File.join(Everything.path, 'your-piece-here')
piece      = Everything::Piece.new(piece_path)

piece.title         # => "Your Piece Here"
piece.body          # => "The rest of the body of your file...\n\n"
piece['categories'] # Returns the value for the `categories` metadata key
piece.public?       # Convience method to return the value for the boolean `public` metadata key
piece.content       # Return an instance of the piece's content
piece.metadata      # Return an instance of the piece's metadata
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`rake spec` to run the tests. You can also run `bin/console` for an interactive
prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To
release a new version, update the version number in `version.rb`, and then run
`bundle exec rake release`, which will create a git tag for the version, push
git commits and tags, and push the `.gem` file to
[rubygems.org](https://rubygems.org).


## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/kyletolle/everything-core. This project is intended to
be a safe, welcoming space for collaboration, and contributors are expected to
adhere to the [Contributor Covenant](http://contributor-covenant.org) code of
conduct.


## License

The gem is available as open source under the terms of the [MIT
License](http://opensource.org/licenses/MIT).

