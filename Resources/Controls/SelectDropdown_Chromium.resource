*** Settings ***
Library    Browser
Library    String

*** Variables ***

*** Keywords ***
SelectDropdown specific get selected options
    [Arguments]    ${Selector}
    ${SelectedOption}=    Browser.Get Selected Options    ${Selector}
    RETURN    ${SelectedOption}

SelectDropdown specific select option by label
    [Arguments]    ${Selector}    ${Value}
    Browser.Select Options By    ${Selector}    Label    ${Value}