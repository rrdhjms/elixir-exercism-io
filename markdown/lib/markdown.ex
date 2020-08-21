defmodule Markdown do
  @doc """
    Parses a given string with Markdown syntax and returns the associated HTML for that string.

    ## Examples

    iex> Markdown.parse("This is a paragraph")
    "<p>This is a paragraph</p>"

    iex> Markdown.parse("#Header!\n* __Bold Item__\n* _Italic Item_")
    "<h1>Header!</h1><ul><li><em>Bold Item</em></li><li><i>Italic Item</i></li></ul>"
  """

  @spec parse(String.t()) :: String.t()
  def parse(m) do
    m
    |> String.split("\n")
    |> Enum.map(&process/1)
    |> Enum.join()
    |> enclose_list()
  end

  defp process(line) do
    line
    |> generate_tags()
    |> parse_line()
  end

  defp parse_line("#" <> _ = line), do: line |> parse_header
  defp parse_line("*" <> _ = line), do: line |> parse_list
  defp parse_line(line), do: line |> parse_paragraph

  defp generate_tags(line) do
    line
    |> String.split(" ")
    |> Enum.map(&parse_tags/1)
    |> Enum.join(" ")
  end

  defp parse_tags(word) do
    word
    |> String.replace_prefix("__", "<strong>")
    |> String.replace_suffix("__", "</strong>")
    |> String.replace_prefix("_", "<em>")
    |> String.replace_suffix("_", "</em>")
  end

  defp parse_paragraph(line) do
    "<p>#{line}</p>"
  end

  defp parse_header(line) do
    [headers | rest] = String.split(line)
    level = String.length(headers)
    text = Enum.join(rest, " ")

    "<h#{level}>#{text}</h#{level}>"
  end

  defp parse_list(line) do
    words = line |> String.trim_leading("* ")
    "<li>#{words}</li>"
  end

  defp enclose_list(list) do
    list
    |> String.replace("<li>", "<ul><li>", global: false)
    |> String.replace_suffix("</li>", "</li></ul>")
  end
