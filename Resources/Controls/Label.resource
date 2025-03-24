*** Settings ***
Library    String
#Library    AppiumLibrary
#Library    Browser
Resource    ../../Resources/Framework/fwVariables.resource
#Resource    ../Controls/Textbox_Pixel9Pro_API35.resource

*** Variables ***

*** Keywords ***
LabelProcessing
    [Arguments]    ${Container}    ${Modus}    ${Name}    ${Selector}    ${Value}

    Log    ${CURDIR}

    ${actualAUT}=    GetVariableValue    AUT
    #${controlResourceFullPath}=    Catenate    SEPARATOR=    Resources/Controls/Textbox_    ${actualAUT}    .resource
    ${controlResourceFullPath}=    Catenate    SEPARATOR=    C:/Users/matth/PycharmProjects/OnTop/Resources/Controls/Label_    ${actualAUT}    .resource
    Import Resource    ${controlResourceFullPath}

    IF  '${Modus}' == '<GET>'
        LabelProcessingGet    ${Name}    ${Selector}    ${Value}
    ELSE IF  '${Modus}' == '<CHK>'
        LabelProcessingChk    ${Name}    ${Selector}    ${Value}
    ELSE IF  '${Modus}' == '<SET>'
        Fatal Error    Set-modus not available for label element
    ELSE
        Fatal Error    Modus not defined
    END

LabelProcessingGet
    [Arguments]    ${Name}    ${Selector}    ${Value}    
    Log        LabelProcessingGet
    ${FirstLetterOfValue}=    Get Substring    ${Value}    0    1
    IF  '${FirstLetterOfValue}' == 'X'
        ${LabelContent}=    Label specific get text    ${Selector}
        IF    '${LabelContent}' == ''
            Log    Label content = <EMPTY>
        ELSE
            Log    Label content = '${LabelContent}'
        END
    ELSE IF  '${FirstLetterOfValue}' == '<'
        Log    LabelProcessingGet
    ELSE
        Fatal Error    Value of Get-modus is X or a variable name
    END

LabelProcessingChk
    [Arguments]    ${Name}    ${Selector}    ${Value}    
    Log        LabelProcessingChk
    ${Value}=    Convert To String    ${Value}
    ${FirstLetterOfValue}=    Get Substring    ${Value}    0    1
    IF  '${FirstLetterOfValue}' == '<'
        ${LabelContent}=    Label specific get text    ${Selector}
        IF    '${LabelContent}' == ''
            Log    Label content = <EMPTY>
        ELSE
            Log    Label content = '${LabelContent}'
        END
    ELSE
        ${LabelContent}=    Label specific get text    ${Selector}
        ${LabelContent}=    Convert To String    ${LabelContent}
        IF    '${LabelContent}' == ''
            ${LabelContent}=    "<EMPTY>"
        END
        IF    '${LabelContent}' == '${Value}'
            ${SuccessMessage}=    Catenate    Separator=    SUCCESS: expected value '    ${Value}    ' found!    
            Log    ${SuccessMessage}
        ELSE
            ${FailureMessage}=    Catenate    Separator=    actual value = '    ${LabelContent}    ' - expected value '    ${Value}    '
            Fail    ${FailureMessage}
        END
    END
    
    