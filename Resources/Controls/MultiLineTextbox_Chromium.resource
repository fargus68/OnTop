*** Settings ***
Library    Browser
Library    String

*** Variables ***

*** Keywords ***
MultiLineTextbox specific get text
    [Arguments]    ${Selector}
    ${TextboxContent}=    Browser.Get Text    ${Selector}
    RETURN    ${TextboxContent}

MultiLineTextbox specific set text
    [Arguments]    ${Selector}    ${Value}
    Type Text    ${Selector}    ${Value}    0.01    False