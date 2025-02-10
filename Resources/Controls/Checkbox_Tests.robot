*** Settings ***
Resource    ../../Resources/Utils/Browser_Mgmt.resource
Resource    ../../Resources/Framework/fwDialog.resource
Resource    ../../Resources/Controls/Checkbox.resource

*** Test Cases ***
Get_Checkbox_normalLogging
    Set Up Browser
    DialogExecution    dlgLogin    001_Login_001_Successful
    CheckboxProcessing    Processing    <GET>    chkTeilnahmeTrainingApp    text=Einloggen    X