*** Settings ***
Library    AppiumLibrary
Library    Browser
Library    ExcelLibrary
Library    String
Resource    ../../Resources/Framework/fwApplicationUnderTest.resource
Resource    ../../Resources/Framework/fwVariables.resource
Resource    ../../Resources/Framework/fwControls.resource

*** Variables ***
${DialogDir}    Data\\Dialogs\\
${DialogRecordFound}

*** Keywords ***
DialogExecution
    [Arguments]    ${Dialog}    ${DialogRecord}
    InitializeDialogData        ${Dialog}
    CheckIfDialogExists
    InitializeDialogExecution    ${Dialog}    ${DialogRecord}
    Set Test Variable    ${DialogRecordFound}    ${False}    
    FOR    ${row_index}     IN RANGE     4    ${DialogRowCount} + 1
        ${theDialogRecord}    Read Excel Cell    ${row_index}    1
        Log    ${theDialogRecord}
        IF    $DialogRecord == $theDialogRecord
            Set Test Variable    ${DialogRecordFound}    ${True}
            DialogRowProcessing    ${row_index}    #${DialogColumnCount}
            Exit For Loop
        END
    END

    IF    ${DialogRecordFound} == ${False}
        DialogBaseProcessing    ${Dialog}    ${DialogRecord}
    END
    
    Should Be True    ${DialogRecordFound}    Fatal Error: Dialog record not found!

    Switch Current Excel Document    actualDialog
    Close Current Excel Document

InitializeDialogData
    [Arguments]    ${Dialog}
    ${FullDialogInheritanceFilePath}=    catenate    SEPARATOR=    ${DialogDir}    DialogInheritance.xlsx
    Open Excel Document	filename=${FullDialogInheritanceFilePath}    doc_id=DialogInheritance

    ${DialogInheritanceFirstColumn}=    Read Excel Column    0    0
    ${DialogInheritanceRowCount}=    Get Length    ${DialogInheritanceFirstColumn}
    
    FOR    ${row_index}     IN RANGE     2    ${DialogInheritanceRowCount} + 1
        ${theDialogInheritanceRecord}    Read Excel Cell    ${row_index}    1
        Log    ${theDialogInheritanceRecord}
        IF    $Dialog == $theDialogInheritanceRecord
            Set Test Variable    ${theDialog}    ${Dialog}
            ${tempBaseDialog}=    Read Excel Cell    ${row_index}    2
            Set Test Variable    ${theBaseDialog}    ${tempBaseDialog}
            ${tempDialogTitle}=    Read Excel Cell    ${row_index}    3
            Set Test Variable    ${theDialogTitle}    ${tempDialogTitle}

            #maybe not relevant?
            ${tempDialogSelector}=    Read Excel Cell    ${row_index}    4
            Set Test Variable    ${theDialogSelector}    ${tempDialogSelector}
            Exit For Loop
        END    
    END

    Close Current Excel Document

CheckIfDialogExists
    IF    '${theDialogTitle}' == 'Mein Profil | TT-Planer'
        #ToDo: checken ob es einer von 3 möglichen Titeln ist in Abhängigkeit von der gewählten Notebookseite
        RETURN
    END
    ${actualAUT}=    GetVariableValue    AUT
    IF    $actualAUT == 'Chromium'
        Get Title    ==    ${theDialogTitle}    Dialog not found!
        RETURN
    END
    IF    $actualAUT == 'Pixel9Pro_API35'
        Wait Until Element Text Is Correct    5    //android.webkit.WebView    ${theDialogTitle}    1s

        #${mobileWindowTitle}=    Get Element Attribute    //android.webkit.WebView    text
        #${mobileWindowTitle}=    Get Window Title
        #IF    $mobileWindowTitle == $theDialogTitle
        #    Log    Dialog found!
        #ELSE
        #    Fail    Dialog not found!
        #END
        #RETURN
    END

Wait Until Element Text Is Correct
    [Arguments]        ${RETRY_COUNT}    ${Selector}    ${EXPECTED_TEXT}    ${WAIT_INTERVAL}
    ${count}=    Convert To Number    0
    FOR    ${index}    IN RANGE    ${RETRY_COUNT}
        #Wait Until Element Is Visible    ${Selector}
        TRY
            Wait Until Element Is Visible    ${Selector}
            ${actual_text}=    Get Element Attribute    ${Selector}    text
            IF    $actual_text == $EXPECTED_TEXT
                Log    Dialog found with title ${actual_text}
                RETURN
            END
        EXCEPT
            Log    Failed to get text of android.webkit.WebView
        END
        Sleep    ${WAIT_INTERVAL}
        ${count}=    Evaluate    ${count} + 1
    END
    Fail    Dialog not found within ${RETRY_COUNT} retries!


DialogBaseProcessing
    [Arguments]    ${Dialog}    ${DialogRecord}
    Close Current Excel Document
    IF    ${{$theBaseDialog is not None}}
        InitializeDialogExecution    ${theBaseDialog}    ${DialogRecord}
        FOR    ${row_index}     IN RANGE     4    ${DialogRowCount} + 1
            ${theDialogRecord}    Read Excel Cell    ${row_index}    1
            Log    ${theDialogRecord}
            IF    $DialogRecord == $theDialogRecord
                Set Test Variable    ${DialogRecordFound}    ${True}
                DialogRowProcessing    ${row_index}    #${DialogColumnCount}
                Exit For Loop
            END
        END
    END

InitializeDialogExecution
    [Arguments]    ${Dialog}    ${DialogRecord}
    ${FullDialogFilePath}=    catenate    SEPARATOR=    ${DialogDir}    ${Dialog}    .xlsx
    #Log    ${FullFlowFilePath}

    Open Excel Document	filename=${FullDialogFilePath}    doc_id=actualDialog
    #${sheets}=	Get List Sheet Names
    #${Sheet}=    Get Sheet

    ${tmpDialogFirstRow}=    Read Excel Row    0    0
    Set Test Variable    ${DialogFirstRow}    ${tmpDialogFirstRow}
    ${tmpDialogColumnCount}=    Get Length    ${DialogFirstRow}
    Set Test Variable    ${DialogColumnCount}    ${tmpDialogColumnCount}
    ${tmpDialogFirstColumn}=    Read Excel Column    0    0
    Set Test Variable    ${DialogFirstColumn}    ${tmpDialogFirstColumn}
    ${tmpDialogRowCount}=    Get Length    ${DialogFirstColumn}
    Set Test Variable    ${DialogRowCount}    ${tmpDialogRowCount}
    
    ${tmpSelectorRowIndex}=    Get selector row index
    Set Test Variable    ${SelectorRowIndex}    ${tmpSelectorRowIndex}
    #ReportDialogContent    ${Sheet}
    #Set Test Variable    ${DialogRecordFound}    ${False}

DialogRowProcessing
    [Arguments]    ${row_index}    #${DialogColumnCount}
    Log    ${row_index}
    ${theDialogRow}    Read Excel Row    ${row_index}    #0    1
    Get Length    ${theDialogRow}
    #Log    ${theDialogRow}
    #Log    Record found!
    #Set Test Variable    ${DialogRecordFound}    ${True}

    FOR    ${col_index}    IN RANGE    3    ${DialogColumnCount}
       Log    ${col_index}
       ${theControlHeader}      Read Excel Cell       3    ${col_index}
       ${theControlSelector}    Read Excel Cell    ${SelectorRowIndex}    ${col_index}
       ${theControlModus}    Read Excel Cell    ${row_index}    2
       ${theControlValue}    Read Excel Cell    ${row_index}    ${col_index}
       
       Convert To String    ${theControlModus}
       Convert To String    ${theControlValue}
       
       #Log    ${theRow}[${col_index}]

       IF    ${{$theControlValue is not None}}
#           Log Many    ToDoProcessControls
#           ...    Modus=${theControlModus}
#           ...    Header=${theControlHeader}
#           ...    Selector=${theControlSelector}
#           ...    Value=${theControlValue}
            ControlProcessing    ${theDialog}    ${theControlModus}    ${theControlHeader}    ${theControlSelector}    ${theControlValue}
            Switch Current Excel Document    actualDialog
       ELSE
           Log    No control value found!
       END
    END

    ${Action}    Read Excel Cell    ${row_index}    ${DialogColumnCount}