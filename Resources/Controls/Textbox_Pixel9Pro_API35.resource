*** Settings ***
Library    String
Library    AppiumLibrary

*** Variables ***

*** Keywords ***
Textbox specific get text
    [Arguments]    ${Selector}
    ${TextboxContent}=    AppiumLibrary.Get Text    ${Selector}
    RETURN    ${TextboxContent}

Textbox specific set text
    [Arguments]    ${Selector}    ${Value}
    AppiumLibrary.Input Text    ${Selector}    ${Value}