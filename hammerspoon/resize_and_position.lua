local ResizeAndPosition = {}

ResizeAndPosition.hotkeys = {'ctrl', 'alt', 'cmd'}

-- Resize and position the current window by percentages.
ResizeAndPosition.resizeAndPosition = function(win, screenId, xPercent, yPercent, wPercent, hPercent)
  -- local fromFrame = win:frame()
  -- local currentScreenFrame = win:screen():frame()
  -- local screen = hs.screen.allScreens()[screenId]
  -- local toFrame = screen:frame()

  -- -- -- Maintain position on screen
  -- if xPercent then
  --   toFrame.x = toFrame.x * xPercent
  -- else
  --   toFrame.x = 0
  -- end
  -- if yPercent then
  --   toFrame.y = toFrame.y * yPercent
  -- else
  --   toFrame.y = 0
  -- end

  -- -- -- Set width and height
  -- if wPercent then
  --   toFrame.w = toFrame.w * wPercent
  -- end
  -- if hPercent then
  --   toFrame.h = toFrame.h * hPercent
  -- end

  -- win:setFrame(toFrame)
end

return ResizeAndPosition
