defmodule Day2 do
  alias Day2.PasswordPolicyOld
  alias Day2.PasswordPolicyNew

  def part1 do
    open_input()
    |> parse_to_list
    |> Enum.map(&parse_to_password_policy_old/1)
    |> Enum.count(&is_valid_password_old/1)
  end

  def part2 do
    open_input()
    |> parse_to_list
    |> Enum.map(&parse_to_password_policy_new/1)
    |> Enum.count(&is_valid_password_new/1)
  end

  def open_input() do
    {:ok, content} = File.read("input.txt")
    content
  end

  def parse_to_list(content) do
    String.split(content, "\n")
  end

  def parse_to_password_policy_old(password_line) do
    [minimum, rest] = String.split(password_line, "-")
    [maximum, rest] = String.split(rest, " ", parts: 2)
    [letter, rest] = String.split(rest, ":")
    password = String.trim(rest)

    %PasswordPolicyOld{
      minimum: String.to_integer(minimum),
      maximum: String.to_integer(maximum),
      letter: letter,
      password: password
    }
  end

  def parse_to_password_policy_new(password_line) do
    [first_position, rest] = String.split(password_line, "-")
    [second_position, rest] = String.split(rest, " ", parts: 2)
    [letter, rest] = String.split(rest, ":")
    password = String.trim(rest)

    %PasswordPolicyNew{
      first_position: String.to_integer(first_position),
      second_position: String.to_integer(second_position),
      letter: letter,
      password: password
    }
  end

  def is_valid_password_old(%PasswordPolicyOld{
        minimum: minimum,
        maximum: maximum,
        letter: letter,
        password: password
      }) do
    password = String.graphemes(password)
    letter_count = Enum.count(password, fn char -> char == letter end)

    minimum <= letter_count and maximum >= letter_count
  end

  def is_valid_password_new(%PasswordPolicyNew{
        first_position: first_position,
        second_position: second_position,
        letter: letter,
        password: password
      }) do
    password = String.graphemes(password)

    count =
      Enum.with_index(password, 1)
      |> Enum.filter(fn {_searched_letter, position} ->
        position == first_position or position == second_position end)
      |> Enum.count(fn {searched_letter, _position} -> searched_letter == letter end)

    count == 1
  end
end
