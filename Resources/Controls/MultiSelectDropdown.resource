*** Settings ***
Library    String
Library    Browser

*** Variables ***

*** Keywords ***
MultiSelectDropdownProcessing
    [Arguments]    ${Modus}    ${Name}    ${Selector}    ${Value}

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
        #${MultiSelectDropdownContent}=    Get Text    ${Selector}
        ${MultiSelectDropdownContent}=    Get Selected Options    ${Selector}
        IF    '${MultiSelectDropdownContent}' == ''
            Log    MultiSelectDropdown content = <EMPTY>
        ELSE
            Log    MultiSelectDropdown content = '${MultiSelectDropdownContent}'
        END
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
    Select Options By    ${Selector}    Value    ${Value}
    
    