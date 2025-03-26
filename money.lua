<<<<<<< HEAD
money = {}

--Addition
function money.AddToBalance(currentBalance, additionalFunds)
  
  local newBalance = 0
  
  newBalance = currentBalance + additionalFunds
  return newBalance
  
end

--Subtraction
function money.SubtractFromBalance(currentBalance, subtractedFunds)
  
  local newBalance = 0
  
  --Checking if the player has already lost before subtracting
  if money.BankruptLose(currentBalance) == true then
    return -1
  else
    --Subtracting from the currrent balance
    newBalance = currentBalance - subtractedFunds
  end
  
  --Checking after subtration to see if the player has lost
  if money.BankruptLose(newBalance) == true then
    return -1
  else
    return newBalance
  end
end

--Seeing if the player's balance is positive
function money.BankruptLose(currentBalance)
  if currentBalance < 0 then
    return true
  end
=======
money = {}

--Addition
function money.AddToBalance(currentBalance, additionalFunds)
  
  local newBalance = 0
  
  newBalance = currentBalance + additionalFunds
  return newBalance
  
end

--Subtraction
function money.SubtractFromBalance(currentBalance, subtractedFunds)
  
  local newBalance = 0
  
  --Checking if the player has already lost before subtracting
  if money.BankruptLose(currentBalance) == true then
    return -1
  else
    --Subtracting from the currrent balance
    newBalance = currentBalance - subtractedFunds
  end
  
  --Checking after subtration to see if the player has lost
  if money.BankruptLose(newBalance) == true then
    return -1
  else
    return newBalance
  end
end

--Seeing if the player's balance is positive
function money.BankruptLose(currentBalance)
  if currentBalance < 0 then
    return true
  end
>>>>>>> e3ee73d5038632bbdc84e4a7a3b5d2c695a9ba6b
end