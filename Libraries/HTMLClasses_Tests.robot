*** Settings ***
Library    HTMLClasses.py

*** Variables ***
${class_name}    active

*** Test Cases ***
Classes of element contains class
    ${list_of_classes}=    Create List    robot    secret    active    anything else
    ${found}=    check_if_element_contains_class    ${list_of_classes}    ${class_name}

Classes of element doesn't contains class
    ${list_of_classes}=    Create List    robot    secret    notactive    anything else
    ${found}=    check_if_element_contains_class    ${list_of_classes}    ${class_name}