*** Settings ***
Library    Browser
Library    String

*** Variables ***

*** Keywords ***
Calendar specific get text
    [Arguments]    ${Selector}
    ${CalendarContent}=    Browser.Get Text    ${Selector}
    RETURN    ${CalendarContent}

Calendar specific set text
    [Arguments]    ${Selector}    ${Value}
    Browser.Clear Text    ${Selector}
    Browser.Type Text    ${Selector}    ${Value}    0.01    False