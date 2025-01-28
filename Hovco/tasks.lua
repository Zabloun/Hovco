tasks = {}

task = {}
task.name = ""
task.location = ""
task.load = ""
task.distance = 0
task.difficulty = 0
task.reward = 0 -- reward = (loadnum *)
task.penalty = 0
task.time = 0
task.penaltytime = 0

--Additonal global variables
baserate = 75
tasktime = 0
taskpenaltytime = 0

function tasks.newDailyTask()
  
  --tables for different task parts to be taken from
  names = {"Jeff", "Matthew", "Jacob", "Andrea", "Slappy", "Switchy", "Tinero", "Varkie", "Tindy", "Yitexity", "Jackie", "Gl-arse", "Iplyn"} --Just flavour text
  locations = {"A", "B", "C", "D"} --Just flavour text | related to Distance
  distances = {50, 100, 150, 200} --35% | 1.0x, 1.2x, 1.4x, 1.8x (2) | related to Location
  loads = {"Wood", "Stone", "Iron", "Steel"} -- 35% | 1.0x, 1.2x, 1.4x, 1.6x (1)
  difficulty = {0, 1, 2, 3} -- 30% | 1.0x, 1.25x, 1.50x, 2x (3)
  
  --where reward modifiers
  rewardmodifierload = {1.0, 1.2, 1.4, 1.6}
  rewardmoifierdistance = {1.0, 1.2, 1.4, 1.8}
  rewardmodifierdifficulty = {1.0, 1.25, 1.50, 2}
  
  --for actual calculation
  rewardmodifiers = {rewardmodifierload, rewardmoifierdistance, rewardmoifierdistance}
  
  math.randomseed(os.time())
  
  --Name randomizer
  task.name = names[math.random(1,#names)]
  
  --Load randomizer //I know this is a shitty hack, but I can't be bothered to wrap my mind around it right now MAYBE fix later idk
  loadnum = math.random(1, #loads)
  task.load = loads[loadnum]
  
  --Distance & Location //Read above :) I swear I am mentally okay
  locationnum = math.random(1, #locations)
  task.distance = distances[locationnum]
  task.location = locations[locationnum]
  
  --Difficulty randomizer
  difficulty = math.random(1, #difficulty)
  task.diffculty = difficulty
  
  --Reward calculation
  task.reward = (0.35 * rewardmodifierload[loadnum] + 0.35 * rewardmoifierdistance[locationnum] + 0.30 * rewardmodifierdifficulty[difficulty]) *baserate
  
  --Penalty calculation
  task.penalty = task.reward * 1.2
  
  --Task Time
  task.time = task.distance / 4
  tasktime = task.time
  
  --Penalty time
  task.penaltytime = task.time * 3
  
  return task
  
end

--Function to update time
function tasks.ArrivalTimer(deltatime)
  
  while tasktime > -1 do
    tasktime = tasktime - deltatime
    return tasktime
  end
  
end

--Function to update penalty timer
function tasks.PenaltyTimer(deltatime)
  
    while taskpenaltytime > -1 do
    taskpenaltytime = taskpenaltytime - deltatime
    return task.penaltytime
    
  end
end

--Converting Times to game time
function tasks.ConvertTime(InputTime)
  
  --Local variables for game time
  GameTime = {}
  GameTime.minute = 0
  GameTime.hour = 0 
  GameTime.day = 0
  
  --Converting time
  while InputTime > 60 do
    if (tasktime % 60) ~= 0 then
      GameTime.hour = math.floor(InputTime / 60)
      InputTime = InputTime - GameTime.hour * 60
      if (GameTime.hour > 16) then
        if (GameTime.hour % 16) ~= 0 then
          Time.day = math.floor(Time.hour / 16)
          Time.hour = Time.hour - Time.day * 16
        end
      end
    end
  end
  
  if InputTime < 60 then
    GameTime.minute = InputTime
  end
 
  
  return GameTime
  
end