*** Settings ***
Library    AppiumLibrary
Library    String

*** Variables ***

*** Keywords ***
SelectDropdown specific get selected options
    [Arguments]    ${Selector}
    ${SelectedOption}=    AppiumLibrary.Get Selected Options    ${Selector}
    RETURN    ${SelectedOption}

SelectDropdown specific select options by label
    [Arguments]    ${Selector}    ${Value}
    AppiumLibrary.Select Options By    ${Selector}    Label    ${Value}
