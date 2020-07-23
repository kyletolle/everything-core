# Changelog

## 0.0.12

- Add an Everything logger
- Add a Debug logger
- Add a Verbose logger
- Add an Error logger
- Add a LogIt module to make logging easy

## 0.0.11

- Update changelog for 0.0.10 changes
- Update travis settings to use ruby 2.7.1 and bundler 2

## 0.0.10

- Upgrade to Bundler v2

## 0.0.9

- Make Content#file_name a public method

## 0.0.8

- Require modules which had been used but not explicitly required
- Add #raw_markdown=, #save to Content
- Add #raw_yaml=, #save to Metadata
- Add #raw_markdown=, #raw_yaml, #raw_yaml=, #save to Piece

## 0.0.7

- Add a piece#name to return the name from the piece's path

## 0.0.6

- Add an Everything::Piece::Content class
- Add an Everything::Piece::Metadata class
- Rename piece#content to piece#body
- Add a piece#content to return the piece's content
- Add a piece#metadata to return the piece's metadata
- Add a piece#public? for easily checking the metadata for the `public` boolean

## 0.0.5

- Increase version number of dotenv dependency

## 0.0.4

- Add Everything::Piece#full_path to return path of the piece

## 0.0.3

- Change `Everything` from a class to a module
- Add basic rspec coverage

## 0.0.2

- Add dotenv support

## 0.0.1

- Initial release
