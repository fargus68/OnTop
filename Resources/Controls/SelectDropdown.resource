*** Settings ***
Library    String
#Library    Browser

*** Variables ***

*** Keywords ***
SelectDropdownProcessing
    [Arguments]    ${Container}    ${Modus}    ${Name}    ${Selector}    ${Value}

    ${actualAUT}=    GetVariableValue    AUT
    ${controlResourceFullPath}=    Catenate    SEPARATOR=    C:/Users/matth/PycharmProjects/OnTop/Resources/Controls/SelectDropdown_    ${actualAUT}    .resource
    Import Resource    ${controlResourceFullPath}

    IF  '${Modus}' == '<GET>'
        SelectDropdownProcessingGet    ${Name}    ${Selector}    ${Value}
    ELSE IF  '${Modus}' == '<CHK>'
        SelectDropdownProcessingChk    ${Name}    ${Selector}    ${Value}
    ELSE IF  '${Modus}' == '<SET>'
        SelectDropdownProcessingSet    ${Name}    ${Selector}    ${Value}
    ELSE
        Fatal Error    Modus not defined
    END

SelectDropdownProcessingGet
    [Arguments]    ${Name}    ${Selector}    ${Value}    
    #Log        SelectDropdownProcessingGet
    ${FirstLetterOfValue}=    Get Substring    ${Value}    0    1
    IF  '${FirstLetterOfValue}' == 'X'
        #${SelectDropdownContent}=    Get Selected Options    ${Selector}
        ${SelectDropdownContent}=    SelectDropdown specific get selected options    ${Selector}
        IF    "'${SelectDropdownContent}' == ''"
            Log    SelectDropdown content = <EMPTY>
        ELSE
            Log    SelectDropdown content = '${SelectDropdownContent}'
        END
        Log Many    ${SelectDropdownContent}
    ELSE IF  '${FirstLetterOfValue}' == '<'
        Log    SelectDropdownProcessingGet
    ELSE
        Fatal Error    Value of Get-modus is X or a variable name
    END

SelectDropdownProcessingChk
    [Arguments]    ${Name}    ${Selector}    ${Value}    
    Log        SelectDropdownProcessingChk

SelectDropdownProcessingSet
    [Arguments]    ${Name}    ${Selector}    ${Value}
    SelectDropdown specific select option by label    ${Selector}    ${Value}