*** Settings ***
Library    BuiltIn
Library    Browser
Library    String

#Additional documentation:
#    https://www.youtube.com/watch?v=ofw9heqtv80
#    (Web Tables Handling | Browser Library)

*** Variables ***
${RowFound}    ${True}
${RowDeleted}    ${False}

*** Keywords ***
Table specific get text
    [Arguments]    ${Selector}
    ${TableContent}=    Browser.Get Text    ${Selector}
    RETURN    ${TextboxContent}

Table specific set text
    [Arguments]    ${Selector}    ${Value}
    Browser.Clear Text    ${Selector}
    Browser.Type Text    ${Selector}    ${Value}    0.01    False

Table specific delete keyword processing
    [Arguments]    ${Selector}    ${Value}    ${AllData}
    Log    Implementation not ready yet!
    Log Many    ${AllData}

    Wait For Load State    networkidle    timeout=3s


    ${col_count}=    Get Element Count    ${Selector}/thead/tr/th
    Log    col_count = ${col_count}

    FOR    ${col_ix}    IN RANGE    0    ${col_count}
        Log    Col = ${col_ix}
        ${CellValue}=     Get Table Cell Element    ${Selector}    ${col_ix}    0
        ${theValue}=     Get Text    ${CellValue}
        Log    --${theValue}
    END

    ${row_count}=    Get Element Count    ${Selector}/tbody/tr
    Log    row_count = ${row_count}

    ${RowFound}=    Set Variable    ${True}
    ${RowDeleted}=    Set Variable    ${False}
    FOR    ${row_ix}    IN RANGE    1    ${row_count+1}
        Set Variable    ${RowFound}    ${True}
        FOR    ${col_ix}    IN RANGE    0    ${col_count}
            ${Soll}=    Convert To String    ${AllData}[2][${col_ix+1}]
            IF    '${Soll}' != '${NONE}' and '${Soll}' != '${EMPTY}'
                ${CellValue}=     Get Table Cell Element    ${Selector}    ${col_ix}    ${row_ix}
                ${Ist}=    Get Text    ${CellValue}

                IF    '${Soll}' != '${Ist}'
                    ${RowFound}=    Set Variable    ${False}
                    Exit For Loop
                END
            END
        END

        IF    ${RowFound} == ${True}
            Log    now deleting row !!!
            ${CellRowMenu}=     Get Table Cell Element    ${Selector}    3    ${row_ix}
            #${RowMenu}=    Catenate    SEPARATOR=    ${CellRowMenu}    /*[@class='bx bx-dots-vertical-rounded']
            #${RowMenu}=    Catenate    SEPARATOR=    ${CellRowMenu}    /div/button/i
            #Click    ${RowMenu}

            Click    ${CellRowMenu} >> div >> button >> i

            Wait For Load State    networkidle    timeout=3s

            Browser.Take Screenshot    
            #${SelectorContextMenuItem}=    Catenate    SEPARATOR=    ${RowMenu}    /*[@class='dropdown-item' and text()=' Löschen']
            #${SelectorContextMenuItem}=    Catenate    SEPARATOR=    ${CellRowMenu}    /*[@class='dropdown-item' and text()=' Löschen']
            #${DeleteContextMenuItem}=    Get Element    ${SelectorContextMenuItem}
            #Click    ${DeleteContextMenuItem}
            BuiltIn.Sleep    1s
            #Click    ${CellRowMenu} >> :scope > .dropdown-item:text(' Löschen')
            #Click    body > div > div.layout-container > div > div > div.container-fluid.flex-grow-1.container-p-y > div > div > div > div > div > div > div.table-responsive.text-nowrap > table > tbody > tr:nth-child(1) > td:nth-child(4) > div > div
            #Click    ${CellRowMenu} >> .dropdown-item:text(' Löschen')
            BuiltIn.Sleep    1s
            Wait For Elements State    //*[@class='dropdown-menu show']    visible    timeout=3s
            Wait For Elements State    //*[@class='dropdown-menu show']/*[@class='dropdown-item' and text()=' Löschen']
            ${menItemDelete}=    Get Element    //*[@class='dropdown-menu show']/*[@class='dropdown-item' and text()=' Löschen']
            ${menItemDeleteSelector}=    Convert To String    //*[@class='dropdown-menu show']/*[@class='dropdown-item' and text()=' Löschen']

            #BuiltIn.Sleep    1s
            #Browser.Take Screenshot    selector=//*[@class='dropdown-menu show']/*[@class='dropdown-item' and text()=' Löschen']

            #Keyboard Key    press    ArrowDown
            #BuiltIn.Sleep    1s

            #Keyboard Key    press    ArrowDown
            #BuiltIn.Sleep    1s

            #${menItemDelete}=    Get Element    //*[@class='dropdown-menu show']/*[@class='dropdown-item' and text()=' Löschen']
            ${boundingBox}=    Get BoundingBox    ${menItemDelete}
            ${x}=    Evaluate    ${boundingBox}[x] + ${boundingBox}[width] / 2
            ${y}=    Evaluate    ${boundingBox}[y] + ${boundingBox}[height] / 2
            #Mouse Click    ${x}    ${y}
            Mouse Move    ${x}    ${y}    50
            #BuiltIn.Sleep    1s
            #Browser.Take Screenshot
            #Mouse Button    click    #${x}    ${y}
            #Mouse Button    click    #${x}    ${y}

            #Browser.Take Screenshot

            #Click With Options    ${menItemDeleteSelector}    force=True

            #Click    //*[@class='dropdown-menu show']/*[@class='dropdown-item' and text()=' Löschen']
            #Click    ${CellRowMenu}/following-sibling::div[contains(@class, 'dropdown-menu')]/*[@class='dropdown-item' and text()=' Löschen']

            #Mouse Button

            #Evaluate JavaScript    document.querySelector(".dropdown-menu.show .dropdown-item").click()

            #Browser.Take Screenshot  

            #Problem with click, no alert box
            #Wait For Alert    action=accept    text=Willst du die Abwesenheit wirklich löschen?

            #WORKAROUND!
            # Extract the href attribute from the delete menu item to get the URL for deletion
            ${UrlDeleteRow}=    Get Attribute    ${menItemDelete}    href
            Log    URL for deletion: ${UrlDeleteRow}
            Go To    ${UrlDeleteRow}

            ${RowDeleted}=    Set Variable    ${True}
            Log    ${RowDeleted}
            Exit For Loop
        END
    END

    IF    ${RowDeleted} == ${True}
        Log    Row successfully deleted!
    ELSE
        Fail    Row to delete was not found!
    END

    #Fail    For testing purposes!