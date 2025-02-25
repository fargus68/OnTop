*** Settings ***
Library    BuiltIn

*** Variables ***
@{MyList}    Item1    Item2    Item3    Item4

*** Test Cases ***
Count Elements In List
    ${count}=    Get Length    @{MyList}
    Log    Anzahl der Elemente in der Liste: ${count}