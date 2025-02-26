*** Settings ***
Library    AppiumLibrary
Library    String

*** Variables ***

*** Keywords ***
Calendar specific get text
    [Arguments]    ${Selector}
    ${CalendarContent}=    AppiumLibrary.Get Text    ${Selector}
    RETURN    ${CalendarContent}

Calendar specific set text
    [Arguments]    ${Selector}    ${Value}
    Input Text    ${Selector}    ${Value}