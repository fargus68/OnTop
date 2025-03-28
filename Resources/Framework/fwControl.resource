*** Settings ***
Library    String
Resource    ../../Resources/Controls/Button.resource
Resource    ../../Resources/Controls/Calendar.resource
Resource    ../../Resources/Controls/Checkbox.resource
Resource    ../../Resources/Controls/Groupbox.resource
Resource    ../../Resources/Controls/Icon.resource
Resource    ../../Resources/Controls/Label.resource
Resource    ../../Resources/Controls/Link.resource
Resource    ../../Resources/Controls/Menu.resource
Resource    ../../Resources/Controls/MultiLineTextbox.resource
Resource    ../../Resources/Controls/MultiSelectDropdown.resource
Resource    ../../Resources/Controls/NumericUpDown.resource
Resource    ../../Resources/Controls/Page.resource
Resource    ../../Resources/Controls/Password.resource
Resource    ../../Resources/Controls/Radiobutton.resource
Resource    ../../Resources/Controls/SelectDropdown.resource
Resource    ../../Resources/Controls/Table.resource
Resource    ../../Resources/Controls/Textbox.resource
Resource    ../../Resources/Controls/UnorderedList.resource

*** Keywords ***
ControlProcessing
    [Arguments]    ${Container}    ${Modus}    ${Name}    ${Selector}    ${Value}

    ${ControlPrefix}=    Get Substring    ${Name}    0    3
    IF  '${ControlPrefix}' == 'but'
        ButtonProcessing    ${Container}    ${Modus}    ${Name}    ${Selector}    ${Value}
    ELSE IF  '${ControlPrefix}' == 'cal'
        CalendarProcessing    ${Container}    ${Modus}    ${Name}    ${Selector}    ${Value}
    ELSE IF  '${ControlPrefix}' == 'chk'
        CheckboxProcessing    ${Container}    ${Modus}    ${Name}    ${Selector}    ${Value}
    ELSE IF  '${ControlPrefix}' == 'grp'
        GroupboxProcessing    ${Container}    ${Modus}    ${Name}    ${Selector}    ${Value}
    ELSE IF  '${ControlPrefix}' == 'ico'
        IconProcessing    ${Container}    ${Modus}    ${Name}    ${Selector}    ${Value}
    ELSE IF  '${ControlPrefix}' == 'lab'
        LabelProcessing    ${Container}    ${Modus}    ${Name}    ${Selector}    ${Value}
    ELSE IF  '${ControlPrefix}' == 'lnk'
        LinkProcessing    ${Container}    ${Modus}    ${Name}    ${Selector}    ${Value}
    ELSE IF  '${ControlPrefix}' == 'men'
        MenuProcessing    ${Container}    ${Modus}    ${Name}    ${Selector}    ${Value}
    ELSE IF  '${ControlPrefix}' == 'mlt'
        MultiLineTextboxProcessing    ${Container}    ${Modus}    ${Name}    ${Selector}    ${Value}
    ELSE IF  '${ControlPrefix}' == 'msd'
        MultiSelectDropdownProcessing    ${Container}    ${Modus}    ${Name}    ${Selector}    ${Value}
    ELSE IF  '${ControlPrefix}' == 'nud'
        NumericUpDownProcessing    ${Container}    ${Modus}    ${Name}    ${Selector}    ${Value}
    ELSE IF  '${ControlPrefix}' == 'pag'
        PageProcessing    ${Container}    ${Modus}    ${Name}    ${Selector}    ${Value}
    ELSE IF  '${ControlPrefix}' == 'pwd'
        PasswordProcessing    ${Container}    ${Modus}    ${Name}    ${Selector}    ${Value}
    ELSE IF  '${ControlPrefix}' == 'rad'
        RadiobuttonProcessing    ${Container}    ${Modus}    ${Name}    ${Selector}    ${Value}
    ELSE IF  '${ControlPrefix}' == 'sel'
        SelectDropdownProcessing    ${Container}    ${Modus}    ${Name}    ${Selector}    ${Value}
    ELSE IF  '${ControlPrefix}' == 'tab'
        TableProcessing    ${Container}    ${Modus}    ${Name}    ${Selector}    ${Value}
    ELSE IF  '${ControlPrefix}' == 'txt'
        TextboxProcessing    ${Container}    ${Modus}    ${Name}    ${Selector}    ${Value}
    ELSE IF  '${ControlPrefix}' == 'uli'
        UnorderedListProcessing    ${Container}    ${Modus}    ${Name}    ${Selector}    ${Value}
    ELSE
        Log    not defined yet ...
    END