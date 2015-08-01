# Codfi.sh

https://github.com/generalassembly/ga-ruby-on-rails-for-devs


## Getting Started

Install [Homebrew](http://brew.sh/). Then install PostgresSQL with homebrew:

```sh
  $ brew update
  $ brew install postgresql

  # If this is your first install, create a database with:
  $ initdb /usr/local/var/postgres
```

**Set up project**

```sh
  $ git clone git@github.com:codfish/codfi-sh.git codfi.sh && cd $_
  $ bundle install

  # Create db's and run migrations
  $ rake db:create:all
  $ rake db:migrate

  # run site, view at http://localhost:3000/
  $ rails s
```

## Testing

Run tests

```sh
  $ rake db:test:prepare
  $ bundle exec rspec spec
```
