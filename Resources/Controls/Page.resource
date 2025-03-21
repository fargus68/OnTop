*** Settings ***
Library    String
Library    Browser
Library    ../../Libraries/HTMLClasses.py
Resource    ../../Resources/Framework/fwControl.resource
Resource    ../../Resources/Framework/fwApplicationUnderTest.resource

*** Variables ***
${PageDir}    Data\\Pages\\

*** Keywords ***
PageProcessing
    [Arguments]    ${Container}    ${Modus}    ${Name}    ${Selector}    ${Value}

    ${actualAUT}=    GetVariableValue    AUT
    ${controlResourceName}=    Catenate    SEPARATOR=    C:/Users/matth/PycharmProjects/OnTop/Resources/Controls/Page_    ${actualAUT}    .resource
    Import Resource    ${controlResourceName}

    Set Test Variable    ${theContainer}    ${Container}    
    Set Test Variable    ${thePage}    ${Name}
    Set Test Variable    ${theModus}    ${Modus}

    IF  '${Modus}' == '<GET>'
        PageProcessingGet    ${Modus}    ${Name}    ${Selector}    ${Value}
    ELSE IF  '${Modus}' == '<CHK>'
        PageProcessingChk    ${Modus}    ${Name}    ${Selector}    ${Value}
    ELSE IF  '${Modus}' == '<SET>'
        PageProcessingSet    ${Modus}    ${Name}    ${Selector}    ${Value}
    ELSE
        Fatal Error    Modus not defined
    END

PageProcessingGet
    [Arguments]    ${Modus}    ${Name}    ${Selector}    ${Value}
    Log        PageProcessingGet
    ${FirstLetterOfValue}=    Get Substring    ${Value}    0    1
    IF  '${FirstLetterOfValue}' == 'X'
        ${PageContent}=    Page specific get text    ${Selector}
        IF    '${PageContent}' == ''
            Log    Page content = <EMPTY>
        ELSE
            Log    Page content = '${PageContent}'
        END
    ELSE IF  '${FirstLetterOfValue}' == '<'
        Log    To be defined
    ELSE
        #ToDo Record names beginning with X doesn't work correctly
        PageExecution    ${Modus}    ${Name}    ${Selector}    ${Value}
    END

PageProcessingChk
    [Arguments]    ${Modus}    ${Name}    ${Selector}    ${Value}
    #Log        PageProcessingChk
    IF    '${Value}' == '<SELECTED>'
        #${list_of_classes}=    Get Classes    ${Selector}
        ${list_of_classes}=    Page specific get classes    ${Selector}
        ${class_name}=    Convert To String    active
        ${found}=    check_if_element_contains_class    ${list_of_classes}    ${class_name}
        IF    ${found}
            Log    Page tab selected as expected!
        ELSE
            Fail    Page tab not selected, but expected to be selected!!!
        END
        RETURN
    END
    IF    '${Value}' == '<NOTSELECTED>'
        #${list_of_classes}=    Get Classes    ${Selector}
        ${list_of_classes}=    Page specific get classes    ${Selector}
        ${class_name}=    Convert To String    active
        ${found}=    check_if_element_contains_class    ${list_of_classes}    ${class_name}
        IF    ${found}
            Fail    Page tab selected, but expected to be not selected!!!
        ELSE
            Log    Page tab not selected as expected!
        END
        RETURN
    END
    PageExecution    ${Modus}    ${Name}    ${Selector}    ${Value}

PageProcessingSet
    [Arguments]    ${Modus}    ${Name}    ${Selector}    ${Value}
    #Log        PageProcessingSet
    IF    '${Value}' == '<SELECT>'
        Page specific click    ${Selector}
    ELSE
        PageExecution    ${Modus}    ${Name}    ${Selector}    ${Value}
    END

PageExecution
    [Arguments]    ${Modus}    ${PageName}    ${PageSelector}    ${PageRecord}
    InitializePageData        ${PageName}
    #CheckIfDialogExists
    InitializePageExecution    ${PageName}    ${PageRecord}
    Set Test Variable    ${PageRecordFound}    ${False}    
    FOR    ${row_index}     IN RANGE     4    ${PageRowCount} + 1
        ${thePageRecord}    Read Excel Cell    ${row_index}    1
        Log    ${thePageRecord}
        IF    $PageRecord == $thePageRecord
            Set Test Variable    ${PageRecordFound}    ${True}
            PageRowProcessing    ${row_index}    #${PageColumnCount}
            Exit For Loop
        END
    END

    IF    ${PageRecordFound} == ${False}
        PageBaseProcessing    ${PageName}    ${PageRecord}
    END    

    Should Be True    ${PageRecordFound}    Fatal Error: Page record not found!

    Close Current Excel Document

InitializePageData
    [Arguments]    ${Page}
    ${FullPageInheritanceFilePath}=    catenate    SEPARATOR=    ${PageDir}    PageInheritance.xlsx
    Open Excel Document	filename=${FullPageInheritanceFilePath}    doc_id=PageInheritance

    ${FullPageName}=    catenate    SEPARATOR=    ${theContainer}    _    ${Page}
    Log    ${FullPageName}

    ${PageInheritanceFirstColumn}=    Read Excel Column    0    0
    ${PageInheritanceRowCount}=    Get Length    ${PageInheritanceFirstColumn}
    
    FOR    ${row_index}     IN RANGE     2    ${PageInheritanceRowCount} + 1
        ${thePageInheritanceRecord}    Read Excel Cell    ${row_index}    1
        Log    ${thePageInheritanceRecord}
        IF    $FullPageName == $thePageInheritanceRecord
            Set Test Variable    ${theFullPageName}    ${FullPageName}
            ${tempBasePage}=    Read Excel Cell    ${row_index}    2
            Set Test Variable    ${theBasePage}    ${tempBasePage}
            ${tempPageTitle}=    Read Excel Cell    ${row_index}    3
            Set Test Variable    ${thePageTitle}    ${tempPageTitle}
            #maybe not relevant?
            ${tempPageSelector}=    Read Excel Cell    ${row_index}    4
            Set Test Variable    ${thePageSelector}    ${tempPageSelector}
            Exit For Loop
        END    
    END

    Close Current Excel Document

InitializePageExecution
    [Arguments]    ${Page}    ${PageRecord}
    #${FullPageFilePath}=    catenate    SEPARATOR=    ${PageDir}    ${theContainer}    _    ${Page}    .xlsx
    ${FullPageFilePath}=    catenate    SEPARATOR=    ${PageDir}    ${theFullPageName}    .xlsx
    Log    ${FullPageFilePath}

    Open Excel Document	filename=${FullPageFilePath}    doc_id=actualPage
    #${sheets}=	Get List Sheet Names
    #${Sheet}=    Get Sheet

    ${tmpPageFirstRow}=    Read Excel Row    0    0
    Set Test Variable    ${PageFirstRow}    ${tmpPageFirstRow}
    ${tmpPageColumnCount}=    Get Length    ${PageFirstRow}
    Set Test Variable    ${PageColumnCount}    ${tmpPageColumnCount}
    ${tmpPageFirstColumn}=    Read Excel Column    0    0
    Set Test Variable    ${PageFirstColumn}    ${tmpPageFirstColumn}
    ${tmpPageRowCount}=    Get Length    ${PageFirstColumn}
    Set Test Variable    ${PageRowCount}    ${tmpPageRowCount}

    ${tmpSelectorRowIndex}=    Get selector row index
    Set Test Variable    ${SelectorRowIndex}    ${tmpSelectorRowIndex}
    #ReportDialogContent    ${Sheet}
    #Set Test Variable    ${PageRecordFound}    ${False}

PageBaseProcessing
    [Arguments]    ${Page}    ${PageRecord}
    Close Current Excel Document
    IF    ${{$theBasePage is not None}}
        Set Test Variable    ${theFullPageName}    ${theBasePage}
        InitializePageExecution    ${theBasePage}    ${PageRecord}
        FOR    ${row_index}     IN RANGE     4    ${PageRowCount} + 1
            ${thePageRecord}    Read Excel Cell    ${row_index}    1
            Log    ${thePageRecord}
            IF    $PageRecord == $thePageRecord
                Set Test Variable    ${PageRecordFound}    ${True}
                PageRowProcessing    ${row_index}
                Exit For Loop
            END
        END
    END

PageRowProcessing
    [Arguments]    ${row_index}    #${PageColumnCount}
    Log    ${row_index}
    ${thePageRow}    Read Excel Row    ${row_index}    #0    1
    Get Length    ${thePageRow}
    #Log    ${thePageRow}
    #Log    Record found!
    #Set Test Variable    ${PageRecordFound}    ${True}

    #original page name necessary
    ${newContainername}=    catenate    SEPARATOR=    ${theContainer}    _    ${thePage}

    FOR    ${col_index}    IN RANGE    2    ${PageColumnCount}+1
       Log    ${col_index}
       ${theControlHeader}      Read Excel Cell       3    ${col_index}
       ${theControlSelector}    Read Excel Cell    ${SelectorRowIndex}    ${col_index}
       #${theControlModus}    Read Excel Cell    ${row_index}    2
       ${theControlValue}    Read Excel Cell    ${row_index}    ${col_index}
       
       #Convert To String    ${theControlModus}
       Convert To String    ${theControlValue}
       
       #Log    ${theRow}[${col_index}]

       IF    ${{$theControlValue is not None}}
#           Log Many    ToDoProcessControls
#           ...    Modus=${theControlModus}
#           ...    Header=${theControlHeader}
#           ...    Selector=${theControlSelector}
#           ...    Value=${theControlValue}
            ControlProcessing    ${newContainername}    ${theModus}    ${theControlHeader}    ${theControlSelector}    ${theControlValue}
       ELSE
           Log    No control value found!
       END
    END