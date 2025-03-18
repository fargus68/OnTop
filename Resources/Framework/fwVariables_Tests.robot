*** Settings ***
Library    ExcelLibrary
Library    String
Resource    ../../Resources/Framework/fwVariables.resource

*** Variables ***

*** Keywords ***

*** Test Cases ***
unitTest001
    InitializeVariableStorage
    ReportVariables
    SetVariableValue    Testvar1    Testvalue1
    ReportVariables
    ReadVariablesFromFile    var001_Login_001_Successful    Config2
    ReportVariables
    GetVariableValue    Testvar1
    
unitTest002
    InitializeVariableStorage
    ReadVariablesFromFile    var001_Login_001_Successful    Config2
    ReportVariables
    ${BaseStateChromium}=    GetVariableValue    BaseStateChromium
    Log    ${BaseStateChromium}

unitTest003_GetValueWithResolvedVariables_NoVariableIncluded
    InitializeVariableStorage
    ${NewValue}=    GetValueWithResolvedVariables    E-Mail-Adresse muss ausgefüllt werden.<||>Passwort muss ausgefüllt werden.
    Log    ${NewValue}

unitTest004_GetValueWithResolvedVariables_VariablesIncluded
    InitializeVariableStorage
    SetVariableValue    ERROR_EmptyEmail    E-Mail-Adresse muss ausgefüllt werden.
    SetVariableValue    ERROR_EmptyPassword    Passwort muss ausgefüllt werden.
    ReportVariables
    ${NewValue}=    GetValueWithResolvedVariables    <VAR ERROR_EmptyEmail><||><VAR ERROR_EmptyPassword>
    Log    ${NewValue}
    
unitTest005_GetVariableValueWithVariableAsParameter
    InitializeVariableStorage
    SetVariableValue    ERROR_EmptyEmail    E-Mail-Adresse muss ausgefüllt werden.
    ${Variable}=    Convert To String    ERROR_EmptyEmail
    ${Value}=    GetVariableValue     ${Variable}
    Log    ${Value}    