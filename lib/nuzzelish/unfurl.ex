defmodule Nuzzelish.Unfurl do
  alias Nuzzelish.Link

  def build(url) do
    doc = get_html_head(url)

    [{_, desc, _}] = Floki.find(doc, "meta[property=\"og:description\"]")
    [{_, img, _}] = Floki.find(doc, "meta[property=\"og:image\"]")
    [{_, site_name, _}] = Floki.find(doc, "meta[property=\"og:site_name\"]")
    [{_, title, _}] = Floki.find(doc, "meta[property=\"og:title\"]")

    %Link{description: get_content(desc), image: get_content(img), site_name: get_content(site_name), title: get_content(title), url: url}
  end

  def get_html_head(url) do
    response = HTTPoison.get!(url)
    html = response.body
    {:ok, document} = Floki.parse_document(html)

    document
  end

  def get_content(tuples) do
    [{_, content}] = Enum.filter(tuples, fn
      {"content", content} -> content
      _ -> false
    end)

    content
  end
end
