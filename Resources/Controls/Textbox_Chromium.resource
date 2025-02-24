*** Settings ***
Library    Browser
Library    String

*** Variables ***

*** Keywords ***
Textbox specific get text
    [Arguments]    ${Selector}
    ${TextboxContent}=    Get Text    ${Selector}    
    RETURN    ${TextboxContent}

Textbox specific set text
    [Arguments]    ${Selector}    ${Value}
    Type Text    ${Selector}    ${Value}    0.01    False