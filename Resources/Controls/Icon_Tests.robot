*** Settings ***
Resource    ../../Resources/Utils/Browser_Mgmt.resource
Resource    ../../Resources/Framework/fwDialog.resource
Resource    ../../Resources/Controls/Icon.resource

*** Test Cases ***
Set_ClickIconAbmelden
    Set Up Browser
    DialogExecution    dlgLogin    001_Login_001_Successful    
    IconProcessing    dlgMain    <SET>    icoAbmelden    xpath=//*[@class='bx bx-power-off mr-5']    X