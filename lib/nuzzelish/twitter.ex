defmodule Nuzzelish.Twitter do
  @account System.get_env("TW_ACCOUNT", "chrisbodhi")
  @list System.get_env("TW_LIST", "post-normal")

  def get_urls do
    get_tweets()
    |> Enum.map(fn(tw) -> %{name: tw.user.screen_name, urls: sift_out_url(tw)} end)
    |> remove_empty()
  end

  def list_members_ids do
    ExTwitter.list_members(@list, @account)
    |> Enum.map(&(&1.id_str))
    |> Enum.join(", ")
  end

  def get_tweets do
    ExTwitter.list_timeline(@list, @account)
  end

  def extract_urls(entities) do
    Enum.map(entities.urls, fn(e) -> e.expanded_url end)
    |> Enum.filter(fn(url) -> outside_url?(url) end)
  end

  def sift_out_url(tw) do
    rt = Map.get(tw, "retweeted_status")
    qs = Map.get(tw, "quoted_status")
    rt_urls = if rt, do: extract_urls(rt.entities), else: []
    qs_urls = if qs, do: extract_urls(qs.entities), else: []
    urls = extract_urls(tw.entities)
    Enum.uniq(rt_urls ++ qs_urls ++ urls)
   end

  def has_entity(tw) do
    case tw do
      %{entities: entities} when is_map(entities) -> true
      %{retweeted_status: %{entities: entities}} when is_map(entities) -> true
      %{quoted_status: %{entities: entities}} when is_map(entities) -> true
      _ -> false
    end
  end

  defp outside_url?(url) do
    !String.starts_with?(url, "https://twitter")
  end

  defp remove_empty(maps) do
    Enum.filter(maps, fn(m) -> !Enum.empty?(m.urls) end)
  end

  def has_urls(mapped) do
    length(mapped.urls) > 0
  end

  def stream_from_list(ids_to_follow) do
    stream = ExTwitter.stream_filter([follow: ids_to_follow], :infinity)
      |> Stream.map(fn(tw) -> %{name: tw.user.screen_name, urls: sift_out_url(tw)} end)
      |> Stream.filter(fn(m) -> has_urls(m) end)
      |> Stream.map(fn(ds) -> IO.inspect(ds) end)

    Enum.to_list(stream)
  end
end
