# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Rumbl.Repo.insert!(%Rumbl.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Rumbl.Repo
alias Rumbl.Category

categories = ~w(Политика Спорт Драма Социальный Котики Наркотики Фантастика)

for category_name <- categories do
	Repo.get_by(Category, name: category_name) ||
	Repo.insert!(%Category{ name: category_name })
end
