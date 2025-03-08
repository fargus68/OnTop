*** Settings ***
Library    AppiumLibrary
Library    String

*** Variables ***

*** Keywords ***
MultiSelectDropdown specific get selected options
    [Arguments]    ${Selector}
    ${SelectedOptions}=    AppiumLibrary.Get Selected Options    ${Selector}
    RETURN    ${SelectedOptions}

MultiSelectDropdown specific select options by label
    [Arguments]    ${Selector}    ${Value}
    AppiumLibrary.Select Options By    ${Selector}    Label    ${Value}
