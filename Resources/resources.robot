*** Settings ***

*** Variables ***
${My-Var}        with Variables
@{MyList}        Elem1    Elem2    Elem3
&{MyDic}         SurName=Matthias    Name=Schmotz

*** Keywords ***
Log my name
    Log    With a single dictionary element ${MyDic}[Name]

Log surname
    [Arguments]    ${SurName}
    Log    With a single variable argument ${SurName}

Log whole name
    [Arguments]    ${CompleteName}
    Log    With a single dictionary element ${CompleteName}[SurName] ${CompleteName}[Name]
