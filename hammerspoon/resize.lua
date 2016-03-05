local Resize = {}

Resize.hotkeys = {'cmd', 'ctrl', 'shift'}

-- Resize the current window by percentages.
Resize.resize = function(win, wPercent, hPercent)
  local frame = win:frame()

  frame.w = frame.w * wPercent
  frame.h = frame.h * hPercent

  win:setFrame(frame)
end

return Resize
