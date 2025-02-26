*** Settings ***
Library    String
Library    AppiumLibrary

*** Variables ***

*** Keywords ***
UnorderedList specific get elements
    [Arguments]    ${Selector}
    Wait Until Element Is Visible    ${Selector}

    @{ActualErrorElements}=    AppiumLibrary.Get WebElements    xpath=//android.widget.ListView//android.view.View//android.widget.TextView
    ${CopyActualErrorElements}=    Create List    @{ActualErrorElements}
    ${CountActualErrorElements}=    Get Length    ${CopyActualErrorElements}
    RETURN    @{ActualErrorElements}

UnorderedList specific get text
    [Arguments]    ${Selector}
    #${ListEntryContent}=    Get Text    ${Selector}
    ${ListEntryContent}=    Get Element Attribute    ${Selector}    text
    RETURN    ${ListEntryContent}
