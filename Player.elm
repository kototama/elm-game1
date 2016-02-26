module Player (Player, update) where

import Action exposing (Action(..), Direction(..))

type alias Player =
  { x : Int
  , y : Int
  }

deltaX: Int
deltaX = 6

deltaY : Int
deltaY = 6

updateX : number -> number -> number -> number
updateX x delta keyX =
  if keyX > 0 then
    x + delta
  else
    if keyX < 0 then
      x - delta
  else
    x

updateY : number -> number -> number -> number
updateY y delta keyY =
  if keyY > 0 then
    y - delta
  else
    if keyY < 0 then
      y + delta
  else
    y

updatePlayerX : Int -> Player -> Player
updatePlayerX delta player =
    { player | x = player.x + delta }

updatePlayerY : Int -> Player -> Player
updatePlayerY delta player =
    { player | y = player.y + delta }

update : Player -> Action -> Player
update player action =
  case action of
    Move North -> updatePlayerY deltaY player
    Move South -> updatePlayerY -deltaY player
    Move East -> updatePlayerX deltaX player
    Move West -> updatePlayerX -deltaX player
    Move NorthEast -> player
                      |> updatePlayerY deltaY
                      |> updatePlayerX deltaX
    Move NorthWest -> player
                      |> updatePlayerY deltaY
                      |> updatePlayerX -deltaX
    Move SouthEast -> player
                      |> updatePlayerY -deltaY
                      |> updatePlayerX deltaX
    Move SouthWest -> player
                      |> updatePlayerY -deltaY
                      |> updatePlayerX -deltaX
    NoOp -> player
