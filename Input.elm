module Input (input, MoveKeys) where

import Set
import Keyboard
import Char exposing (KeyCode)
import Debug exposing (log)

import AnimationFrame

import Action exposing (Action(..), ManyActions, Direction(..))

type alias MoveKeys =
  { x : Int
  , y : Int
  }

inputToAction : MoveKeys -> Action
inputToAction keys =
  if keys.y > 0 && keys.x == 0 then
    Move North
  else if keys.y < 0 && keys.x == 0 then
    Move South
  else if keys.x > 0 && keys.y == 0  then
    Move East
  else if keys.x < 0 && keys.y == 0  then
    Move West
  else if keys.x > 0 && keys.y > 0  then
    Move NorthEast
  else if keys.x < 0 && keys.y > 0  then
    Move NorthWest
  else if keys.x > 0 && keys.y < 0  then
    Move SouthEast
  else if keys.x < 0 && keys.y < 0  then
    Move SouthWest
  else
    NoOp

inputsToManyActions : MoveKeys -> MoveKeys -> ManyActions
inputsToManyActions letters arrows =
  let actionP1 = inputToAction letters
      actionP2 = inputToAction arrows
  in
    { actionPlayer1 = actionP1
    , actionPlayer2 = actionP2 }

-- This is copied from core.Keyboard.Directions which is not exposed
type alias Directions =
    { up : KeyCode
    , down : KeyCode
    , left : KeyCode
    , right : KeyCode
    }

-- This is copied from core.Keyboard.toXY which is not exposed
toXY : Directions -> Set.Set KeyCode -> { x : Int, y : Int }
toXY {up,down,left,right} keyCodes =
  let is keyCode =
        if Set.member keyCode keyCodes
          then 1
          else 0
  in
      { x = is right - is left
      , y = is up - is down
      }

-- This is copied from core.Keyboard.toXY which is not exposed
dropMap : (a -> b) -> Signal a -> Signal b
dropMap f signal =
  Signal.dropRepeats (Signal.map f signal)

{-| Just like the arrows signal, but this uses keys z, q, s, and d,
which are common controls for many computer games on a french layout
keyboard.
-}
zqsd : Signal MoveKeys
zqsd =
  dropMap (toXY { up = 90
                , down = 83
                , left = 81
                , right = 68 }) Keyboard.keysDown

input : Signal ManyActions
input =
  let
    t = Signal.map (\x -> x) AnimationFrame.frame
  in
    Signal.sampleOn t (Signal.map2 inputsToManyActions zqsd Keyboard.arrows)
