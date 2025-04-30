*** Settings ***
Library    String
#Library    AppiumLibrary
Library    ../../Libraries/elementHelperAppium.py    WITH NAME    ElementHelper

*** Variables ***

*** Keywords ***
NumericUpDown specific get text
    [Arguments]    ${Selector}
    #${NumericUpDownContent}=    AppiumLibrary.Get Text    ${Selector}
    ${element}=    ElementHelper.Search Element    ${Selector}
    ${NumericUpDownContent}=    Set Variable    ${element.text}
    RETURN    ${NumericUpDownContent}

NumericUpDown specific set text
    [Arguments]    ${Selector}    ${Value}
    #AppiumLibrary.Input Text    ${Selector}    ${Value}
    ${element}=    ElementHelper.Search Element    ${Selector}
    Evaluate    $element.clear()
    Evaluate    $element.send_keys($Value)
