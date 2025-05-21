*** Settings ***
#Library    BuiltIn

Library    Collections
Library    String
Library    ../../Libraries/elementHelperAppium.py    WITH NAME    ElementHelper

*** Variables ***

*** Keywords ***
UnorderedList specific get elements
    [Arguments]    ${Selector}
    #Wait Until Element Is Visible    ${Selector}
    #@{ActualErrorElements}=    AppiumLibrary.Get WebElements    xpath=//android.widget.ListView//android.view.View//android.widget.TextView
    
    #Check for the container itself
    ${elementSelector}=    ElementHelper.Search Element    ${Selector}
    
    @{ActualErrorElements}=    ElementHelper.Search Sub Elements    ${Selector}//android.view.View//android.widget.TextView
    ${CopyActualErrorElements}=    Create List    @{ActualErrorElements}
    ${CountActualErrorElements}=    Get Length    ${CopyActualErrorElements}
    ${ActualErrorElements2}=    ElementHelper.Search Sub Elements        ${Selector}//android.view.View//android.widget.TextView
    @{CopyActualErrorElements2}=    Create List    ${ActualErrorElements}
    #RETURN    @{ActualErrorElements}
    RETURN    ${CopyActualErrorElements}
    #RETURN    ${ActualErrorElements2}
    #RETURN    ${CopyActualErrorElements2}

UnorderedList specific get text
    [Arguments]    ${element}
    #[Arguments]    ${Selector}
    #${ListEntryContent}=    Get Text    ${Selector}
    #${ListEntryContent}=    Get Element Attribute    ${Selector}    text
    #${element}=    ElementHelper.Search Element    ${Selector}

    #${type}=   Evaluate    type(${element}).__name__
    #${type}=   Evaluate    type($element).__name__    element=${element}
    #${type}=   Get Variable Type    ${element}
    #Log    Type = '${type}'

    #${ListEntryContent}=    Evaluate    ${element}.text
    #${ListEntryContent}=    Evaluate    ${element}.getText()
    #${ListEntryContent}=    Evaluate    ${element}.get_attribute("text")

    #${ListEntryContent}=    Evaluate    $element.text    element=${element}
    #${ListEntryContent}=    Evaluate    $element.text    namespace={"element": $element}

    ${ListEntryContent}=     Set Variable    ${element.text}
    RETURN    ${ListEntryContent}

UnorderedList specific get element texts
    [Arguments]    ${Selector}
    #${elementSelector}=    ElementHelper.Search Element    ${Selector}
    @{ActualErrorElements}=    ElementHelper.Search Sub Elements    ${Selector}//android.view.View//android.widget.TextView

    @{ActualErrorElementTexts}=    Create List
    #@{ActualErrorElementTexts}=
    FOR    ${ListEntry}    IN    @{ActualErrorElements}
        ${ListEntryContent}=     Set Variable    ${ListEntry.text}
        Append To List    ${ActualErrorElementTexts}    ${ListEntryContent}
    END
    #${CopyActualErrorElementTexts}=    Create List    @{ActualErrorElementTexts}

    #RETURN    ${CopyActualErrorElementTexts}
    RETURN    ${ActualErrorElementTexts}
    
