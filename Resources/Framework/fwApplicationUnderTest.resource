*** Settings ***
Library    String
Resource    ../../Resources/Framework/fwVariables.resource

*** Variables ***

*** Keywords ***
Get selector row index
    ${actualAUT}=    GetVariableValue    AUT
    ${tmpSelectorRowIndex}=    Convert To Number    2
    IF    $actualAUT == 'Chromium'
        ${tmpSelectorRowIndex}=    Convert To Number    1
    END
    #ToDo: implement search
    RETURN    ${tmpSelectorRowIndex}