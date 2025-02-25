*** Settings ***
Library    String
Library    AppiumLibrary

*** Variables ***

*** Keywords ***
UnorderedList specific get elements
    [Arguments]    ${Selector}
    @{Elements}=    Get Elements    ${Selector}
    RETURN    @{Elements}

UnorderedList specific get text
    [Arguments]    ${Selector}
    ${ListEntryContent}=    Get Text    ${Selector}
    RETURN    ${ListEntryContent}
