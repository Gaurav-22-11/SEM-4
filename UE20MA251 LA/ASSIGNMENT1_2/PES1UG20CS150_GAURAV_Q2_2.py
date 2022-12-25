import numpy as np
import random as rd

party=["BJP","INC","AAP"]
voteshift=[["BB","BA","BI"],["AB","AA","AI"],["IB","IA","II"]]
voteshare=[[0.70,0.10,0.20],[0.10,0.60,0.30],[0.50,0.10,0.40]]

def voting_forecast(votes):

    current_party = "BJP"
    partylist = [current_party]
    i = 0
    prob = 1
    while i != votes:
        if current_party == "BJP":
            change = np.random.choice(voteshift[0],replace=True,p=voteshare[0])
            if change == "BB":
                prob = prob * 0.70
                partylist.append("BJP")
                pass
            elif change == "BA":
                prob = prob * 0.10
                current_party = "AAP"
                partylist.append("AAP")
            else:
                prob = prob * 0.20
                current_party = "INC"
                partylist.append("INC")
        elif current_party == "AAP":
            change = np.random.choice(voteshift[1],replace=True,p=voteshare[1])
            if change == "AA":
                prob = prob * 0.60
                partylist.append("AAP")
                pass
            elif change == "AB":
                prob = prob * 0.10
                current_party = "BJP"
                partylist.append("BJP")
            else:
                prob = prob * 0.30
                current_party = "INC"
                partylist.append("INC")
        elif current_party == "INC":
            change = np.random.choice(voteshift[2],replace=True,p=voteshare[2])
            if change == "II":
                prob = prob * 0.40
                partylist.append("INC")
                pass
            elif change == "IB":
                prob = prob * 0.50
                current_party = "BJP"
                partylist.append("BJP")
            else:
                prob = prob * 0.10
                current_party = "AAP"
                partylist.append("AAP")
        i += 1    
    return partylist

list_vote = []
count = 0

for iterations in range(1,10000):
        list_vote.append(voting_forecast(2))

for smaller_list in list_vote:
    if(smaller_list[2] == "AAP"):
        count += 1
percentage = (count/10000) * 100
print("The probability of votes transferring from 'BJP' to 'AAP'= " + str(percentage) + "%")