*** Settings ***
Library    String

*** Variables ***
${NoMandatoryField}    <NoMandatoryField>
${MissingMandatoryField}    <MissingMandatoryField>
${FilledMandatoryField}    <FilledMandatoryField>

*** Keywords ***
mandatoryFieldKeywordsProcessing
    [Arguments]    ${Selector}    ${Value}
    Log    ${Selector}
    Log    ${Value}

    Set Local Variable    ${keywordProcesses}    ${False}

    IF    '${Value}' == '${NoMandatoryField}'
        Log    Keyword = <NoMandatoryField>
        Set Local Variable    ${keywordProcesses}    ${True}
    ELSE IF    '${Value}' == '<MissingMandatoryField>'
        Log    Keyword = <MissingMandatoryField>
        Set Local Variable    ${keywordProcesses}    ${True}
    ELSE IF    '${Value}' == '<FilledMandatoryField>'
        Log    Keyword = <FilledMandatoryField>
        Set Local Variable    ${keywordProcesses}    ${True}
    ELSE
        Log    No mandatory field keyword found!
    END
    
    RETURN    ${keywordProcesses}