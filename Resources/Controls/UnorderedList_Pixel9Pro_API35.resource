*** Settings ***
Library    String
Library    ../../Libraries/elementHelperAppium.py    WITH NAME    ElementHelper

*** Variables ***

*** Keywords ***
UnorderedList specific get elements
    [Arguments]    ${Selector}
    #Wait Until Element Is Visible    ${Selector}
    #@{ActualErrorElements}=    AppiumLibrary.Get WebElements    xpath=//android.widget.ListView//android.view.View//android.widget.TextView
    @{ActualErrorElements}=    ElementHelper.Search Sub Elements        ${Selector}//android.view.View//android.widget.TextView
    ${CopyActualErrorElements}=    Create List    @{ActualErrorElements}
    ${CountActualErrorElements}=    Get Length    ${CopyActualErrorElements}
    RETURN    @{ActualErrorElements}

UnorderedList specific get text
    [Arguments]    ${element}
    #[Arguments]    ${Selector}
    #${ListEntryContent}=    Get Text    ${Selector}
    #${ListEntryContent}=    Get Element Attribute    ${Selector}    text
    #${element}=    ElementHelper.Search Element    ${Selector}
    ${type}=   Evaluate    type(${element}).__name__
    Log    Type = '${type}'
    ${ListEntryContent}=    Evaluate    ${element}.text
    RETURN    ${ListEntryContent}
