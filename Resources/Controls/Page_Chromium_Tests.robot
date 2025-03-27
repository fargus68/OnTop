*** Settings ***
Resource    ../../Resources/Controls/Page_Chromium.resource

*** Test Cases ***
Via_Chromium_Set_SelectPageInsurantData
  ${NewSelector}=    Get VIA Page Selector    //*[@id="insurance-form"]/div/section[2]
