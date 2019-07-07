defmodule PasswordReset.User do
    use PasswordReset.Web, :model

    schema "users" do
      field :username, :string
      field :email, :string
      field :password, :string
      field :reset_token, :string
      field :token_generated, :naive_datetime
    end

end