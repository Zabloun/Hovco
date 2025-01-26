--Working on Task Accepted And Declined Logic
function love.load()
  
  --Currency
  coins = 1
  
  --Tasks
  Task = {}
  Task.name = ""
  Task.location = ""
  Task.load = ""
  Task.distance = 0
  Task.difficulty = 0
  Task.reward = 0 -- reward = (loadnum *)
  Task.penalty = 0
  Task.time = 0

  --Base Timer
  TimeDay = {}
  TimeDay.minutes = 0
  TimeDay.hour = 0
  TimeDay.day = 0
  DeltaTime = 0
  
  --Game State
  Lost = false
  TaskAcc = false
  TaskDec = false
  TaskCom = false
  
  --Additional Required Files
  require ("money")
  require ("ui")
  require("tasks")
  require("tasks")
  
  --Using other Lua files resources
  
  AddButton = {}
    AddButton.mode = "fill"
    AddButton.x = 200
    AddButton.y = 200
    AddButton.w = 50
    AddButton.h = 50
    AddButton.rx = 10
    AddButton.ry = 10
    AddButton.segments = 10
  
  SubButton = {}
    SubButton.mode = "fill"
    SubButton.x = 400
    SubButton.y = 200
    SubButton.w = 50
    SubButton.h = 50
    SubButton.rx = 10
    SubButton.ry = 10
    SubButton.segments = 10
  
  NewTaskButton = {}
    NewTaskButton.mode = "fill"
    NewTaskButton.x = 600
    NewTaskButton.y = 200
    NewTaskButton.w = 50
    NewTaskButton.h = 50
    NewTaskButton.rx = 10
    NewTaskButton.ry = 10
    NewTaskButton.segments = 10
  
  TaskAccepted = {}
    TaskAccepted.mode = "fill"
    TaskAccepted.x = 200
    TaskAccepted.y = 300
    TaskAccepted.w = 50
    TaskAccepted.h = 50
    TaskAccepted.rx = 10
    TaskAccepted.ry = 10
    TaskAccepted.segments = 10
  
  TaskDeclined = {}
    TaskDeclined.mode = "fill"
    TaskDeclined.x = 400
    TaskDeclined.y = 300
    TaskDeclined.w = 50
    TaskDeclined.h = 50
    TaskDeclined.rx = 10
    TaskDeclined.ry = 10
    TaskDeclined.segments = 10
  
  buttons = {AddButton, SubButton, NewTaskButton, TaskAccepted, TaskDeclined}
  
  --Testing
  buttonpressed = ""
  newtask = 0
  
end

function love.update(dt)
  
  --Setting up timer
  
  if Lost == false then
    TimeDay.minutes = TimeDay.minutes + dt
  
    if TimeDay.minutes >= 16 then
      TimeDay.hour = TimeDay.hour + 1
      TimeDay.minutes = 0
    end
  
    if TimeDay.hour >= 16 then
      TimeDay.day = TimeDay.day + 1
      TimeDay.hour = 0
    end
  end
  --
  
  --Making Delta Time Global--
  DeltaTime = dt
  
  --Click Detection
  
  function love.mousepressed(x, y, click)
    
    --Testing Code
    if click == 1 then
      --Looping through all buttons
      for i = 1 , #buttons do
        
        if ui.clickDetection(x, y, buttons[i]) == true then
          --Testing Buttons + currency
          if i == 1 then
            coins = money.AddToBalance(coins, 200)
            buttonpressed = "Add"
          elseif i == 2 then
            coins = money.SubtractFromBalance(coins, 200)
            buttonpressed = "Delete"
          --testing task system
          elseif i == 3 then
            Task = tasks.newDailyTask()
            buttonpressed = "New Task"
          elseif i == 4 then
            TaskAcc = true
            buttonpressed = "Accepted"
          elseif i == 5 then
              Task = {}
              Task.name = ""
              Task.location = ""
              Task.load = ""
              Task.distance = 0
              Task.difficulty = 0
              Task.reward = 0 -- reward = (loadnum *)
              Task.penalty = 0
              Task.time = 0
            buttonpressed = "Declined"
          end
        end
      end
    end
  end
  --
  
  --Rewarding player after completion of task
  if TaskCom == true then
    coins = coins + Task.reward
    TaskCom = false
    TaskAcc = false
  end
  --Win/Loss States
  
  if coins == -1 then
    Lost = true
  end
  
end

function love.draw()
  
  --Drawing UI components
  love.graphics.setColor(0, 1, 0)
  ui.renderButtons(AddButton)
  love.graphics.setColor(1, 0, 0)
  ui.renderButtons(SubButton)
  love.graphics.setColor(0, 0, 1)
  ui.renderButtons(NewTaskButton)
  love.graphics.setColor(1, 1, 0)
  ui.renderButtons(TaskAccepted)
  love.graphics.setColor(0, 1, 1)
  ui.renderButtons(TaskDeclined)
  
  --Showing the Time
  love.graphics.setColor(1, 1, 1)
  love.graphics.print("Minute: " .. tostring(TimeDay.minutes) .. " Hours: " .. tostring(TimeDay.hour) .. " Days: " .. tostring(TimeDay.day))
  
  --Showing the Currency
  love.graphics.print("Coins: " .. tostring(coins), 0, 20)
  
  --Testing
  
  --Click Testing
  love.graphics.print("Button: " .. buttonpressed, 0, 40)
  --Win state conditions
  love.graphics.print("Game Lost: " .. tostring(Lost), 0, 60)
  --New Task Button
  love.graphics.print("New Task: " .. tostring(newtask), 0, 80)
  --Testing Task System
  love.graphics.print("Current Task:", 0, 100)
  love.graphics.print("Name: " .. Task.name .. " Location: " .. Task.location .. " Load: " .. Task.load .. " Distance: " .. Task.distance .. " Difficulty: " .. Task.difficulty .. " Reward: " .. Task.reward .. " Penalty: " .. Task.penalty .. " Time: " .. Task.time, 0, 120)
  --Task Timer
  love.graphics.print("Task Accept: " .. tostring(TaskAcc), 0, 140)
  
  --Displaying tasks and completed
  if TaskAcc == true and tasks.ArrivalTimer(DeltaTime) > 0 then
    love.graphics.print("Time till completion: " .. tostring(tasks.ArrivalTimer(DeltaTime)), 0, 160)
  elseif TaskAcc == true and tasks.ArrivalTimer(DeltaTime) <= 0 then
    TaskAcc = false
    TaskCom = true
  else
    TaskAcc = false
  end
end