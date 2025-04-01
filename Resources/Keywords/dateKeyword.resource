*** Settings ***
Library    String
Library    BuiltIn
Library    DateTime

*** Variables ***

*** Keywords ***
todayKeywordProcessing
    [Arguments]    ${Value}
    Log    ${Value}
    
    ${resolvedValue}=    Convert To String    Not determined yet!
    IF    '${Value}' == '<TODAY>'
        ${resolvedValue}=    Get Current Date    result_format==%m/%d/%Y
        # Windows only:
        # ${resolvedValueNoLeadingZeros}=    Get Current Date    result_format==%#m/%#d/%#Y
    ELSE
        #${CommaCount}=    ${Value}
        Log    not implemented yet!
        ${containsToday}=    Evaluate    '<TODAY ' in '${Value}'
        IF    ${containsToday}
            Log    Must be splittet. Python code fits better I think
        END
    END

    RETURN    ${resolvedValue}