--
-- working around broken Sierra keyboard alt / cmd switching
--
local usbWatcher = nil
local home = os.getenv("HOME")
function usbDeviceCallback(data)
  if (data["productName"] == "GCS1102 V1.2.113") then
    if (data["eventType"] == "added") then
      hs.execute(home .. '/.hammerspoon/karabiner-switcher 1')
    elseif (data["eventType"] == "removed") then
      hs.execute(home .. '/.hammerspoon/karabiner-switcher 0')
    end
  end
end
usbWatcher = hs.usb.watcher.new(usbDeviceCallback)
usbWatcher:start()

--
-- start Focus.app on wake
--
local wakeCallback = nil
function wakeCallback(event)
  if (event == hs.caffeinate.watcher.systemDidWake) then
    hs.execute('open focus://focus')
  end
end
wakeWatcher = hs.caffeinate.watcher.new(wakeCallback)
wakeWatcher:start()


