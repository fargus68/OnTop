*** Settings ***
Library    String
Library    Collections
#Library    Browser
Resource    ../../Resources/Framework/fwVariables.resource

*** Variables ***

*** Keywords ***
UnorderedListProcessing
    [Arguments]    ${Container}    ${Modus}    ${Name}    ${Selector}    ${Value}

    ${actualAUT}=    GetVariableValue    AUT
    ${controlResourceFullPath}=    Catenate    SEPARATOR=    C:/Users/matth/PycharmProjects/OnTop/Resources/Controls/UnorderedList_    ${actualAUT}    .resource
    Import Resource    ${controlResourceFullPath}

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
        #@{ErrorElements}=    Get Elements    ${Selector}
        @{ErrorElements}=    UnorderedList specific get elements    ${Selector}
        FOR    ${ListEntry}    IN    @{ErrorElements}
            #Get Text    ${ListEntry}
            UnorderedList specific get text    ${ListEntry}
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

    @{ExpectedErrorElements}=    Split String    ${ValueToCheck}    <||>
    ${CopyExpectedErrorElements}=    Create List    @{ExpectedErrorElements}
    ${CountExpectedErrorElements}=    Get Length    ${CopyExpectedErrorElements}

    @{ActualErrorElements}=    UnorderedList specific get elements    ${Selector}
    ${CopyActualErrorElements}=    Create List    @{ActualErrorElements}
    ${CountActualErrorElements}=    Get Length    ${CopyActualErrorElements}

    #ToDo: implement different checks <FULLMATCH>, <PARTMATCH>, <ENTRYMATCH>, more ?

    #actual testing full match
    IF    '${CountExpectedErrorElements}' != '${CountActualErrorElements}'
        Fail    Different count of error elements
    END
        
    FOR    ${ListEntry}    IN    @{ActualErrorElements}
        #Get Text    ${ListEntry}
        UnorderedList specific get text    ${ListEntry}
    END