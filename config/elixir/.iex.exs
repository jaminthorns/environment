prompt = fn alive ->
  import IO.ANSI

  indicator = green() <> "•"

  left = black() <> "" <> black_background() <> indicator <> " "
  prefix = blue() <> "%prefix "
  node = if alive, do: cyan() <> "%node ", else: ""
  counter = yellow() <> "%counter"
  right = " " <> indicator <> default_background() <> black() <> ""

  bright() <> left <> prefix <> node <> counter <> right <> reset()
end

IEx.configure(default_prompt: prompt.(false), alive_prompt: prompt.(true))
