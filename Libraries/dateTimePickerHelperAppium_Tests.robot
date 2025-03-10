*** Settings ***
Library    dateTimePickerHelperAppium.py

*** Variables ***

*** Test Cases ***
Calendar set value
    ${rc}=    Set Value    31.12.2025
    Log    ${rc}