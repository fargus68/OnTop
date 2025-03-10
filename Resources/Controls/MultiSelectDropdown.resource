*** Settings ***
Library    String
Library    Browser

*** Variables ***

*** Keywords ***
MultiSelectDropdownProcessing
    [Arguments]    ${Container}    ${Modus}    ${Name}    ${Selector}    ${Value}

    ${actualAUT}=    GetVariableValue    AUT
    ${controlResourceFullPath}=    Catenate    SEPARATOR=    C:/Users/matth/PycharmProjects/OnTop/Resources/Controls/MultiSelectDropdown_    ${actualAUT}    .resource
    Import Resource    ${controlResourceFullPath}

    IF  '${Modus}' == '<GET>'
        MultiSelectDropdownProcessingGet    ${Name}    ${Selector}    ${Value}
    ELSE IF  '${Modus}' == '<CHK>'
        MultiSelectDropdownProcessingChk    ${Name}    ${Selector}    ${Value}
    ELSE IF  '${Modus}' == '<SET>'
        MultiSelectDropdownProcessingSet    ${Name}    ${Selector}    ${Value}
    ELSE
        Fatal Error    Modus not defined
    END

MultiSelectDropdownProcessingGet
    [Arguments]    ${Name}    ${Selector}    ${Value}    
    Log        MultiSelectDropdownProcessingGet
    ${FirstLetterOfValue}=    Get Substring    ${Value}    0    1
    IF  '${FirstLetterOfValue}' == 'X'
        #${MultiSelectDropdownContent}=    Get Selected Options    ${Selector}
        ${MultiSelectDropdownContent}=    MultiSelectDropdown specific get selected options    ${Selector}
        IF    "'${MultiSelectDropdownContent}' == ''"
            Log    MultiSelectDropdown content = <EMPTY>
        ELSE
            Log    MultiSelectDropdown content = '${MultiSelectDropdownContent}'
        END
        Log Many    ${MultiSelectDropdownContent}
    ELSE IF  '${FirstLetterOfValue}' == '<'
        Log    MultiSelectDropdownProcessingGet
    ELSE
        Fatal Error    Value of Get-modus is X or a variable name
    END

MultiSelectDropdownProcessingChk
    [Arguments]    ${Name}    ${Selector}    ${Value}    
    Log        MultiSelectDropdownProcessingChk

MultiSelectDropdownProcessingSet
    [Arguments]    ${Name}    ${Selector}    ${Value}    
    #Log        MultiSelectDropdownProcessingSet
    #Type Text    ${Selector}    ${Value}    0.1    False
    ${SelectKeyword}=    Convert To String    <SELECT>
    ${ContainsSelect}=    Evaluate    '${SelectKeyword}' in '${Value}'
    IF    ${ContainsSelect}
        ${ValueToSelect}=    Remove String    ${Value}    ${SelectKeyword}
        #Select Options By    ${Selector}    Label    ${ValueToSelect}
        MultiSelectDropdown specific select options by label    ${Selector}    ${ValueToSelect}
    END
    