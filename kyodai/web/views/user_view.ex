defmodule Kyodai.UserView do
	use Kyodai.Web, :view
	alias Kyodai.User

	require IEx

	def first_name(%User{name: name}) do
		name
		|> String.split(" ")
		|> Enum.at(0)
	end
end