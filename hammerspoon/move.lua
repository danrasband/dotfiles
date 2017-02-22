local Move = {}

-- Move the current window to a different position.
Move.move = function(win, x, y)
  local frame = win:frame()

  if x then frame.x = frame.x + x end
  if y then frame.y = frame.y + y end

  win:setFrame(frame)
end

Move.moveTo = function(win, x, y)
  local frame = win:frame()

  if x then frame.x = x end
  if y then frame.y = y end

  win:setFrame(frame)
end

return Move
