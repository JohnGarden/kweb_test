ExUnit.start

Mix.Task.run "ecto.create", ~w(-r Kyodai.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r Kyodai.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(Kyodai.Repo)

