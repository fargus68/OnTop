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

UnorderedList specific get element texts
    [Arguments]    ${Selector}

    @{ActualErrorElements}=    Get Elements    ${Selector}

    Create List    @{ActualErrorElementTexts}
    #@{ActualErrorElementTexts}=
    FOR    ${ListEntry}    IN    @{ActualErrorElements}
        ${ListEntryContent}=     Browser.Get Text    ${ListEntry}
        Append To List    @{ActualErrorElementTexts}    ${ListEntryContent}
    END
    ${CopyActualErrorElementTexts}=    Create List    @{ActualErrorElementTexts}

    RETURN    ${CopyActualErrorElementTexts}
    