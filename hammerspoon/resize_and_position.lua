local ResizeAndPosition = {}

-- Resize and position the current window by ratios.
ResizeAndPosition.resizeAndPosition = function(xPosition, yPosition, wRatio, hRatio)
  local win = hs.window.focusedWindow()
  local toFrame = win:screen():frame()

  -- Maintain position on screen
  if xPosition then
    toFrame.x = toFrame.w * xPosition + toFrame.x
  end

  if yPosition then
    toFrame.y = toFrame.h * yPosition + toFrame.y
  end

  -- Set width and height
  if wRatio then
    toFrame.w = toFrame.w * wRatio
  end

  if hRatio then
    toFrame.h = toFrame.h * hRatio
  end

  win:setFrame(toFrame)
end

return ResizeAndPosition
