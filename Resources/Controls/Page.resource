*** Settings ***
Library    String
Library    Browser
Library    ../../Libraries/HTMLClasses.py

*** Variables ***

*** Keywords ***
PageProcessing
    [Arguments]    ${Modus}    ${Name}    ${Selector}    ${Value}

    IF  '${Modus}' == '<GET>'
        PageProcessingGet    ${Name}    ${Selector}    ${Value}
    ELSE IF  '${Modus}' == '<CHK>'
        PageProcessingChk    ${Name}    ${Selector}    ${Value}
    ELSE IF  '${Modus}' == '<SET>'
        PageProcessingSet    ${Name}    ${Selector}    ${Value}
    ELSE
        Fatal Error    Modus not defined
    END

PageProcessingGet
    [Arguments]    ${Name}    ${Selector}    ${Value}
    Log        PageProcessingGet
    ${FirstLetterOfValue}=    Get Substring    ${Value}    0    1
    IF  '${FirstLetterOfValue}' == 'X'
        ${PageContent}=    Get Text    ${Selector}
        IF    '${PageContent}' == ''
            Log    Page content = <EMPTY>
        ELSE
            Log    Page content = '${PageContent}'
        END
    ELSE IF  '${FirstLetterOfValue}' == '<'
        Log    To be defined
    ELSE
        Fatal Error    Value of Get-modus is X or a variable name
    END

PageProcessingChk
    [Arguments]    ${Name}    ${Selector}    ${Value}
    Log        PageProcessingChk
    IF    '${Value}' == '<SELECTED>'
        ${list_of_classes}=    Get Classes    ${Selector}
        ${class_name}=    Convert To String    active
        ${found}=    check_if_element_contains_class    ${list_of_classes}    ${class_name}
        IF    ${found}
            Log    Page tab selected as expected!
        ELSE
            Fail    Page tab not selected, but expected to be selected!!!
        END
    END
    IF    '${Value}' != '<NOTSELECTED>'
        ${list_of_classes}=    Get Classes    ${Selector}
        ${class_name}=    Convert To String    active
        ${found}=    check_if_element_contains_class    ${list_of_classes}    ${class_name}
        IF    ${found}
            Log    Page tab not selected as expected!
        ELSE
            Fail    Page tab selected, but expected to be not selected!!!
        END
    END


PageProcessingSet
    [Arguments]    ${Name}    ${Selector}    ${Value}
    #Log        PageProcessingSet
    ${FirstLetterOfValue}=    Get Substring    ${Value}    0    1
    IF  '${FirstLetterOfValue}' == 'X'
        Click    ${Selector}
    ELSE IF  '${FirstLetterOfValue}' == '<'
        IF    '${Value}' == '<SELECT>'
            Click    ${Selector}
        END
    ELSE
        Fatal Error    Value of Set-modus is X or a variable name
    END