module World (World, world, update, view) where

import Graphics.Collage exposing (toForm, group, move, collage)
import Graphics.Element exposing (..)

import Player
import Input exposing (ArrowsKeys)

type alias Dimensions = (Int, Int)

type alias World =
  { player1 : Player.Player
  , deltaX : Int
  , deltaY : Int
  }
  
world : World
world =
  let p1 = { x = 10
           , y = 10
           }
  in { player1 = p1
     , deltaX = 6
     , deltaY = 6
     }


update : (Float, ArrowsKeys) -> World -> World
update (d, keys) world =
  let player1' = Player.update world.player1 (keys.x, world.deltaX) (keys.y, world.deltaY)
  in
    { world | player1 = player1' }

view : Dimensions -> World -> Element
view (w, h) world =
  let player1 = world.player1
      forms = [ -- toForm (show ((toString player1.x) ++ ", " ++ (toString player1.y)))
              toForm (image 60 60 "/imgs/marx_head.jpg")
      ]
      form = group forms |> move (toFloat player1.x, toFloat player1.y)
    in
      collage w h [form]

