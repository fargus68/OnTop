*** Settings ***
Library    ExcelLibrary
Library    String
Resource    Browser_Mgmt.resource

*** Test Cases ***
Setup AUT Chromium Test
    Setup AUT Chromium

Setup AUT Chromium VehicleInsuranceDemoApp
    Get Browser Catalog
    Open Browser    https://sampleapp.tricentis.com/101/index.php
    Fail    Test
    #Setup AUT Chromium VehicleInsuranceDemoApp
