*** Settings ***
Library    String
Library    Browser
Resource    ../../Resources/Framework/fwVariables.resource

*** Variables ***

*** Keywords ***
UnorderedListProcessing
    [Arguments]    ${Container}    ${Modus}    ${Name}    ${Selector}    ${Value}

    IF  '${Modus}' == '<GET>'
        UnorderedListProcessingGet    ${Name}    ${Selector}    ${Value}
    ELSE IF  '${Modus}' == '<CHK>'
        UnorderedListProcessingChk    ${Name}    ${Selector}    ${Value}
    ELSE IF  '${Modus}' == '<SET>'
        Fatal Error    Set-modus not available für unordered list element
    ELSE
        Fatal Error    Modus not defined
    END

UnorderedListProcessingGet
    [Arguments]    ${Name}    ${Selector}    ${Value}
    Log        UnorderedListProcessingGet
    ${FirstLetterOfValue}=    Get Substring    ${Value}    0    1
    IF  '${FirstLetterOfValue}' == 'X'
        @{ErrorElements}=    Get Elements    ${Selector}

        FOR    ${ListEntry}    IN    @{ErrorElements}
            Get Text    ${ListEntry}
        END
    ELSE IF  '${FirstLetterOfValue}' == '<'
        Log    To be defined
    ELSE
        Fatal Error    Value of Get-modus is X or a variable name
    END

UnorderedListProcessingChk
    [Arguments]    ${Name}    ${Selector}    ${Value}
    Log        UnorderedListProcessingChk
    ${ValueToCheck}=    GetValueWithResolvedVariables    ${Value}
    Log    ${ValueToCheck}
    Fatal Error    TESTING