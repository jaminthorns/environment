prompt = fn alive ->
  import IO.ANSI

  separator = light_black() <> " ╱ "

  left = black() <> "" <> bright() <> black_background() <> " "
  prefix = blue() <> "%prefix"
  node = if alive, do: cyan() <> "%node"
  counter = yellow() <> "%counter"
  right = " " <> reset() <> black() <> ""

  segments = Enum.reject([prefix, node, counter], &is_nil/1)

  left <> Enum.join(segments, separator) <> right <> reset()
end

IEx.configure(default_prompt: prompt.(false), alive_prompt: prompt.(true))
