module Input (input, MoveKeys) where

import Set
import Keyboard
import Char exposing (KeyCode)

import AnimationFrame

import Action exposing (Action(..), Direction(..))

type alias MoveKeys =
  { x : Int
  , y : Int
  }

inputToAction : MoveKeys -> Action
inputToAction arrows =
  if arrows.y > 0 && arrows.x == 0 then
    Move North
  else if arrows.y < 0 && arrows.x == 0 then
    Move South
  else if arrows.x > 0 && arrows.y == 0  then
    Move East
  else if arrows.x < 0 && arrows.y == 0  then
    Move West
  else if arrows.x > 0 && arrows.y > 0  then
    Move NorthEast
  else if arrows.x < 0 && arrows.y > 0  then
    Move NorthWest
  else if arrows.x > 0 && arrows.y < 0  then
    Move SouthEast
  else if arrows.x < 0 && arrows.y < 0  then
    Move SouthWest
  else
    NoOp


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

input : Signal Action
input =
  let
    t = Signal.map (\x -> x) AnimationFrame.frame
  in
    Signal.sampleOn t (Signal.map inputToAction zqsd)
