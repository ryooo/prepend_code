# prepend_code

prepend_code will prepend context on your files.

prepend_code mainly supports:

* It handles recursively to the directory.

## Supported Ruby versions and implementations
I've tested on:(maybe move on 1.8.7, 1.9.2 too)

* Ruby 1.9.3

## Install

    $ gem install prepend_code

## Usage

### on your rails project directory
    $ prepend_code

### view all options by --help.
    $ prepend_code --help

### specify context.
    $ prepend_code -t "# Copyright (c) 2013 ryooo321."
    $ # default : # coding: utf-8

### specify target directory.
    $ prepend_code -d ./lib
    $ # default : ./app

### specify target file extension.
    $ prepend_code -e .erb
    $ # default : .rb

## For dev

### run rspec
    $ rake spec

### set gem version
    $ rake version:write MAJOR=0 MINOR=1 PATCH=0

### build gem
    $ rake build

### release gem to RubyGems.org
    $ rake release

### Other

## Contributing to Lapidary
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2013 ryooo321. See LICENSE.txt for further details.
