*** Settings ***
Library    ExcelLibrary
Library    String
Resource    ../../Resources/Framework/fwVariables.resource
#Resource    ../../Resources/Framework/fwVariables.resource

*** Variables ***

*** Keywords ***

*** Test Cases ***
unitTest001
    InitializeVariableStorage
    ReportVariables
    SetVariableValue    Testvar1    Testvalue1
    ReportVariables
    ReadVariablesFromFile    001_Login_001_Successful    Config2
    ReportVariables
    GetVariableValue    Testvar1