*** Settings ***
Library    ExcelLibrary
Library    String
Resource    ../../Resources/Framework/fwVariables.resource
Resource    ../../Resources/Controls/Button.resource
Resource    ../../Resources/Controls/Icon.resource
Resource    ../../Resources/Controls/Link.resource
Resource    ../../Resources/Controls/Password.resource
Resource    ../../Resources/Controls/Textbox.resource
Resource    ../../Resources/Controls/UnorderedList.resource

*** Variables ***
${DialogDir}    Data\\Dialogs\\
${DialogRecordFound}

*** Keywords ***
DialogExecution
    [Arguments]    ${Dialog}    ${DialogRecord}
    InitializeDialogData        ${Dialog}
    CheckIfDialogExists    ${Dialog}
    InitializeDialogExecution    ${Dialog}    ${DialogRecord}
    Set Test Variable    ${DialogRecordFound}    ${False}    
    FOR    ${row_index}     IN RANGE     3    ${DialogRowCount} + 1
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
            ${tempBaseDialog}=    Read Excel Cell    ${row_index}    2
            Set Test Variable    ${theBaseDialog}    ${tempBaseDialog}
            ${tempDialogSelector}=    Read Excel Cell    ${row_index}    3
            Set Test Variable    ${theDialogSelector}    ${tempDialogSelector}
            ${tempDialogTitle}=    Read Excel Cell    ${row_index}    4
            Set Test Variable    ${theDialogTitle}    ${tempDialogTitle}

            Exit For Loop
        END    
    END

    Close Current Excel Document

CheckIfDialogExists
    [Arguments]    ${Dialog}
    Get Title    ==    ${theDialogTitle}    Dialog not found!

Old_DialogBaseProcessing
    [Arguments]    ${Dialog}    ${DialogRecord}
    Close Current Excel Document
    ${FullDialogInheritanceFilePath}=    catenate    SEPARATOR=    ${DialogDir}    DialogInheritance.xlsx
    Open Excel Document	filename=${FullDialogInheritanceFilePath}    doc_id=DialogInheritance

    #${tmpDialogFirstRow}=    Read Excel Row    0    0
    #Set Test Variable    ${DialogFirstRow}    ${tmpDialogFirstRow}
    #${tmpDialogColumnCount}=    Get Length    ${DialogFirstRow}
    #Set Test Variable    ${DialogColumnCount}    ${tmpDialogColumnCount}
    
    ${DialogInheritanceFirstColumn}=    Read Excel Column    0    0
    ${DialogInheritanceRowCount}=    Get Length    ${DialogInheritanceFirstColumn}
    
    FOR    ${row_index}     IN RANGE     2    ${DialogInheritanceRowCount} + 1
        ${theDialogInheritanceRecord}    Read Excel Cell    ${row_index}    1
        Log    ${theDialogInheritanceRecord}
        IF    $Dialog == $theDialogInheritanceRecord
            ${theBaseDialog}=    Read Excel Cell    ${row_index}    2
            IF    ${{$theBaseDialog is not None}}
                InitializeDialogExecution    ${theBaseDialog}    ${DialogRecord}
                FOR    ${row_index}     IN RANGE     3    ${DialogRowCount} + 1
                    ${theDialogRecord}    Read Excel Cell    ${row_index}    1
                    Log    ${theDialogRecord}
                    IF    $DialogRecord == $theDialogRecord
                        Set Test Variable    ${DialogRecordFound}    ${True}
                        DialogRowProcessing    ${row_index}    #${DialogColumnCount}
                        Exit For Loop
                    END
                END
            END
            Exit For Loop
        END
    END    

DialogBaseProcessing
    [Arguments]    ${Dialog}    ${DialogRecord}
    Close Current Excel Document
    IF    ${{$theBaseDialog is not None}}
        InitializeDialogExecution    ${theBaseDialog}    ${DialogRecord}
        FOR    ${row_index}     IN RANGE     3    ${DialogRowCount} + 1
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
       ${theControlHeader}      Read Excel Cell       1    ${col_index}
       ${theControlSelector}    Read Excel Cell    2    ${col_index}
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
            ControlProcessing    ${theControlModus}    ${theControlHeader}    ${theControlSelector}    ${theControlValue}
       ELSE
           Log    No control value found!
       END
    END

    ${Action}    Read Excel Cell    ${row_index}    ${DialogColumnCount}
    
    
ControlProcessing
    [Arguments]    ${Modus}    ${Name}    ${Selector}    ${Value}
    ${ControlPrefix}=    Get Substring    ${Name}    0    3
    IF  '${ControlPrefix}' == 'txt'
        #Log    Textbox
        TextboxProcessing    ${Modus}    ${Name}    ${Selector}    ${Value}        
    ELSE IF  '${ControlPrefix}' == 'pwd'
        #Log    Password
        PasswordProcessing    ${Modus}    ${Name}    ${Selector}    ${Value}
    ELSE IF  '${ControlPrefix}' == 'but'
        #Log    Button
        ButtonProcessing    ${Modus}    ${Name}    ${Selector}    ${Value}
    ELSE IF  '${ControlPrefix}' == 'lnk'
        LinkProcessing    ${Modus}    ${Name}    ${Selector}    ${Value}
    ELSE IF  '${ControlPrefix}' == 'ico'
        #Log    Icon
        IconProcessing    ${Modus}    ${Name}    ${Selector}    ${Value}
    ELSE IF  '${ControlPrefix}' == 'uli'
        #Log    UnorderedList
        UnorderedListProcessing    ${Modus}    ${Name}    ${Selector}    ${Value}
    ELSE
        Log    not defined yet ...
    END