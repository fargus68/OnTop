*** Settings ***
Library    String
#Library    Browser
Library    ../../Libraries/PasswordSafe.py

*** Variables ***

*** Keywords ***
PasswordProcessing
    [Arguments]    ${Container}    ${Modus}    ${Name}    ${Selector}    ${Value}

    ${actualAUT}=    GetVariableValue    AUT
    ${controlResourceName}=    Catenate    SEPARATOR=    C:/Users/matth/PycharmProjects/OnTop/Resources/Controls/Password_    ${actualAUT}    .resource
    Import Resource    ${controlResourceName}

    IF  '${Modus}' == '<GET>'
        PasswordProcessingGet    ${Name}    ${Selector}    ${Value}
    ELSE IF  '${Modus}' == '<CHK>'
        PasswordProcessingChk    ${Name}    ${Selector}    ${Value}
    ELSE IF  '${Modus}' == '<SET>'
        PasswordProcessingSet    ${Name}    ${Selector}    ${Value}
    ELSE
        Fatal Error    Modus not defined
    END

PasswordProcessingGet
    [Arguments]    ${Name}    ${Selector}    ${Value}    
    #Log        PasswordProcessingGet
    ${FirstLetterOfValue}=    Get Substring    ${Value}    0    1
    IF  '${FirstLetterOfValue}' == 'X'
        ${PasswordContent}=    Password specific get text    ${Selector}
        IF    '${PasswordContent}' == ''
            Log    Password content = <EMPTY>
        ELSE
            Log    Password content = '${PasswordContent}'
        END
    ELSE IF  '${FirstLetterOfValue}' == '<'
        Log    To be defined
    ELSE
        Fatal Error    Value of Get-modus is X or a variable name
    END

PasswordProcessingChk
    [Arguments]    ${Name}    ${Selector}    ${Value}    
    Log        PasswordProcessingChk

PasswordProcessingSet
    [Arguments]    ${Name}    ${Selector}    ${Value}    
    #Log        PasswordProcessingSet
    IF    $Value == '<GETPASSWORD>'
        ${Value}=    read_password
        #${Value}=    ${ValueFromPasswordSafe}
    END
    Password specific set text    ${Selector}    ${Value}