*** Settings ***
Library    Keywords.py

*** Variables ***

*** Test Cases ***
test_001_get_keyword_value
    ${keywordValue}=    get_keyword_value    vorher<VAR hallo>nachher    VAR
    Log    ${keywordValue}

test_001_get_full_keyword_substring
    ${keywordValue}=    get_full_keyword_substring    vorher<VAR hallo>nachher    VAR
    Log    ${keywordValue}

test_002_get_full_keyword_substring_ListSeparatorKeyword
    Set Local Variable    ${keywordListSeparator}    ||
    ${keywordValue}=    get_full_keyword_substring    Eintrag 1<||>Eintrag 2    ${keywordListSeparator}
    Log    ${keywordValue}

test_001_get_any_full_keyword_substring
    ${keywordValue}=    get_any_full_keyword_substring    vorher<VAR hallo>nachher
    Log    ${keywordValue}