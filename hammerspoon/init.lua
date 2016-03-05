-- Load other files.
local throw = require('throw')
local resize = require('resize')
local resizeAndPosition = require('resize_and_position')
local move = require('move')
local snap = require('snap')
local sound = require('sound')

-- Watch hammerspoon config.
function reloadConfig(files)
  doReload = false
  for _,file in pairs(files) do
    if file:sub(-4) == ".lua" then
      doReload = true
    end
  end
  if doReload then
    hs.reload()
  end
end
hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.notify.new({title="Hammerspoon", informativeText="Hammerspoon config reloaded."}):send()

-- BIND HOTKEYS --

-- Throw
hs.hotkey.bind(throw.hotkeys, "Left", function()
  throw.throw(hs.window.focusedWindow(), 2)
end)
hs.hotkey.bind(throw.hotkeys, "Right", function()
  throw.throw(hs.window.focusedWindow(), 1)
end)

-- Resize
hs.hotkey.bind(resize.hotkeys, "Left", function()
  resize.resize(hs.window.focusedWindow(), 0.5, 1)
end)
hs.hotkey.bind(resize.hotkeys, "Right", function()
  resize.resize(hs.window.focusedWindow(), 2, 1)
end)
hs.hotkey.bind(resize.hotkeys, "Up", function()
  resize.resize(hs.window.focusedWindow(), 1, 2)
end)
hs.hotkey.bind(resize.hotkeys, "Down", function()
  resize.resize(hs.window.focusedWindow(), 1, 0.5)
end)
hs.hotkey.bind(resize.hotkeys, "Pad5", function()
  resize.resize(hs.window.focusedWindow(), 1, 1)
end)

-- Resize and Position
-- hs.hotkey.bind(resizeAndPosition.hotkeys, 'H', function()
--   resizeAndPosition.resizeAndPosition(hs.window.focusedWindow(), 2, 0, 0, 1, 1)
-- end)
-- hs.hotkey.bind(resizeAndPosition.hotkeys, 'J', function()
--   resizeAndPosition.resizeAndPosition(hs.window.focusedWindow(), 2, 0, 0, 0.5, 1)
-- end)
-- hs.hotkey.bind(resizeAndPosition.hotkeys, 'K', function()
--   resizeAndPosition.resizeAndPosition(hs.window.focusedWindow(), 2, 0.5, 0, 0.5, 1)
-- end)
-- hs.hotkey.bind(resizeAndPosition.hotkeys, 'L', function()
--   resizeAndPosition.resizeAndPosition(hs.window.focusedWindow(), 1, 0, 0, 0.5, 1)
-- end)
-- hs.hotkey.bind(resizeAndPosition.hotkeys, ';', function()
--   resizeAndPosition.resizeAndPosition(hs.window.focusedWindow(), 1, 0.5, 0, 0.5, 1)
-- end)
-- hs.hotkey.bind(resizeAndPosition.hotkeys, "'", function()
--   resizeAndPosition.resizeAndPosition(hs.window.focusedWindow(), 1, 0, 0, 1, 1)
-- end)

-- Move
hs.hotkey.bind(move.hotkeys, "Left", function()
  local win = hs.window.focusedWindow()
  local frame = win:frame()
  move.move(win, -frame.w, false)
end)
hs.hotkey.bind(move.hotkeys, "Right", function()
  local win = hs.window.focusedWindow()
  local frame = win:frame()
  move.move(win, frame.w, false)
end)
hs.hotkey.bind(move.hotkeys, "Up", function()
  local win = hs.window.focusedWindow()
  local frame = win:frame()
  move.move(win, false, -frame.h)
end)
hs.hotkey.bind(move.hotkeys, "Down", function()
  local win = hs.window.focusedWindow()
  local frame = win:frame()
  move.move(win, false, frame.h)
end)

-- Snap
hs.hotkey.bind(snap.hotkeys, "Left", function()
  local win = hs.window.focusedWindow()
  snap.snap(win, "Left")
end)
hs.hotkey.bind(snap.hotkeys, "Right", function()
  local win = hs.window.focusedWindow()
  snap.snap(win, "Right")
end)
hs.hotkey.bind(snap.hotkeys, "Up", function()
  local win = hs.window.focusedWindow()
  snap.snap(win, "Up")
end)
hs.hotkey.bind(snap.hotkeys, "Down", function()
  local win = hs.window.focusedWindow()
  snap.snap(win, "Down")
end)

-- Sound
hs.hotkey.bind(sound.hotkeys, "M", function()
  sound.mute()
  hs.timer.doAfter(30, sound.unmute)
end)

hs.hotkey.bind(sound.hotkeys, "U", function()
  sound.unmute()
end)
