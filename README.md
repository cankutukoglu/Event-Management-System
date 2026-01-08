# Event Management System

A full-featured event management web application built with Ruby on Rails 8. This application allows users to browse, create, and register for events, with support for different user roles, email notifications, and background job processing.

## Features

- **User Authentication** - Secure user registration and login with session management
- **Role-Based Access** - Regular users and admin roles with different permissions
- **Event Management** - Create, view, edit, and delete events with categories
- **Event Categories** - Entertainment, Dining, Business, Sports, and Education
- **Event Registration** - Users can register/unregister for events
- **Photo Attachments** - Upload photos for events using Active Storage
- **CSV Export** - Export event data to CSV format
- **Email Notifications** - Event reminders via Action Mailer
- **Background Jobs** - Automated tasks using Sidekiq (event reminders, cleanup of past events)
- **Modern UI** - Responsive design with Tailwind CSS
- **Hotwire Integration** - SPA-like experience with Turbo and Stimulus

## Tech Stack

- **Framework:** Ruby on Rails 8.0
- **Database:** SQLite3
- **Background Jobs:** Sidekiq with Sidekiq Scheduler & Sidekiq Cron
- **CSS Framework:** Tailwind CSS
- **JavaScript:** Hotwire (Turbo + Stimulus), Import Maps
- **Asset Pipeline:** Propshaft
- **Authentication:** bcrypt (has_secure_password)
- **Caching:** Solid Cache
- **Queue Backend:** Solid Queue
- **Testing:** RSpec, Factory Bot

## Prerequisites

- Ruby 3.2+
- Rails 8.0+
- Redis (for Sidekiq)
- SQLite3

## Quick Start

```bash
# Clone and enter the project
git clone https://github.com/cankutukoglu/Event-Management-System.git
cd Event-Management-System

# Install dependencies
bundle install

# Setup database
bin/rails db:setup

# Start the application
bin/dev
```

Then visit `http://localhost:3000` in your browser.

## Detailed Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/cankutukoglu/Event-Management-System.git
   cd Event-Management-System
   ```

2. **Install system dependencies**

   **Redis** (required for Sidekiq background jobs):
   ```bash
   # Ubuntu/Debian
   sudo apt-get install redis-server
   
   # macOS (with Homebrew)
   brew install redis
   
   # Start Redis
   sudo systemctl start redis  # Linux
   brew services start redis   # macOS
   ```

   **SQLite3** (if not already installed):
   ```bash
   # Ubuntu/Debian
   sudo apt-get install sqlite3 libsqlite3-dev
   
   # macOS (usually pre-installed, or with Homebrew)
   brew install sqlite3
   ```

3. **Install Ruby dependencies**
   ```bash
   bundle install
   ```

4. **Setup the database**
   ```bash
   bin/rails db:create
   bin/rails db:migrate
   bin/rails db:seed  # Optional: loads sample data
   ```

5. **Setup credentials** (if needed)
   
   Rails uses encrypted credentials. If you need to edit them:
   ```bash
   # This will create config/master.key and config/credentials.yml.enc if they don't exist
   EDITOR="code --wait" bin/rails credentials:edit
   ```
   
   > **Note:** The `config/master.key` file is gitignored for security. If you're deploying or sharing the project, you'll need to share this key securely or set the `RAILS_MASTER_KEY` environment variable.

6. **Build CSS assets**
   ```bash
   bin/rails tailwindcss:build
   ```

7. **Create environment file** (optional, for local configuration)
   ```bash
   touch .env
   ```
   
   Add any local environment variables:
   ```env
   REDIS_URL=redis://localhost:6379/0
   RAILS_ENV=development
   ```

## Running the Application

### Development Mode

Start all services (Rails server and Sidekiq) with a single command:
```bash
bin/dev
```

This uses [Foreman](https://github.com/ddollar/foreman) to run the processes defined in `Procfile.dev`.

> **First time running?** Make sure Redis is running before starting the application:
> ```bash
> # Check if Redis is running
> redis-cli ping  # Should return "PONG"
> ```

Or start services individually:
```bash
# Terminal 1: Rails server
bin/rails server

# Terminal 2: Tailwind CSS watcher (for CSS hot-reload)
bin/rails tailwindcss:watch

# Terminal 3: Sidekiq (for background jobs)
bundle exec sidekiq
```

The application will be available at `http://localhost:3000`

### Using Docker

```bash
docker build -t event_management_system .
docker run -p 3000:3000 event_management_system
```

## Running Tests

```bash
# Run all RSpec tests
bundle exec rspec

# Run specific test files
bundle exec rspec spec/models/
bundle exec rspec spec/requests/
```

## Background Jobs

This application uses Sidekiq for background job processing:

- **EventReminderJob** - Sends email reminders for upcoming events
- **DestroyPastEventsJob** - Cleans up past events automatically

Make sure Redis is running and start Sidekiq:
```bash
bundle exec sidekiq
```

## API Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/events` | List all events |
| GET | `/events/:id` | Show event details |
| POST | `/events` | Create a new event |
| PATCH | `/events/:id` | Update an event |
| DELETE | `/events/:id` | Delete an event |
| GET | `/events/export_csv` | Export events to CSV |
| POST | `/events/:event_id/registrations` | Register for an event |
| DELETE | `/registrations/:id` | Cancel registration |
| GET | `/registrations` | List user's registrations |
| POST | `/users` | Create a new user |
| POST | `/session` | Login |
| DELETE | `/session` | Logout |

## Project Structure

```
app/
├── controllers/     # Request handlers
├── models/          # Database models (User, Event, Registration, Session)
├── views/           # ERB templates
├── jobs/            # Background jobs (Sidekiq)
├── mailers/         # Email templates and logic
├── helpers/         # View helpers
└── assets/          # Stylesheets, JavaScript, images

config/
├── routes.rb        # URL routing
├── database.yml     # Database configuration
├── sidekiq.yml      # Sidekiq configuration
└── recurring.yml    # Scheduled jobs configuration

spec/                # RSpec tests
├── factories/       # Factory Bot factories
├── models/          # Model specs
├── requests/        # Request specs
└── mailers/         # Mailer specs
```

## Environment Variables

Create a `.env` file in the root directory for local development:

```env
REDIS_URL=redis://localhost:6379/0
RAILS_ENV=development
```

## Security

- Passwords are hashed using bcrypt
- CSRF protection enabled
- Credentials stored securely using Rails encrypted credentials
- Security scanning with Brakeman

Run security scan:
```bash
bin/brakeman
```

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## Troubleshooting

### Redis connection error
If you see `Error connecting to Redis`, make sure Redis is installed and running:
```bash
# Start Redis
sudo systemctl start redis  # Linux
brew services start redis   # macOS

# Verify it's running
redis-cli ping  # Should return "PONG"
```

### Database errors
If you encounter database issues, try resetting:
```bash
bin/rails db:drop db:create db:migrate db:seed
```

### Assets not loading / CSS not working
Rebuild the Tailwind CSS assets:
```bash
bin/rails tailwindcss:build
```

### Missing credentials / master key error
If you see errors about missing credentials:
```bash
# Create new credentials (this will generate a new master.key)
rm config/credentials.yml.enc  # Remove old encrypted file if exists
EDITOR="code --wait" bin/rails credentials:edit
```

### Bundle install fails
Make sure you have the required system dependencies:
```bash
# Ubuntu/Debian
sudo apt-get install build-essential libsqlite3-dev

# macOS
xcode-select --install
```

## License

This project is open source and available under the [MIT License](LICENSE).

## Acknowledgments

- [Ruby on Rails](https://rubyonrails.org/)
- [Tailwind CSS](https://tailwindcss.com/)
- [Hotwire](https://hotwired.dev/)
- [Sidekiq](https://sidekiq.org/)
