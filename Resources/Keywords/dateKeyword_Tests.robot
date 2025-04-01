*** Settings ***
Resource    dateKeyword.resource

*** Test Cases ***
Today_englishFormatted
    todayKeywordProcessing        <TODAY>

Today_plus30days_englishFormatted
    todayKeywordProcessing        <TODAY 0,0,30>