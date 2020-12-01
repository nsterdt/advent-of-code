defmodule ExpenseReport do

  def get_2020_two_entries do
    open_expense_report()
    |> parse_content_to_list
    |> map_strings_to_int
    |> find_2020_two_entries
    |> multiply
  end

  def get_2020_three_entries do
    open_expense_report()
    |> parse_content_to_list
    |> map_strings_to_int
    |> find_2020_three_entries
    |> multiply
  end

  def open_expense_report() do
    case File.read("input.txt") do
      {:ok, content} ->
        content
      {:error, error} ->
        IO.puts("Error reading input.txt: #{error}")
    end
  end

  def parse_content_to_list(content) do
    String.split(content, "\n")
  end

  def map_strings_to_int(string_list) do
    Enum.map(string_list, &String.to_integer/1)
  end

  def find_2020_two_entries([head | tail]) do
    result = Enum.find(tail, :not_found, fn(elem) -> elem + head == 2020 end)

    case result do
      :not_found -> find_2020_two_entries(tail)
      result -> {result, head}
    end
  end


  def multiply({first, second}) do
    first * second
  end

  def find_2020_three_entries([head | tail]) do
    find_2020_three_entries(head, tail)
  end

  def find_2020_three_entries(head, [head_from_tail | tail] = tail_list) do
    result = find_2020(head, tail_list)

    case result do
      :not_found -> find_2020_three_entries(head_from_tail, tail)
      result -> result
    end
  end

  def find_2020(head, [head_from_tail | tail]) do
    result = Enum.find(tail, :not_found, fn(elem) ->
      elem + head + head_from_tail == 2020
    end)

    case result do
      :not_found -> find_2020(head, tail)
      result -> {result, head, head_from_tail}
    end
  end

  def find_2020(_head, []) do
    :not_found
  end

  def multiply({first, second, third}) do
    first * second * third
  end
end
