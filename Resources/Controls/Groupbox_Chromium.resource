*** Settings ***
Library    Browser
Library    String

*** Variables ***

*** Keywords ***
Group specific get text
    [Arguments]    ${Selector}
    ${GroupContent}=    Browser.Get Text    ${Selector}
    RETURN    ${GroupContent}