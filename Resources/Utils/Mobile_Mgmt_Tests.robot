*** Settings ***
#Library    ExcelLibrary
#Library    ScreenCapLibrary
#Library    String
Resource    Mobile_Mgmt.resource

*** Test Cases ***
Set Up Pixel9Pro_API35
    Set Up Pixel9Pro_API35

Start pixel
    Setup AUT Pixel9Pro_API35 NoWaitForLoginScreen

Start app on pixel
    Setup AUT Pixel9Pro_API35
