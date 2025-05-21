*** Settings ***
#Library    AppiumLibrary
Library    String
Library    ../Utils/DriverSingletonAdapter.py    WITH NAME    SessionHelper
Library    ../../Libraries/elementHelperAppium.py    WITH NAME    ElementHelper

*** Variables ***

*** Keywords ***
Password specific get text
    [Arguments]    ${Selector}
    #${driver}=    SessionHelper.Get Current Session
    ${element}=    ElementHelper.Search Element    ${Selector}
    ${PasswordContent}=    Set Variable    ${element.text}
    RETURN    ${PasswordContent}

Password specific set text
    [Arguments]    ${Selector}    ${Value}
    #${driver}=    SessionHelper.Get Current Session
    ${element}=    ElementHelper.Search Element    ${Selector}
    Evaluate    $element.clear()
    Evaluate    $element.send_keys($Value)
