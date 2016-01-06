# everything-core

For familiarity with a `everything` repository, see the
[intro](http://blog.kyletolle.com/introducing-everything/).

The piece is the most important concept of everything. This is the core for
everything, and other pieces will be components you can add into it.

## Setup

Must define these environment variables:

- `EVERYTHING_PATH` - the full path to your everything repo.

## Installation

```
gem install everything-core
```

## Usage

This assumes you have a `EVERYTHING_PATH` environment variable either set in
your shell or in dotenv's `.env` file.

For example, let's assume you have the following folder and file under your
everything path

```
your-piece-here/index.md

# Your Piece Here

The rest of the content of your file...

```

To use the piece from IRB, you could do the following to get the piece's title
and content.

```
require 'everything'

piece_path = File.join(Everything.path, 'your-piece-here')
piece      = Everything::Piece.new(piece_path)

piece.title   # => "Your Piece Here"
piece.content # => "The rest of the content of your file...\n\n"
```

## License

MIT

