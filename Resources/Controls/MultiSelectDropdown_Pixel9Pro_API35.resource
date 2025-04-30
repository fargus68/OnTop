*** Settings ***
#Library    AppiumLibrary
Library    ../../Libraries/elementHelperAppium.py    WITH NAME    ElementHelper
Library    String

*** Variables ***

*** Keywords ***
MultiSelectDropdown specific get selected options
    [Arguments]    ${Selector}
    #${SelectedOptions}=    AppiumLibrary.Get Selected Options    ${Selector}
    ${element}=    ElementHelper.Search Element    ${Selector}
    ${SelectedOption}=    Set Variable    ${element.get_selected_options}
    RETURN    ${SelectedOptions}

MultiSelectDropdown specific select options by label
    [Arguments]    ${Selector}    ${Value}
    #AppiumLibrary.Select Options By    ${Selector}    Label    ${Value}
    ${element}=    ElementHelper.Search Element    ${Selector}
    Evaluate    $element.select_options_by("Label", $Value)
