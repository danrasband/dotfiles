local Throw = {}

-- Throw the current window to the specified screen.
Throw.throw = function(win, screen)
  local fromFrame = win:frame()
  local currentScreenFrame = win:screen():frame()
  local toFrame = screen:frame()

  -- Maintain height
  toFrame.w = fromFrame.w
  toFrame.h = fromFrame.h

  -- Maintain position on screen
  toFrame.x = toFrame.x + (fromFrame.x - currentScreenFrame.x)
  toFrame.y = toFrame.y + (fromFrame.y - currentScreenFrame.y)

  win:setFrame(toFrame)
end

return Throw
