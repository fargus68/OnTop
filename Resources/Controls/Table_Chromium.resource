*** Settings ***
Library    Browser
Library    String

*** Variables ***

*** Keywords ***
Table specific get text
    [Arguments]    ${Selector}
    ${TableContent}=    Browser.Get Text    ${Selector}
    RETURN    ${TextboxContent}

Table specific set text
    [Arguments]    ${Selector}    ${Value}
    Browser.Clear Text    ${Selector}
    Browser.Type Text    ${Selector}    ${Value}    0.01    False