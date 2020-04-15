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
gem 'everything-core', require: 'everything'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install everything-core


## Requiring

You can require it yourself in your code:

```
require 'everything'
```

Or, if you use Bundler and list the gem in your Gemfile, you can require all the
gems from your Gemfile:

```ruby
require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)
```


## Usage

This assumes you have a `EVERYTHING_PATH` environment variable either set in
your shell or in dotenv's `.env` file.

For example, let's assume you have the following folder and file under your
everything path

```ruby
your-piece-here/index.md

# Your Piece Here

The rest of the body of your file...

```

To use the piece from IRB, you could do the following to get the piece's title
and content.

```ruby
require 'everything'

piece_path = File.join(Everything.path, 'your-piece-here')
piece      = Everything::Piece.new(piece_path)

piece.name          # => 'your-piece-here'
piece.title         # => "Your Piece Here"
piece.body          # => "The rest of the body of your file...\n\n"
piece['categories'] # Returns the value for the `categories` metadata key
piece.public?       # Convience method to return the value for the boolean `public` metadata key
piece.content       # Return an instance of the piece's content
piece.metadata      # Return an instance of the piece's metadata
```

You can also edit a piece's content and metadata

```ruby
piece.raw_markdown = some_markdown # Sets the raw_markdown on the piece's content
piece.raw_yaml     = some_yaml     # Sets the raw_yaml on the piece's metadata
piece.save                         # Save the piece's content and metadata to disk
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`rake spec` to run the tests. You can also run `bin/console` for an interactive
prompt that will allow you to experiment.

To install this gem onto your local machine, run `rake install`.

To release a new version,
- check out a new branch
- make your code changes
- update the version number in `lib/everything/version.rb`
- update the `CHANGELOG.md` with what changed.
- commit your code changes
- push new branch to github with `git push -u origin HEAD`
- create a new PR for this
- merge in PR to master
- locally, check out master again
- git pull
- create a build with `rake build`
- run `rake release`, which will create a git tag for the version,
push git commits and tags, and push the `.gem` file to
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

