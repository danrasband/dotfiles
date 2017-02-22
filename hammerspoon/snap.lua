local move = require('move')

local Snap = {}

-- Snap to grid
Snap.snap = function(win, corner)
  local frame = win:frame()
  local sFrame = win:screen():fullFrame()

  if corner == "Left" then move.moveTo(win, sFrame.x, nil) end
  if corner == "Right" then move.moveTo(win, sFrame.x + sFrame.w - frame.w, nil) end
  if corner == "Up" then move.moveTo(win, nil, sFrame.y) end
  if corner == "Down" then move.moveTo(win, nil, sFrame.h - frame.h) end
end

return Snap
