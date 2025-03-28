*** Settings ***
Library    String
Library    Browser

*** Variables ***

*** Keywords ***
Page specific get text
    [Arguments]    ${Selector}
    ${PageContent}=    Browser.Get Text    ${Selector}
    RETURN    ${PageContent}

Page specific get classes
    [Arguments]    ${Selector}
    ${PageClasses}=    Browser.Get Classes    ${Selector}
    RETURN    ${PageClasses}

Page specific click
    [Arguments]    ${Selector}
    #${ContainsInsuranceForm}=    Evaluate    '//*[@id="insurance-form"]/div/section' in ${Selector}
    ${ContainsInsuranceForm}=    Evaluate    'insurance-form' in "${Selector}"
    Run Keyword If    ${ContainsInsuranceForm}    Get VIA Page Selector    ${Selector}        
    Browser.Click    ${Selector}

Get VIA Page Selector
    [Arguments]    ${Selector}
    #original selector = //*[@id="insurance-form"]/div/section[2]
    ${start_removed}    Evaluate    "${Selector}"[38:]
    ${ixPage}=    Evaluate    "${start_removed}"[:-1]
    ${newSelector}=    Catenate    SEPARATOR=    //*[@id="idealsteps-nav"]/ul/li[    ${ixPage}    ]
    Set Test Variable    ${Selector}    ${newSelector}