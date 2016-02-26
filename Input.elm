module Input (input, ArrowsKeys) where

import AnimationFrame
import Keyboard

import Action exposing (Action(..), Direction(..))

type alias ArrowsKeys =
  { x : Int
  , y : Int
  }

inputToAction : Float -> ArrowsKeys -> Action
inputToAction _ arrows =
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

input : Signal Action
input =
  let
    t = Signal.map (\x -> x) AnimationFrame.frame
  in
    Signal.sampleOn t (Signal.map2 inputToAction t Keyboard.arrows)
