*** Settings ***
Library    String
Library    AppiumLibrary

*** Variables ***

*** Keywords ***
MultiLineTextbox specific get text
    [Arguments]    ${Selector}
    ${TextboxContent}=    AppiumLibrary.Get Text    ${Selector}
    RETURN    ${TextboxContent}

MultiLineTextbox specific set text
    [Arguments]    ${Selector}    ${Value}
    AppiumLibrary.Input Text    ${Selector}    ${Value}