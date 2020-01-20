defmodule Nuzzelish.Unfurl do
  alias Nuzzelish.Link

  def build(url) do
    doc = get_html_head(url)

    desc = case Floki.find(doc, "meta[property=\"og:description\"]") do
      [{_, desc, _}] -> desc
      _ -> ""
    end
    img = case Floki.find(doc, "meta[property=\"og:image\"]") do
      [{_, img, _}] -> img
      _ -> ""
    end
    site_name = case Floki.find(doc, "meta[property=\"og:site_name\"]") do
      [{_, site_name, _}] -> site_name
      _ -> ""
    end
    title = case Floki.find(doc, "meta[property=\"og:title\"]") do
      [{_, title, _}] -> title
      _ -> ""
    end

    %Link{description: get_content(desc) |> String.slice(0, 255), image: get_content(img), site_name: get_content(site_name), title: get_content(title), url: url}
  end

  def get_html_head(url) do
    response = HTTPoison.get!(url)
    html = response.body
    {:ok, document} = Floki.parse_document(html)

    document
  end

  def get_content(""), do: ""
  def get_content(tuples) do
    [{_, content}] = Enum.filter(tuples, fn
      {"content", content} -> content
      _ -> false
    end)

    content
  end
end
