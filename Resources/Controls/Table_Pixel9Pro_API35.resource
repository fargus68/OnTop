*** Settings ***
Library    String
#Library    AppiumLibrary
Library    ../../Libraries/elementHelperAppium.py    WITH NAME    ElementHelper
Library    ../../Libraries/Keywords.py
Library    ../../Libraries/appiumTableHelper.py

*** Variables ***

*** Keywords ***
Table specific get text
    [Arguments]    ${Selector}
    #${TableContent}=    AppiumLibrary.Get Text    ${Selector}
    ${element}=    ElementHelper.Search Element    ${Selector}
    ${TableContent}=    Set Variable    ${element.text}
    RETURN    ${TableContent}

Table specific set text
    [Arguments]    ${Selector}    ${Value}
    #AppiumLibrary.Input Text    ${Selector}    ${Value}
    ${element}=    ElementHelper.Search Element    ${Selector}
    Evaluate    $element.clear()
    Evaluate    $element.send_keys($Value)

Table specific delete keyword processing
    [Arguments]    ${Selector}    ${Value}    ${AllData}
    #Log Many    ${AllData}
    Delete Row    ${Selector}    ${AllData}
    RETURN