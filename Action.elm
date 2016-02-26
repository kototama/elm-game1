module Action (Action(..), Direction(..)) where

type Direction = North
               | South
               | East
               | West
               | NorthEast
               | NorthWest
               | SouthEast
               | SouthWest

type Action = Move Direction
            | NoOp
