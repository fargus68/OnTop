*** Settings ***
Library    Collections
Library    OperatingSystem
Library    RecordReader.py

*** Variables ***
${FlowFile}    ./Data/Flows/floLogin.xlsx
${ProcessFile}    ./Data/Processes/proLogin.xlsx
${DialogFile}    ./Data/Dialogs/dlgLogin.xlsx
${TableFile}    ./Data/Tables/dlgProfil_pagAbwesenheiten_tabAnwesenheiten.xlsx

*** Test Cases ***
ReadFlow_Test1_RecordExist
    File Should Exist    ${FlowFile}
    ${AllData}=    Read Records From Excel    ${FlowFile}    002_PasswordReset_001_Successful    #1    False
    Log Many    ${AllData}

ReadFlow_Test2_RecordNotExist
    File Should Exist    ${FlowFile}
    ${AllData}=    Read Records From Excel    ${FlowFile}    RecordNotExist    #1    False
    Log Many    ${AllData}

ReadProcess_Test1_RecordExist
    File Should Exist    ${ProcessFile}
    ${AllData}=    Read Records From Excel    ${ProcessFile}    002_PasswordReset_001_Successful    #1    False
    Log Many    ${AllData}

ReadDialog_Test1_RecordExist
    File Should Exist    ${DialogFile}
    ${AllData}=    Read Records From Excel    ${DialogFile}    001_Login_001_Successful    2    False
    Log Many    ${AllData}
    Get Length    ${AllData}

ReadTable_Test1_RecordsExist
    File Should Exist    ${TableFile}
    ${AllData}=    Read Records From Excel    ${TableFile}    Record2    2    True
    Log Many    ${AllData}
    Get Length    ${AllData}
