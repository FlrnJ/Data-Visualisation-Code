#Programm which lists the amount of messages I've sent to a person on a given day
#Create list with exported chat file
from numpy import sort
import pandas

with open("_chat.txt") as f:
    lines = f.readlines()

#Take all elements written by Flurin
lines[:] = [x for x in lines if " Flurin: " in x]

#extract List of dates
list_dates = []
for i in lines:
    x = i[1:12]
    list_dates.append(x)

#Correct the voice meome error
voice_list = []
text_list = []
for i in list_dates:
    if i[0] == "[":
        voice_list.append(i)
    else:
        text_list.append(i)

new_voice_list = []
for i in voice_list:
    s = i
    x = s.translate({ord('['): None})
    new_voice_list.append(x)

new_text_list = []
for i in text_list:
    s = i
    x = s.translate({ord(' '): None})
    new_text_list.append(x)

list_dates = new_text_list+new_voice_list

#generate a list with all dates of 2019-2022 as backdrop
from datetime import date, timedelta

sdate = date(2021,8,29)   # start date
edate = date(2022,5,25)   # end date
date_modified=sdate
list=[sdate] 

while date_modified<edate:
    date_modified+=timedelta(days=1) 
    list.append(date_modified)


string_day = []
for i in list:
    year = i.strftime("%Y")
    month = i.strftime("%m")
    day = i.strftime("%d")
    date = f"{day}/{month}/{year}".format(year=year, month=month, day=day)
    string_day.append(date)


#combine all lists
list_dates = new_text_list + new_voice_list + string_day
#count messages per day by making a dictionary
my_dict = {i:list_dates.count(i) for i in list_dates}

# #correct -1 because all day will be at least once
for i in my_dict:
    my_dict[i] -= 1

#set up print command for csv font
print('Date, Messages')
for Date, Messages in my_dict.items():
     print('{}, {}'.format(Date, Messages))

open("chat2.csv", 'w')

#python3 Conlist.py > chat2.csv