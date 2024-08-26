defmodule IExUtils do
  def prompt(alive) do
    import IO.ANSI

    separator = light_black() <> " ╱ "

    left = black() <> "" <> black_background() <> " "
    prefix = blue() <> "%prefix"
    node = if alive, do: cyan() <> "%node"
    counter = yellow() <> "%counter"
    right = " " <> reset() <> black() <> ""

    segments = Enum.reject([prefix, node, counter], &is_nil/1)

    left <> Enum.join(segments, separator) <> right <> reset()
  end

  def copy(text) when is_binary(text) do
    port = Port.open({:spawn, "fish -c fish_clipboard_copy"}, [:out])

    Port.command(port, text)
    Port.close(port)

    :ok
  end

  def copy(term), do: term |> inspect(pretty: true, limit: :infinity) |> copy()

  def paste, do: "fish" |> System.cmd(["-c", "fish_clipboard_paste"]) |> elem(0)

  def code(text) when is_binary(text) do
    port = Port.open({:spawn, "code -"}, [])

    Port.command(port, text)

    receive do
      {^port, {:data, _data}} ->
        Port.close(port)
        :ok
    end
  end

  def code(term), do: term |> inspect(pretty: true, limit: :infinity) |> code()

  defmacro time(code) do
    quote do: unquote(__MODULE__).do_time(fn -> unquote(code) end)
  end

  def do_time(fun), do: IO.puts("#{time_function(fun)} sec")

  defmacro time(code, runs) do
    quote do: unquote(__MODULE__).do_time(fn -> unquote(code) end, unquote(runs))
  end

  def do_time(fun, runs) do
    total =
      1..runs
      |> Stream.map(&{&1, time_function(fun)})
      |> Stream.each(fn {run, time} -> IO.puts("Run #{run}: #{time} sec") end)
      |> Stream.map(&elem(&1, 1))
      |> Enum.sum()

    IO.puts("Average: #{total / runs}")
  end

  defp time_function(fun) do
    {time, _} = :timer.tc(fun)
    time / 1_000_000
  end
end

import IExUtils, only: [copy: 1, paste: 0, code: 1, time: 1, time: 2]

IEx.configure(
  default_prompt: IExUtils.prompt(false),
  alive_prompt: IExUtils.prompt(true),
  inspect: [charlists: false]
)
