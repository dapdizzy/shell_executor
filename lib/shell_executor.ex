defmodule ShellExecutor do
  @moduledoc """
  Documentation for ShellExecutor.
  """

  @doc """
  Hello world.

  ## Examples

      iex> ShellExecutor.hello
      :world

  """
  def hello do
    :world
  end

  @doc """
  Executes a given filename with a given program, specifying the args provided.
  The options include:
  :working_directory - used to set this as a current directory (cd) prior to script execution,
  :args_separator - denotes the string separator used between the arguments (optional, space " " is used by default),
  :extract_last_line - denotes whether to extract last line from the result strign returned.
  """
  def execute(program \\ "", filename, args \\ [], options \\ []) do
    with working_directory when working_directory |> is_binary() and working_directory != "" <- options[:working_directory] do
      if working_directory |> File.exists? and working_directory |> File.dir? do
        # Introspect just a bit
        working_directory |> File.cd!
      end
      separator = options[:args_separator] || " "
      extract_last_line = (if options[:extract_last_line], do: true, else: false)
      exec_string = "#{program} #{filename} #{args_to_string(args, separator)}"
      result =
        exec_string
        |> String.to_charlist
        |> :os.cmd
        |> to_string
        |> optional_function_call(extract_last_line, &(&1 |> last_line()))
        # |> last_line
        # |> process_rn
      result
    end
  end

  defp optional_function_call(argument, condition, function) do
    if condition, do: argument |> function.(), else: argument
  end

  defp args_to_string(args, separator) do
    args
      |> Stream.map(fn arg ->
        if arg |> is_binary() and arg |> String.contains?(" ") do
          "'#{arg}'"
        else
          "#{arg}"
        end
      end)
      |> Enum.join(separator)
  end

  defp process_rn(s) do
    s |> String.replace(~r/\\\\n/, "\r\n")
  end

  defp last_line(string) do
    reducer = fn x, _ -> x end
    string |> String.splitter(["\r", "\n"], trim: true) |> Enum.reduce(nil, reducer)
  end
end
