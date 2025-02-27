*** Settings ***
Library    Browser
Library    String

*** Variables ***

*** Keywords ***
MultiSelectDropdown specific get selected options
    [Arguments]    ${Selector}
    ${SelectedOptions}=    Browser.Get Selected Options    ${Selector}
    RETURN    ${SelectedOptions}

MultiSelectDropdown specific select options by label
    [Arguments]    ${Selector}    ${Value}
    Browser.Select Options By    ${Selector}    Label    ${Value}
    