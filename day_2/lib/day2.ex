defmodule Day2 do

  alias Day2.PasswordPolicy

  def part1 do
    open_input()
    |> parse_to_list
    |> Enum.map(&parse_to_password_policy/1)
    |> Enum.count(&is_valid_password/1)
  end

  def open_input() do
    {:ok, content} = File.read("input.txt")
    content
  end

  def parse_to_list(content) do
    String.split(content, "\n")
  end

  def parse_to_password_policy(password_line) do
    [minimum, rest] = String.split(password_line, "-")
    [maximum, rest] = String.split(rest, " ", parts: 2)
    [letter, rest] = String.split(rest, ":")
    password = String.trim(rest)

    %PasswordPolicy{minimum: String.to_integer(minimum),
                    maximum: String.to_integer(maximum),
                    letter: letter,
                    password: password}
  end

  def is_valid_password(%PasswordPolicy{minimum: minimum, maximum: maximum, letter: letter, password: password}) do
    password = String.graphemes(password)
    letter_count = Enum.count(password, fn(char) -> char == letter end)

    minimum <= letter_count and maximum >= letter_count
  end
end
