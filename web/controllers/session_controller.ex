defmodule HelloPhoenix.SessionController do
  use HelloPhoenix.Web, :controller

  def new(conn, _) do
    render conn, "new.html"
  end
end
