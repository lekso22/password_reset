defmodule PasswordReset.UserController do
    use PasswordReset.Web, :controller

    alias PasswordReset.User
    
    def index(conn, _params) do
        render conn, "index.html"
    end
    
    def forgot(conn, _params) do        
        render conn, "forgot.html"
    end

    def create(conn, %{"email" => %{"email_to" => email_to}}) do
        token = Ecto.UUID.generate
        timestamp = DateTime.utc_now
        user = Repo.get_by(User, email: email_to)
        case user do
            %User{} -> 
                #inserting token in users table
                Ecto.Changeset.change(user, %{reset_token: token, token_generated: timestamp})
                |> Repo.update
                #sending recovery email
                email_sent = PasswordReset.Email.send_email(email_to, token)
                |> PasswordReset.Mailer.deliver_now()
                conn
                |> put_flash(:info, "Email Sent")
                |> redirect(to: user_path(conn, :forgot))
            nil -> 
                conn
                |> put_flash(:error, "No user with such email")
                |> redirect(to: user_path(conn, :forgot))
        end
    end

    def update(conn, %{"token" => token}) do
        user = Repo.get_by(PasswordReset.User, reset_token: token)
        case user do
            %User{} -> 
                render conn, "update.html", users: user
            nil -> 
                conn
                |> put_flash(:error, "This URL is not valid")
                |> redirect(to: user_path(conn, :index))
        end
    end

    def recover(conn,  %{"token" => token, "password" => password, "confirm_password" => confirm_password}) do
        case confirm_password == password do   
            true ->         
                password_hash =:crypto.hash(:sha256, password)
                |> Base.encode16() 
                |> String.downcase()
                Repo.get_by(PasswordReset.User, reset_token: token)
                |> Ecto.Changeset.change(%{password:  password_hash})
                |> Repo.update
                conn
                |> put_flash(:info, "Password successfully updated")
                |> redirect(to: user_path(conn, :index))
            false ->
                conn
                |> put_flash(:error, "Passwords did not match")
                |> redirect(to: user_path(conn, :recover, token))
            end
    end
end