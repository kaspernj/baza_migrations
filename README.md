[![Code Climate](https://codeclimate.com/github/kaspernj/baza_migrations/badges/gpa.svg)](https://codeclimate.com/github/kaspernj/baza_migrations)
[![Test Coverage](https://codeclimate.com/github/kaspernj/baza_migrations/badges/coverage.svg)](https://codeclimate.com/github/kaspernj/baza_migrations)
[![Build Status](https://img.shields.io/shippable/54f837035ab6cc135292f855.svg)](https://app.shippable.com/projects/54f837035ab6cc135292f855/builds/latest)

# baza_migrations

Migrations support for the Baza database framework in Ruby.

## Usage

```ruby
executor = BazaMigrations::MigrationsExecutor.new(db: db)
executor.add_dir("spec/dummy/db/baza_migrate")
executor.execute_migrations
```

```bash
rake baza:db:migrate
rake baza:db:rollback
```

## Contributing to baza_migrations

* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2015 kaspernj. See LICENSE.txt for
further details.
