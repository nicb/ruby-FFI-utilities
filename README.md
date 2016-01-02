# Ruby FFI::Utilities

[![Gem Version](https://badge.fury.io/rb/ruby-FFI-utilities.svg)](https://badge.fury.io/rb/ruby-FFI-utilities)
[![Build Status](https://travis-ci.org/nicb/ruby-FFI-utilities.svg?branch=master)](https://travis-ci.org/nicb/ruby-FFI-utilities)
[![Code Climate](https://codeclimate.com/github/nicb/ruby-FFI-utilities/badges/gpa.svg)](https://codeclimate.com/github/nicb/ruby-FFI-utilities)
[![Test Coverage](https://codeclimate.com/github/nicb/ruby-FFI-utilities/badges/coverage.svg)](https://codeclimate.com/github/nicb/ruby-FFI-utilities/coverage)
[![Issue Count](https://codeclimate.com/github/nicb/ruby-FFI-utilities/badges/issue_count.svg)](https://codeclimate.com/github/nicb/ruby-FFI-utilities)

Utilities for the `FFI` (*Foreign Function Interface*) library for Ruby

## Description

The `FFI` library is fantastic in many ways. Sometimes we wish to have some
extra features to be added upon request. We put these features in this
`FFI::Utilities` library.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ruby-FFI-utilities'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ruby-FFI-utilities

## Implemented Utilities

Currently implemented utility functions are:

* `set_args(array_of_string_arguments)` - transforms a `ruby` string array
  into an array suitable to be passed to a `C` function that accepts a `char *[]` argument
* `set_string(const char *string)` - transforms a `ruby` string
  into a string pointer suitable to be passed to a `C` function that accepts a
  `const char *` or a `char *` argument

There are also two wrappers for `FFI::Struct` and `FFI::ManagedStruct`,
respectively called `FFI::Utilities::Struct` and
`FFI::Utilities::ManagedStruct. These two wrappers implement some features,
such as:

* attribute accessors
* attribute `char` accessors, which implement single `char` type access to
  data structures (separated from usual attribute accessors because `ruby`
  does not make a difference between single-char and multiple-char `String`s
* private `new` method
* public `create(*args) [{ |this, *args| ... }]` method, which substitutes `new`
* `struct_initialize(*args)` private function which mimicks the functionality
  of `initialize` but gets called by `create`

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/ruby-FFI-utilities/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## License

  GNU GENERAL PUBLIC LICENSE
  Version 2, June 1991

  Ruby FFI Utilities
  Copyright (C) 2015 Nicola Bernardini

  This program is free software; you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation; either version 2 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License along
  with this program; if not, write to the Free Software Foundation, Inc.,
  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
