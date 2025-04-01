from dateRelatedKeywords import *

print(today_keywords_processing("<TODAY>"))
print(today_keywords_processing("<TODAY +0,+0,+0>"))
print(today_keywords_processing("<TODAY +32,+0,+0,%m/%d/%Y>"))
print(today_keywords_processing("<TODAY -99,+0,+0,%m/%d/%Y>"))
print(today_keywords_processing("<TODAY 15,+0,+0,%m/%d/%Y>"))
print(today_keywords_processing("<TODAY +0,+11,+0>"))
print(today_keywords_processing("<TODAY +0,+20,+0>"))
print(today_keywords_processing("<TODAY +0,-3,+0>"))
print(today_keywords_processing("<TODAY +0,-1,+0>"))
print(today_keywords_processing("<TODAY +0,8,+0>"))
#print(today_keywords_processing("<TODAY +0,13,+0>"))   => ok, error
#print(today_keywords_processing("<TODAY +0,0,+0>"))    => ok, error
print(today_keywords_processing("<TODAY +0,+0,+1>"))
print(today_keywords_processing("<TODAY +0,+0,+10,%m/%d/%Y>"))
print(today_keywords_processing("<TODAY +0,+0,-1,%m/%d/%Y>"))
print(today_keywords_processing("<TODAY +0,+0,-500,%m/%d/%Y>"))
print(today_keywords_processing("<TODAY +0,+0,1999,%m/%d/%Y>"))

print(today_keywords_processing("Vorher<TODAY>Nachher"))
print(today_keywords_processing("Hallo, heute schreiben wir das Datum <TODAY +0,+0,1999,%m/%d/%Y>!!!"))
