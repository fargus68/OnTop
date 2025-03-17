*** Settings ***
Library    ExcelLibrary
Library    String
Resource    Browser_Mgmt.resource

*** Test Cases ***
Setup AUT Chromium Test
    Setup AUT Chromium

Setup AUT Chromium VehicleInsuranceDemoApp
    Setup AUT Chromium VehicleInsuranceDemoApp
