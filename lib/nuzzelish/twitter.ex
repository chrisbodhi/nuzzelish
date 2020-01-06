defmodule Nuzzelish.Twitter do
  @account System.get_env("TW_ACCOUNT",  "chrisbodhi")
  @list System.get_env("TW_LIST", "post-normal")

  def get_urls do
    outside_url? = fn(u) -> !String.starts_with?(u, "https://twitter") end

    ExTwitter.list_timeline(@list, @account) |>
      Enum.map(fn(tw) -> %{name: tw.user.screen_name, urls: Enum.map(tw.entities.urls, fn(ent) -> ent.expanded_url end)} end) |>
      Enum.filter(fn(ds) -> !Enum.empty?(ds.urls) end) |>
      Enum.map(fn(ds) -> Enum.filter(ds.urls, fn url -> outside_url?.(url) end) end) |>
      List.flatten
  end
end

# todo: come up with mock data and write some tests, cowboy.
