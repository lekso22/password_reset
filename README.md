# Password Reset Flow

To start Phoenix app:
  * Install dependencies with `mix deps.get`
  * Configure connection to database in `/config/dev.exs`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Populate `users` table with test data:
   ```
   INSERT INTO users (username, email, "password") VALUES ('testUser', 'example@test.com', 'hashed_password')
   ```
  * In order to be able to send emails, configure your SMTP settings `/config/config.exs`
  * Specify outbox email address in `/lib/email.ex`
  * Start Phoenix endpoint with `mix phoenix.server`


Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

