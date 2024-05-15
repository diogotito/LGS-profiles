return function(event, arg)
  if event == "MOUSE_BUTTON_PRESSED" then
    mouse.on_pressed(arg)
    mouse.trigger_bindings()
  elseif event == "MOUSE_BUTTON_RELEASED" then
    mouse.on_released(arg)
  end
end
