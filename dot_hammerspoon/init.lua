hs.loadSpoon('SpeedMenu')

-- spoon.SpeedMenu:start()

detectLogiMouseExtraButtons = hs.eventtap.new({
  hs.eventtap.event.types.otherMouseDown,
}, function(e)
  local button = e:getProperty(
      hs.eventtap.event.properties['mouseEventButtonNumber']
  )

  -- if button == 2 then print('middle click')

  -- rear extra button
  if button == 3 then hs.application.launchOrFocus("LaunchPad.app")
  -- front extra button
  elseif button == 4 then hs.application.launchOrFocus("Mission Control.app")
  end
end)

detectLogiMouseExtraButtons:start()

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Left", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Right", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + (max.w / 2)
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Up", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w
  f.h = max.h
  win:setFrame(f)
end)

function moveWindowToDisplay(direction)
  return function()
    -- get the focused window
    local win = hs.window.focusedWindow()
    -- get the screen where the focused window is displayed, a.k.a. current screen
    local screen = win:screen()
    -- compute the unitRect of the focused window relative to the current screen
    -- and move the window to the next screen setting the same unitRect
    if direction == 'left' then
      win:move(win:frame():toUnitRect(screen:frame()), screen:previous(), true, 0)
    else
      win:move(win:frame():toUnitRect(screen:frame()), screen:next(), true, 0)
    end
  end
end

-- function moveWindowToDisplay(d)
--   return function()
--     local displays = hs.screen.allScreens()
--     local win = hs.window.focusedWindow()
--     win:moveToScreen(displays[d], false, true)
--   end
-- end

hs.hotkey.bind({"ctrl", "alt", "cmd"}, "p", moveWindowToDisplay('left'))
hs.hotkey.bind({"ctrl", "alt", "cmd"}, "o", moveWindowToDisplay('right'))
-- hs.hotkey.bind({"ctrl", "alt", "cmd"}, "3", moveWindowToDisplay(3))

-- caffeine = hs.menubar.new()
-- function setCaffeineDisplay(state)
--     if state then
--         caffeine:setTitle("AWAKE")
--     else
--         caffeine:setTitle("SLEEPY")
--     end
-- end

-- function caffeineClicked()
--     setCaffeineDisplay(hs.caffeinate.toggle("displayIdle"))
-- end

-- if caffeine then
--     caffeine:setClickCallback(caffeineClicked)
--     setCaffeineDisplay(hs.caffeinate.get("displayIdle"))
-- end

function applicationWatcher(appName, eventType, appObject)
    if (eventType == hs.application.watcher.activated) then
        if (appName == "Finder") then
            -- Bring all Finder windows forward when one gets activated
            appObject:selectMenuItem({"Window", "Bring All to Front"})
        end
    end
end
appWatcher = hs.application.watcher.new(applicationWatcher)
appWatcher:start()


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
myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show("Config loaded")
