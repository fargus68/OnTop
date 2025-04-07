*** Settings ***
Library    String
Library    Browser
Library    BuiltIn
Library    ../../Libraries/Keywords.py
Library    ../../Libraries/fullStringCheck.py

*** Variables ***
${LONG_DASH}    –

*** Keywords ***
firstElementKeywordsProcessing
    [Arguments]    ${availableOptions}    ${Value}
    #Log    ${availableOptions}
    #Log    ${availableOptions}[0]
    #Log    ${availableOptions}[0][value]
    #Log    ${Value}

    ${firstElementValueExpected}=    get_keyword_value    ${Value}    FIRSTELEMENT
    ${firstElementValueActual}=    Convert To String    ${availableOptions}[0][label]

    ${rc}=    Full String Check    ${firstElementValueExpected}    ${firstElementValueActual}
    IF    ${rc} == ${False}
        Fail    Full string compare failed!
    END

    #Fail    For testing purposes!

    RETURN

contentKeywordsProcessing
    [Arguments]    ${availableOptions}    ${Value}
    #Log    ${availableOptions}
    #Log    ${availableOptions}[0]
    #Log    ${availableOptions}[0][value]
    #Log    ${Value}

    ${elementValuesExpected}=    get_keyword_string_values    ${Value}    CONTENT
    ${elementValuesActual}=    Evaluate    [item["label"] for item in ${availableOptions}]

    ${rc}=    Full String Check    ${elementValuesExpected}    ${elementValuesActual}
    IF    ${rc} == ${False}
        Fail    Full string compare failed!
    END

    #Fail    For testing purposes!

    RETURN