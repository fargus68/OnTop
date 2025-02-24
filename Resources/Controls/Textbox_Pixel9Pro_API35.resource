*** Settings ***
Library    String
Library    AppiumLibrary

*** Variables ***

*** Keywords ***
Textbox specific get text
    [Arguments]    ${Selector}
    ${TextboxContent}=    Get Text    ${Selector}
    RETURN    ${TextboxContent}

Textbox specific set text
    [Arguments]    ${Selector}    ${Value}
    Input Text    ${Selector}    ${Value}