module World (World, world, update, view) where

import Graphics.Collage exposing (toForm, group, move, collage)
import Graphics.Element exposing (..)


import Player
import Action exposing (Action(..), ManyActions, Direction(..))

type alias Dimensions = (Int, Int)

type alias World =
  { player1 : Player.Player
  , player2 : Player.Player
  }

world : World
world =
  let p1 = { x = 10
           , y = 10
           }
      p2 = { x = 100
           , y = 100
           }
  in { player1 = p1
     , player2 = p2
     }

update : ManyActions -> World -> World
update actions world =
  let player1' = Player.update world.player1 actions.actionPlayer1
      player2' = Player.update world.player2 actions.actionPlayer2
      w1 = { world | player1 = player1' }
      w2 = { w1 | player2 = player2' }
   in
     w2

view : Dimensions -> World -> Element
view (w, h) world =
  let player1 = world.player1
      player2 = world.player2
      p1forms = [
       toForm (image 60 60 "/imgs/marx_head.jpg")
      ]
      p1form = group p1forms |> move (toFloat player1.x, toFloat player1.y)
      p2forms = [
       toForm (image 60 60 "/imgs/hegel_head.jpg")
       ]
      p2form = group p2forms |> move (toFloat player2.x, toFloat player2.y)
    in
      collage w h [p1form, p2form]
