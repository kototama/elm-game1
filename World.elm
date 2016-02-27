module World (World, world, update, view) where

import Graphics.Collage exposing (Form, toForm, group, move, collage)
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
           , width = 60
           , height = 60
           , bodyImg = "/imgs/marx_head.jpg"
           }
  in { player1 = p1
     , player2 = { p1
                   | x = 100
                   , y = 100
                   , bodyImg = "/imgs/hegel_head.jpg" }
     }

update : ManyActions -> World -> World
update actions world =
  let player1' = Player.update world.player1 actions.actionPlayer1
      player2' = Player.update world.player2 actions.actionPlayer2
      w1 = { world | player1 = player1' }
      w2 = { w1 | player2 = player2' }
   in
     w2

createForm : Player.Player -> Form
createForm player =
  let forms = [
       toForm (image player.width player.height player.bodyImg)
      ]
  in
    group forms |> move (toFloat player.x, toFloat player.y)

view : Dimensions -> World -> Element
view (w, h) world =
  let p1 = world.player1
      p2 = world.player2
      p1form = createForm world.player1
      p2form = createForm world.player2
  in
      collage w h [p1form, p2form]
