prompt = fn alive ->
  import IO.ANSI

  left = black() <> "" <> bright() <> black_background() <> " "
  prefix = blue() <> "%prefix "
  node = if alive, do: cyan() <> "%node ", else: ""
  counter = yellow() <> "%counter"
  right = " " <> reset() <> black() <> ""

  left <> prefix <> node <> counter <> right <> reset()
end

IEx.configure(default_prompt: prompt.(false), alive_prompt: prompt.(true))
