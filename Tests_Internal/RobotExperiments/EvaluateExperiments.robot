*** Settings ***

*** Test Cases ***
Test1
    ${Selector}=    Convert To String    xpath=//*/li[@class = 'nav-item']/a[text()=' Abwesenheiten']
    ${ContainsInsuranceForm}=    Evaluate    'insurance-form' in "${Selector}"

Test2
    ${ContainsInsuranceForm}=    Evaluate    'insurance-form' in 'xpath=//*/li[@class = 'nav-item']/a[text()=' Abwesenheiten']'