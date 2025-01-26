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

--Additonal global variables
baserate = 75
tasktime = 0

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
  
  return task
  
end

--Function to update time
function tasks.ArrivalTimer(deltatime)
  
  
  while tasktime > -1 do
    tasktime = tasktime - deltatime
    return tasktime
  end
  
end
  