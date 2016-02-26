module Player (Player, update) where

type alias Player =
  { x : Int
  , y : Int
  }

                  
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

updatePlayerX : Int -> Int -> Player -> Player
updatePlayerX keyX delta player =
  let x' = updateX player.x delta keyX
  in
    { player | x = x' }

updatePlayerY : Int -> Int -> Player -> Player
updatePlayerY keyY delta player =
  let y' = updateX player.y delta keyY
  in
    { player | y = y' }

update : Player -> (Int, Int) -> (Int, Int) -> Player
update player (keyX, deltaX) (keyY, deltaY) =
  player
    |> updatePlayerX keyX deltaX
    |> updatePlayerY keyY deltaY
