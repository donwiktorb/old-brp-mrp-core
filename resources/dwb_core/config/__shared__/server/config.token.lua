math.randomseed(math.random(0, 10000))
GlobalState.Token = math.random(0, 8888)
math.randomseed()
print(GlobalState.Token)
