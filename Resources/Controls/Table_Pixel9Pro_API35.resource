*** Settings ***
Library    String
Library    AppiumLibrary
Library    ../../Libraries/Keywords.py
Library    ../../Libraries/appiumTableHelper.py

*** Variables ***

*** Keywords ***
Table specific get text
    [Arguments]    ${Selector}
    ${TableContent}=    AppiumLibrary.Get Text    ${Selector}
    RETURN    ${TableContent}

Table specific set text
    [Arguments]    ${Selector}    ${Value}
    AppiumLibrary.Input Text    ${Selector}    ${Value}

Table specific delete keyword processing
    [Arguments]    ${Selector}    ${Value}    ${AllData}
    #Log Many    ${AllData}
    Delete Row    ${Selector}    ${AllData}
    RETURN