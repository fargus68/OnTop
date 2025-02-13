*** Settings ***
Resource    ../../Resources/Utils/Browser_Mgmt.resource
Resource    ../../Resources/Controls/Textbox.resource

*** Keywords ***

*** Test Cases ***
Textbox_Tests_AllModus
    Set Up Browser
    TextboxProcessing    dlgLogin    <GET>    txtEmail    id=email    X
    TextboxProcessing    dlgLogin    <SET>    txtEmail    id=email    matthias@matthias-schmotz.de
    TextboxProcessing    dlgLogin    <GET>    txtEmail    id=email    X
    TextboxProcessing    dlgLogin    <CHK>    txtEmail    id=email    matthias@matthias-schmotz.de