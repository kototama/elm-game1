import Graphics.Collage exposing (..)
import Graphics.Element exposing (..)
import Time exposing (fps)
import Keyboard
import Window
import AnimationFrame

type alias ArrowsKeys =
  { x : Int
  , y : Int
  }

type alias Player =
  { x : Int
  , y : Int
  }

type alias Model =
  { player1 : Player
  , deltaX : Int
  , deltaY : Int
  }

type alias Dimensions = (Int, Int)

main : Signal Element
main =
  Signal.map2 view Window.dimensions (Signal.foldp update world input)
  

world : Model
world =
  let p1 = { x = 10
           , y = 10
           }
  in { player1 = p1
     , deltaX = 6
     , deltaY = 6
     }

updateX : number -> number -> number -> number
updateX x delta keyX =
  if keyX > 0 then
    x + delta
  else
    if keyX < 0 then
      x - delta
  else
    x

updateY : number -> number -> number -> number
updateY y delta keyY =
  if keyY > 0 then
    y - delta
  else
    if keyY < 0 then
      y + delta
  else
    y

updatePlayerX : Player -> Int -> Int -> Player
updatePlayerX player delta keyX =
  let x' = updateX player.x delta keyX
  in
    { player | x = x' }

updatePlayerY : Player -> Int -> Int -> Player
updatePlayerY player delta keyY =
  let y' = updateX player.y delta keyY
  in
    { player | y = y' }

update : (Float, ArrowsKeys) -> Model -> Model
update (d, keys) world =
  let player1' = updatePlayerX world.player1 world.deltaX keys.x
      player1'' = updatePlayerY player1' world.deltaY keys.y
  in
    { world | player1 = player1'' }

view : Dimensions -> Model -> Element
view (w, h) world =
  let player1 = world.player1
      forms = [ -- toForm (show ((toString player1.x) ++ ", " ++ (toString player1.y)))
              toForm (image 60 60 "/imgs/marx_head.jpg")
      ]
      form = group forms |> move (toFloat player1.x, toFloat player1.y)
    in
      collage w h [form]


input : Signal (Float, ArrowsKeys)
input =
  let
    t = Signal.map (\x -> x) AnimationFrame.frame
  in
    Signal.sampleOn t (Signal.map2 (,) t Keyboard.arrows)
