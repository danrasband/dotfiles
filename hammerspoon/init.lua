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

hs.hotkey.bind({"cmd"}, "Escape", function()
  local screens = hs.screen.allScreens()
  for index,value in ipairs(screens) do
    hs.alert.show('screen ' .. tostring(index) .. ': ' .. tostring(value:id()))
    hs.alert.show('screen position: ' .. tostring(value:frame().x) .. ',' .. tostring(value:frame().y))
  end

  local win = hs.window.focusedWindow()
  local screen = win:screen()
  hs.alert.show('Current window screen ID: ' .. tostring(screen:id()))
end)

-- BIND HOTKEYS --

-- Throw
throw.hotkeys = {"cmd", "alt", "ctrl"}
-- To previous screen
hs.hotkey.bind(throw.hotkeys, "Left", function()
  local win = hs.window.focusedWindow()
  local toScreen = win:screen():previous()
  throw.throw(win, toScreen)
end)
-- To next screen
hs.hotkey.bind(throw.hotkeys, "Right", function()
  local win = hs.window.focusedWindow()
  local toScreen = win:screen():next()
  throw.throw(win, toScreen)
end)

-- Resize
resize.hotkeys = {'cmd', 'ctrl', 'shift'}
hs.hotkey.bind(resize.hotkeys, "Left", function()
  resize.resize(hs.window.focusedWindow(), 0.5, 1)
end)
hs.hotkey.bind(resize.hotkeys, "Right", function()
  resize.resize(hs.window.focusedWindow(), 2, 1)
end)
hs.hotkey.bind(resize.hotkeys, "Down", function()
  resize.resize(hs.window.focusedWindow(), 1, 2)
end)
hs.hotkey.bind(resize.hotkeys, "Up", function()
  resize.resize(hs.window.focusedWindow(), 1, 0.5)
end)
hs.hotkey.bind(resize.hotkeys, "Pad5", function()
  resize.resize(hs.window.focusedWindow(), 1, 1)
end)

-- Resize and Position
resizeAndPosition.hotkeys = {'ctrl', 'alt', 'cmd'}
hs.hotkey.bind(resizeAndPosition.hotkeys, 'H', function()
  resizeAndPosition.resizeAndPosition(0, 0, 1, 1)
end)
hs.hotkey.bind(resizeAndPosition.hotkeys, 'J', function()
  resizeAndPosition.resizeAndPosition(0, 0, 0.5, 1)
end)
hs.hotkey.bind(resizeAndPosition.hotkeys, 'K', function()
  resizeAndPosition.resizeAndPosition(0.5, 0, 0.5, 1)
end)
hs.hotkey.bind(resizeAndPosition.hotkeys, 'L', function()
  resizeAndPosition.resizeAndPosition(0, 0, 0.33, 1)
end)
hs.hotkey.bind(resizeAndPosition.hotkeys, ';', function()
  resizeAndPosition.resizeAndPosition(0.33, 0, 0.66, 1)
end)
-- Top Left
hs.hotkey.bind(resizeAndPosition.hotkeys, "U", function()
  resizeAndPosition.resizeAndPosition(0, 0, 0.5, 0.5)
end)
-- Top Right
hs.hotkey.bind(resizeAndPosition.hotkeys, "I", function()
  resizeAndPosition.resizeAndPosition(0.5, 0, 0.5, 0.5)
end)
-- Bottom Left
hs.hotkey.bind(resizeAndPosition.hotkeys, "M", function()
  resizeAndPosition.resizeAndPosition(0, 0.5, 0.5, 0.5)
end)
-- Bottom Right
hs.hotkey.bind(resizeAndPosition.hotkeys, ",", function()
  resizeAndPosition.resizeAndPosition(0.5, 0.5, 0.5, 0.5)
end)

-- Move
move.hotkeys = {'alt', 'cmd'}
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
snap.hotkeys = {'cmd', 'alt', 'ctrl', 'shift'}
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
sound.hotkeys = {'cmd', 'shift'}
hs.hotkey.bind(sound.hotkeys, "M", function()
  sound.mute()
  hs.timer.doAfter(90, sound.unmute)
end)

hs.hotkey.bind(sound.hotkeys, "U", function()
  sound.unmute()
end)
