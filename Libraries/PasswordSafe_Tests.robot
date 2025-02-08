*** Settings ***
Library    PasswordSafe.py

*** Test Cases ***
ReadPassword
    ${Password}=    read_password
