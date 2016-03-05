local Throw = {}

Throw.hotkeys = {"cmd", "alt", "ctrl"}

-- Throw the current window to the specified screen.
Throw.throw = function(win, screenId)
  local fromFrame = win:frame()
  local currentScreenFrame = win:screen():frame()
  local screen = hs.screen.allScreens()[screenId]
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
