ui = {}
require("tasks")

--rendering buttons
function ui.renderButtons(button)
  
  local buttonui = {}
  buttonui = love.graphics.rectangle(button.mode, button.x, button.y, button.w, button.h, button.roundx, button.roundy, button.seg)
end

--button click detection
function ui.clickDetection(x, y, button)
  
  if (x <= button.x + button.w) and (x >= button.x) then
    if (y <= button.y + button.h) and (y >= button.y) then
      return true
    end
  end
end