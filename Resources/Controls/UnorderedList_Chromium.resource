*** Settings ***
Library    String
Library    Browser

*** Variables ***

*** Keywords ***
UnorderedList specific get elements
    [Arguments]    ${Selector}
    @{Elements}=    Get Elements    ${Selector}
    RETURN    @{Elements}

UnorderedList specific get text
    [Arguments]    ${Selector}
    ${ListEntryContent}=    Browser.Get Text    ${Selector}
    RETURN    ${ListEntryContent}
    