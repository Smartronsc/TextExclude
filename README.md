# TextExclude

This README will document whatever steps are necessary to get the
application up and running once I figure out what they are.

Things I do know:

* This was written using ruby 2.3
* Only works with linux for now due to using files
* Configuration: none
* Database creation: None
* Database initialization: None
* How to run the test suite
* Services (job queues, cache servers, search engines, etc.): None
* Deployment instructions: Not yet

## Installation

Assure Bundler is installed

    $ gem install bundler

Install dependencies

    $ bundle install

Then execute text_include

    $ bundle exec exe/text_exclude

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies.
Run `rake test` to run the tests, or run `bin/console`
for an interactive prompt to experiment.

<!--
To install this gem onto your local machine, run
`bundle exec rake install`. To release a new version, update the version
number in `version.rb`, and then run `bundle exec rake release`, which
will create a git tag for the version, push git commits and tags, and
push the `.gem` file to [rubygems.org](https://rubygems.org).
-->

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/Smartronsc/TextExclude. This project is intended to be a
safe, welcoming space for collaboration, and contributors are expected
to adhere to the [Contributor Covenant](http://contributor-covenant.org)
code of conduct.

### To Do List

The following tasks are provided as ideas for contributors:

#### Maintainer

* Set up the
[GitHub project wiki](https://help.github.com/articles/about-github-wikis/)
for developer documentation
* Set up [GitHub Pages](https://pages.github.com) for user documentation 
* Set up [Travis CI](https://travis-ci.org/) for the project

#### Contributors

* Resolve run-time warnings. The code should run cleanly with the `-w` flag
* Assure variables are initialized
* Assure no parameters shadow outer parameters or local variables
* Remove places where values are assigned to variables but the variables
are not used (or document why this was done)
* Remove global variables (or document why they are used)
* Assure all case statements have a meaningful else clause
* Assure no line has more than 80 characters
* Assure no method has more than 10 lines of code (refactor long methods)
* Assure no block has more than 25 lines of code
* Assure no class has more than 100 lines of code (create helper classes)

## License

The gem is available as open source under the terms of the
[MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the TextExclude project’s codebases, issue
trackers, chat rooms and mailing lists is expected to follow the
[code of conduct](https://github.com/[USERNAME]/test/blob/master/CODE_OF_CONDUCT.md).
