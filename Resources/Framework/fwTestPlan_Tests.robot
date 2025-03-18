*** Settings ***
Resource    ../../Resources/Framework/fwTestPlan.resource

*** Variables ***
${TestPlan}    Config1

*** Test Cases ***
001_TestPlan_NotFound
    TestPlanExecution    TestPlanDoesNotExist