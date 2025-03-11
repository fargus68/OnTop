*** Settings ***
Library    AppiumLibrary
Library    String
Library    C:/Users/matth/PycharmProjects/OnTop/Libraries/dateTimePickerHelperAppium.py
Resource    C:/Users/matth/PycharmProjects/OnTop/Resources/Utils/Mobile_Mgmt.resource

*** Variables ***

*** Keywords ***
Calendar specific get text
    [Arguments]    ${Selector}
    ${CalendarContent}=    AppiumLibrary.Get Text    ${Selector}
    RETURN    ${CalendarContent}

Calendar specific set text
    [Arguments]    ${Selector}    ${Value}
    #Input Text    ${Selector}    ${Value}
    AppiumLibrary.Wait Until Element Is Visible    ${Selector}
    AppiumLibrary.Click Element    ${Selector}
    dateTimePickerHelperAppium.set value    ${Value}
    Open Application TT-Planer on Google Pixel 9