*** Settings ***
Library    String
Library    Browser

*** Variables ***

*** Keywords ***
Page specific get text
    [Arguments]    ${Selector}
    ${PageContent}=    Browser.Get Text    ${Selector}
    RETURN    ${PageContent}

Page specific get classes
    [Arguments]    ${Selector}
    ${PageClasses}=    Browser.Get Classes    ${Selector}
    RETURN    ${PageClasses}

Page specific click
    [Arguments]    ${Selector}
    Browser.Click    ${Selector}