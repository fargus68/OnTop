*** Settings ***
#Library    AppiumLibrary
Library    ../../Libraries/elementHelperAppium.py    WITH NAME    ElementHelper
Library    String

#ToDo: mal schauen ob irgendwo so ein select-Element vorhanden ist im TT-Planer

*** Variables ***

*** Keywords ***
SelectDropdown specific get selected options
    [Arguments]    ${Selector}
    #${SelectedOption}=    AppiumLibrary.Get Selected Options    ${Selector}
    ${element}=    ElementHelper.Search Element    ${Selector}
    ${SelectedOption}=    Set Variable    ${element.get_selected_options}
    RETURN    ${SelectedOption}

SelectDropdown specific get available options
    [Arguments]    ${Selector}
    Fail    Not implemented yet!
    #${AvailableOptions}=    AppiumLibrary.Get Available Options    ${Selector}
    RETURN    ${AvailableOptions}

SelectDropdown specific select options by label
    [Arguments]    ${Selector}    ${Value}
    #AppiumLibrary.Select Options By    ${Selector}    Label    ${Value}
    ${element}=    ElementHelper.Search Element    ${Selector}
    Evaluate    $element.select_options_by("Label", $Value)

