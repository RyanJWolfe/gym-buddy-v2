# Iron Logs

Iron Logs is a Ruby on Rails application designed for intermediate to advanced lifters to track their workout progress. The app allows users to log detailed workout sessions, track exercises, and visualize their progress over time.

## Features

- **User Authentication**: Secure user registration and login system
- **Workout Logging**: Create and manage workout sessions
- **Exercise Tracking**: Log exercises with detailed information including sets, reps, and weights
- **Progress Visualization**: View progress charts and statistics
- **Mobile Responsive**: Fully responsive design that works on all devices
- **Data Export**: Export workout data in CSV or JSON formats
- **Exercise Library**: Comprehensive database of exercises with ability to add custom exercises

## Requirements

- Ruby 3.x
- Rails 8.0
- PostgreSQLq

## Setup

1. Clone the repository:
```bash
git clone <repository-url>
cd gym-tracker
```

2. Install dependencies:
```bash
bundle install
yarn install
```

3. Setup the database:
```bash
rails db:create
rails db:migrate
rails db:seed
```

4. Start the development server:
```bash
bin/dev
```

The application will be available at http://localhost:3000

## Development

The development server uses Foreman to manage multiple processes:
- Rails server
- CSS compilation (Tailwind)
- JS compilation

To start the development environment:
```bash
bin/dev
```

This script will:
- Install Foreman if not present
- Set default port to 3000 (can be overridden with PORT environment variable)
- Enable remote debugging capabilities
- Start all necessary processes using Procfile.dev

## Database Structure

- **Users**: Authentication and user information (via Devise)
- **Workouts**: Individual workout sessions
- **Exercises**: Exercise library with categories and equipment types
- **Exercise Logs**: Records of exercises performed in workouts
- **Exercise Sets**: Individual sets within exercise logs

## Key Models

### User
- Has many workouts
- Authentication via Devise
- Profile information

### Workout
- Belongs to user
- Has many exercise logs
- Tracks date, duration, and notes

### Exercise
- Has many exercise logs
- Categorized by type and equipment
- Reusable across workouts

### Exercise Log
- Belongs to workout and exercise
- Has many sets
- Tracks equipment brand and notes

### Exercise Set
- Belongs to exercise log
- Tracks reps, weight, rest time, and duration

## Testing

Run the test suite:
```bash
rails test
```

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE.md file for details

## Acknowledgments

- Ruby on Rails team
- Devise for authentication
- Tailwind CSS for styling
- Hotwire (Turbo and Stimulus) for dynamic interactions
