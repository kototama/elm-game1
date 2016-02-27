module Action (Action(..), ManyActions, Direction(..)) where

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

type alias ManyActions =
  { actionPlayer1 : Action
  , actionPlayer2 : Action
  }
