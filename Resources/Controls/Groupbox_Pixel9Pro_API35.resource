*** Settings ***
Library    String
Library    AppiumLibrary

*** Variables ***

*** Keywords ***
Group specific get text
    [Arguments]    ${Selector}
    ${GroupContent}=    AppiumLibrary.Get Text    ${Selector}
    RETURN    ${GroupContent}