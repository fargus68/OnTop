*** Keywords ***
Silent Loop
    [Arguments]    ${start}    ${end}    ${keyword}
    FOR    ${i}    IN RANGE    ${start}    ${end}
        Set Log Level    NONE
        Run Keyword    ${keyword}    ${i}
        Set Log Level    INFO
    END