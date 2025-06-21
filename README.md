# Rails ActiveRecord DuckDB Demo

This is a demonstration Rails application showcasing the use of **ActiveRecord backed by DuckDB** This demo includes standard Rails CRUD operations for Users and Posts, all powered by DuckDB instead of traditional databases like PostgreSQL or MySQL.

## About DuckDB

DuckDB is an in-memory analytical database that excels at OLAP workloads. It's particularly useful for:
- Data science applications
- Analytical queries
- Situations requiring fast analytical processing without database server overhead
- Development and testing environments

## Features

This demo application includes:
- **User management** - Create, read, update, and delete users
- **Post management** - Blog-like posts with categories
- **Standard Rails functionality** - Full ActiveRecord ORM support
- **DuckDB integration** - File-based and in-memory database options

## Installation

### Prerequisites

- Ruby 3.2.0+
- Rails 7.1+
- Bundler

### Setup

1. **Clone the repository:**
   ```bash
   git clone https://github.com/eddietejeda/rails-active-record-duckdb-demo
   cd rails-active-record-duckdb-demo
   ```

2. **Install dependencies:**
   ```bash
   bundle install
   ```

3. **Set up the database:**
   ```bash
   rails db:create
   rails db:migrate
   rails db:seed
   ```

4. **Start the server:**
   ```bash
   rails server
   ```

5. **Visit the application:**
   Open your browser and go to `http://localhost:3000`

## DuckDB Adapter Installation

This project uses the [activerecord-duckdb-adapter](https://github.com/eddietejeda/activerecord-duckdb-adapter) gem. To use this adapter in your own Rails project:

### Add to Gemfile

```ruby
# Add this line to your Gemfile
gem "activerecord-duckdb-adapter", git: "https://github.com/eddietejeda/activerecord-duckdb-adapter.git"
```

### Install the gem

```bash
bundle install
```

## Database Configuration

### Example database.yml

Configure your Rails application to use DuckDB by updating your `config/database.yml`:

```yaml
default: &default
  adapter: duckdb
  
development:
  <<: *default
  # File-based database
  database: db/development.duckdb
  
  # This does not work yet.
  # database: ":memory"

test:
  <<: *default

  database: db/test.duckdb

production:
  <<: *default
  database: db/production.duckdb
```

### Configuration Options

- **File-based database:** `database: db/development.duckdb`
  - Data persists between application restarts
  - Recommended for development and production
  
- **In-memory database:** `database: ":memory:"`
  - Faster performance
  - Data is lost when application stops

## Dependencies

This adapter requires:
- **ruby-duckdb** - Ruby bindings for DuckDB
- **ActiveRecord 7.0+**
- **DuckDB** - The database engine

## Current Features

The DuckDB adapter supports:
- ✅ Basic CRUD operations with parameter binding
- ✅ Schema management and migrations
- ✅ Standard ActiveRecord query interface
- ✅ Transactions and bulk operations
- ✅ Common SQL data types
- ✅ Model associations
- ✅ Test fixtures support

## Limitations

- 🚧 Still in development - not production ready
- 🚧 Limited advanced transaction support
- 🚧 Some migration operations may need manual handling

## ⚠️ Known Issues & Workarounds

### Rails Fixtures Compatibility

**Issue**: DuckDB uses auto-increment IDs starting from 1, which conflicts with Rails fixtures that often use large, specific ID values (e.g., `980190962`).

**Symptoms**: Test failures with messages like:
```
Expected response to be a redirect to <http://www.example.com/users/980190962> 
but was a redirect to <http://www.example.com/users/1>
```

**Workaround**: This demo project uses **manual test data creation** instead of Rails fixtures:

```ruby
# In test files (e.g., test/controllers/users_controller_test.rb)
setup do
  @user = User.create!(
    name: "John Doe",
    email: "john@example.com", 
    age: 30,
    active: true,
    bio: "A sample user for testing"
  )
end

teardown do
  # Clean up test data for isolation
  Post.destroy_all
  User.destroy_all
end
```

**Configuration**: Disable Rails fixtures in `test/test_helper.rb`:
```ruby
# fixtures :all  # <- Comment this out
```

### Database File Corruption

**Issue**: Occasionally, the DuckDB test database file may become corrupted, causing errors like:
```
DuckDB::Error: Failed to open database
```

**Solution**: Reset the test database:
```bash
rm storage/test.duckdb && rails db:test:prepare
```

## Project Structure

```
├── app/
│   ├── controllers/
│   │   ├── posts_controller.rb    # Posts CRUD operations
│   │   └── users_controller.rb    # Users CRUD operations
│   ├── models/
│   │   ├── post.rb               # Post model with associations
│   │   └── user.rb               # User model with associations
│   └── views/
│       ├── posts/                # Post views
│       └── users/                # User views
├── db/
│   ├── migrate/                  # Database migrations
│   ├── schema.rb                 # Current database schema
│   └── seeds.rb                  # Sample data
└── config/
    └── database.yml              # Database configuration
```

## Development

### Running Tests

```bash
# Run all tests
rails test

# Run specific test files
rails test test/models/user_test.rb
rails test test/controllers/posts_controller_test.rb
```

### Database Operations

```bash
# Create the database
rails db:create

# Run migrations
rails db:migrate

# Seed with sample data
rails db:seed

# Reset database
rails db:reset

# Drop database
rails db:drop
```

### Console Access

```bash
# Rails console with DuckDB
rails console

# Example usage in console:
User.create(name: "John Doe", email: "john@example.com", age: 30)
Post.create(title: "My First Post", content: "Hello DuckDB!", user: User.first)
```

## Related Resources

- **DuckDB Official Documentation:** [https://duckdb.org/docs/](https://duckdb.org/docs/)
- **ActiveRecord DuckDB Adapter (Current):** [https://github.com/eddietejeda/activerecord-duckdb-adapter](https://github.com/eddietejeda/activerecord-duckdb-adapter)
- **Ruby DuckDB Bindings:** [https://github.com/suketa/ruby-duckdb](https://github.com/suketa/ruby-duckdb)

## Attribution

This adapter builds upon the work from the red-data-tools/activerecord-duckdb-adapter project, extended with additional functionality and comprehensive testing.

## License

MIT License

## Contributing

This is a demonstration project. For contributing to the DuckDB adapter itself, please visit the [activerecord-duckdb-adapter repository](https://github.com/eddietejeda/activerecord-duckdb-adapter).
