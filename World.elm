module World (World, world, update, view) where

import Graphics.Collage exposing (toForm, group, move, collage)
import Graphics.Element exposing (..)

import Player
import Action exposing (Action(..), Direction(..))

type alias Dimensions = (Int, Int)

type alias World =
  { player1 : Player.Player
  }
  
world : World
world =
  let p1 = { x = 10
           , y = 10
           }
  in { player1 = p1
     }


update : Action -> World -> World
update action world =
  case action of
    Move direction ->
      let player1' = Player.update world.player1 (Move direction)
      in
        { world | player1 = player1' }
    NoOp ->
      world

view : Dimensions -> World -> Element
view (w, h) world =
  let player1 = world.player1
      forms = [ -- toForm (show ((toString player1.x) ++ ", " ++ (toString player1.y)))
              toForm (image 60 60 "/imgs/marx_head.jpg")
      ]
      form = group forms |> move (toFloat player1.x, toFloat player1.y)
    in
      collage w h [form]

