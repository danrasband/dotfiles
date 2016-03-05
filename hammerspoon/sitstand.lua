local SitStand = {}

SitStand.hotkeys = {'cmd', 'shift'}

SitStand.mute = function()
  local audiodevice = hs.audiodevice.defaultOutputDevice()
  audiodevice:setMuted(true)
end

SitStand.unmute = function()
  local audiodevice = hs.audiodevice.defaultOutputDevice()
  audiodevice:setMuted(false)
end

return SitStand
