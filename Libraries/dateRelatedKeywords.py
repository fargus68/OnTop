import datetime
import Keywords
from dateutil.relativedelta import relativedelta

#ToDo: arbeitet noch nicht mit mehreren Vorkommen
def today_keywords_processing(value : str):
    original_value = value
    print("original_value = " + original_value)
    if  value.find("<TODAY>") != -1:
        keyword_resolved_value = datetime.datetime.today().strftime("%Y/%m/%d")
        return original_value.replace('<TODAY>', keyword_resolved_value)
    elif value.find("<TODAY ") != -1:
        full_keyword = Keywords.get_full_keyword_substring(value, "TODAY")
        params : list = Keywords.get_keyword_value(value, "TODAY").split(",")
        #print(params)
        #print(len(params))
        #keyword_resolved_value = str(datetime.datetime.today())
        if  len(params) == 3:
            keyword_resolved_value = get_new_date(params)
            keyword_resolved_value = str(keyword_resolved_value)
        elif len(params) >= 4:
            keyword_resolved_value = get_new_date(params)
            keyword_resolved_value = keyword_resolved_value.strftime(params[3])
        else:
            keyword_resolved_value = "ERROR!"
            print("ERROR!")
        #print(original_value.replace(original_value, keyword_resolved_value))
        keyword_resolved_original_value = original_value.replace(full_keyword, keyword_resolved_value)
        return keyword_resolved_original_value

def get_new_date(params):
    if params[0].find("+") != -1:
        daysToAdd = int(params[0].replace("+", ""))
        dateTimeAfterDayManipulation = datetime.datetime.today() + datetime.timedelta(days=daysToAdd)
    elif params[0].find("-") != -1:
        daysToSubstract = int(params[0].replace("-", "")) * -1
        dateTimeAfterDayManipulation = datetime.datetime.today() + datetime.timedelta(days=daysToSubstract)
    else:
        dateTimeAfterDayManipulation = datetime.datetime.today().replace(day=int(params[0]))

    if params[1].find("+") != -1:
        monthToAdd = int(params[1].replace("+", ""))
        dateTimeAfterMonthManipulation = dateTimeAfterDayManipulation + relativedelta (months=monthToAdd)
    elif params[1].find("-") != -1:
        monthToSubstract = int(params[1].replace("-", "")) * -1
        dateTimeAfterMonthManipulation = dateTimeAfterDayManipulation + relativedelta(months=monthToSubstract)
    else:
        dateTimeAfterMonthManipulation = dateTimeAfterDayManipulation.replace(month=int(params[1]))

    if params[2].find("+") != -1:
        yearsToAdd = int(params[2].replace("+", ""))
        keyword_resolved_value = dateTimeAfterMonthManipulation + relativedelta (years=yearsToAdd)
    elif params[2].find("-") != -1:
        yearsToSubstract = int(params[2].replace("-", "")) * -1
        keyword_resolved_value = dateTimeAfterMonthManipulation + relativedelta(years=yearsToSubstract)
    else:
        keyword_resolved_value = dateTimeAfterMonthManipulation.replace(year=int(params[2]))

    return keyword_resolved_value
