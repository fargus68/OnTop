*** Settings ***
Library    String
Library    AppiumLibrary

*** Variables ***

*** Keywords ***
NumericUpDown specific get text
    [Arguments]    ${Selector}
    ${NumericUpDownContent}=    AppiumLibrary.Get Text    ${Selector}
    RETURN    ${NumericUpDownContent}

NumericUpDown specific set text
    [Arguments]    ${Selector}    ${Value}
    AppiumLibrary.Input Text    ${Selector}    ${Value}