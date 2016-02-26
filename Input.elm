module Input (input, ArrowsKeys) where

import AnimationFrame
import Keyboard

type alias ArrowsKeys =
  { x : Int
  , y : Int
  }

input : Signal (Float, ArrowsKeys)
input =
  let
    t = Signal.map (\x -> x) AnimationFrame.frame
  in
    Signal.sampleOn t (Signal.map2 (,) t Keyboard.arrows)
