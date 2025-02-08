*** Settings ***
Resource    ../../Resources/Utils/Browser_Mgmt.resource
Resource    ../../Resources/Controls/UnorderedList.resource

*** Test Cases ***
Get_UnorderedList_KeywordX
    Set Up Browser
    Click    text=Einloggen
    UnorderedListProcessing    <GET>    uliFehler    xpath=//*[@class='alert alert-danger border-left-danger alert-dismissible fade show']/ul/li    X