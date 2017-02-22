local Sound = {}

Sound.mute = function()
  local audiodevice = hs.audiodevice.defaultOutputDevice()
  audiodevice:setMuted(true)
end

Sound.unmute = function()
  local audiodevice = hs.audiodevice.defaultOutputDevice()
  audiodevice:setMuted(false)
end

return Sound
