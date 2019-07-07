defmodule PasswordReset.Email do
    use Bamboo.Phoenix, view: PasswordReset.EmailView
  
    def send_email(to_email_address, token) do
      new_email()
      |> to(to_email_address)
      |> from("example@email.com") # valid email
      |> subject("Reset Password")
      |> text_body("You can reset your password by clikcing the link below
                    http://localhost:4000/forgot/reset/#{token}")
    end
  end