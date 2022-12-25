from sre_parse import State
import numpy as np
import random as rd

State=["MH","BR","KA"]
migshift=[["MM","MK","MB"],["KM","KK","KB"],["BM","BK","BB"]]
rate=[[0.85,0.10,0.05],[0.20,0.60,0.20],[0.50,0.40,0.10]]

def migration_forecast(votes):
    current_State = "BR"
    Statelist = [current_State]
    i = 0
    prob = 1
    while i != votes:
        if current_State == "MH":
            change = np.random.choice(migshift[0],replace=True,p=rate[0])
            if change == "MM":
                prob = prob * 0.85
                Statelist.append("MH")
                pass
            elif change == "MK":
                prob = prob * 0.10
                current_State = "KA"
                Statelist.append("KA")
            else:
                prob = prob * 0.05
                current_State = "BR"
                Statelist.append("BR")
        elif current_State == "KA":
            change = np.random.choice(migshift[1],replace=True,p=rate[1])
            if change == "KK":
                prob = prob * 0.60
                Statelist.append("KA")
                pass
            elif change == "KM":
                prob = prob * 0.20
                current_State = "MH"
                Statelist.append("MH")
            else:
                prob = prob * 0.20
                current_State = "BR"
                Statelist.append("BR")
        elif current_State == "BR":
            change = np.random.choice(migshift[2],replace=True,p=rate[2])
            if change == "BB":
                prob = prob * 0.10
                Statelist.append("BB")
                pass
            elif change == "BM":
                prob = prob * 0.50
                current_State = "MH"
                Statelist.append("MH")
            else:
                prob = prob * 0.40
                current_State = "KA"
                Statelist.append("KA")
        i += 1    
    return Statelist

list_state = []
count = 0

for iterations in range(1,10000):
        list_state.append(migration_forecast(2))

for smaller_list in list_state:
    if(smaller_list[2] == "MH"):
        count += 1

percentage = (count/10000) * 100
print("The probability of people migrating from 'Bihar' to 'Maharashtra'= " + str(percentage) + "%")