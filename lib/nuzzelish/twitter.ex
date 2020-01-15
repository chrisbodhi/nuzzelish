defmodule Nuzzelish.Twitter do
  @account System.get_env("TW_ACCOUNT", "chrisbodhi")
  @list System.get_env("TW_LIST", "post-normal")

  def get_urls do
    get_tweets()
    |> IO.inspect
    |> Enum.map(fn(tw) -> %{name: tw.user.screen_name, urls: extract_urls(tw.entities)} end)
    |> remove_empty()
  end

  def list_members_ids do
    ExTwitter.list_members(@list, @account)
    |> Enum.map(&(&1.id_str))
    |> Enum.join(", ")
  end

  defp get_tweets do
    ExTwitter.list_timeline(@list, @account)
  end

  defp extract_urls(entities) do
    Enum.map(entities.urls, fn(e) -> e.expanded_url end)
    |> Enum.filter(fn(url) -> outside_url?(url) end)
  end

  defp outside_url?(url) do
    !String.starts_with?(url, "https://twitter")
  end

  defp remove_empty(maps) do
    Enum.filter(maps, fn(m) -> !Enum.empty?(m.urls) end)
  end

  def stream_from_list(ids_to_follow) do
    stream = ExTwitter.stream_filter([follow: ids_to_follow], :infinity)
      |> Stream.map(fn(tw) -> %{name: tw.user.screen_name, urls: extract_urls(tw.entities)} end)
      |> Stream.filter(fn(m) -> length(m.urls) > 0 end)
      |> Stream.map(fn(ds) -> IO.inspect(ds) end)

    Enum.to_list(stream)
  end
end

