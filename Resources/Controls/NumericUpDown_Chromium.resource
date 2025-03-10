*** Settings ***
Library    Browser
Library    String

*** Variables ***

*** Keywords ***
NumericUpDown specific get text
    [Arguments]    ${Selector}
    ${NumericUpDownContent}=    Browser.Get Text    ${Selector}
    RETURN    ${NumericUpDownContent}

NumericUpDown specific set text
    [Arguments]    ${Selector}    ${Value}
    Type Text    ${Selector}    ${Value}    0.01    False