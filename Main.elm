import Graphics.Element exposing (Element)
import Window


import World exposing (world, update, view)
import Input exposing (input)


main : Signal Element
main =
  Signal.map2 view Window.dimensions (Signal.foldp update world input)
