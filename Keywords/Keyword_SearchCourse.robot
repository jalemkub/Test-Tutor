*** Settings ***
Library    SeleniumLibrary
Library    ExcelLibrary
Library    pyautogui

Resource  ../Variables/Variable_SearchCourse.robot
Resource  ../Keywords/Keyword_SearchCourse.robot
*** Keywords ***
Open Excel
    [Arguments]  ${DataTableSearchCourse}  ${Sheet}
    Run Keyword And Continue On Failure  Open Excel Document  ${DataTableSearchCourse}  ${Sheet}

Open Browser WebSite
    Open Browser  ${URL}  ${BROWSER}  options=add_experimental_option('detach',True)
    Maximize Browser Window
    Wait Until Page Contains Element  ${locSearch}  timeout=10s

Fill Search Form
    [Arguments]  ${Search}
    Wait Until Element Is Visible  ${locSearch}  timeout=5s
    Run Keyword And Ignore Error  Clear Element Text  ${locSearch}
    Run Keyword If  '${Search}' != '' and '${Search}' != '${None}'  Input Text  ${locSearch}  ${Search}

Submit Search Form
    Wait Until Element Is Visible  ${clickSearchCourse}  timeout=5s
    Click Button  ${clickSearchCourse}

Read Expected Result From Excel Search Course
    [Arguments]  ${row}
    ${Expected}  Read Excel Cell  ${row}  4
    [Return]  ${Expected}

Get Validation Message Search Course
    [Arguments]  ${Search}
    ${ActualValidation}  Set Variable  ${None}
    ${ActualGetText}  Set Variable  ${None}
    IF  '${Search}' == '' or '${Search}' == '${None}'
        Wait Until Element Is Visible  ${locSearch}  timeout=5s
        ${status}  ${ActualValidation}  Run Keyword And Ignore Error  Get Element Attribute  ${locSearch}  validationMessage
        ${ActualValidation}  Set Variable If  '${status}' == 'PASS'  ${ActualValidation}  ${None}
        Log To Console  Validation Message: ${ActualValidation}, Status: ${status}
    ELSE
        Wait Until Element Is Visible  ${locGetText}  timeout=5s
        ${status}  ${ActualGetText}  Run Keyword And Ignore Error  Get Text  ${locGetText}
        ${ActualGetText}  Set Variable If  '${status}' == 'PASS'  ${ActualGetText}  ${None}
        Log To Console  Search Result Text: ${ActualGetText}, Status: ${status}
    END
    [Return]  ${ActualValidation}  ${ActualGetText}

Write Actual Result To Excel
    [Arguments]  ${row}  ${Expected}  ${ActualValidation}  ${ActualGetText}
    IF  '${ActualGetText}' != '${None}' and '${ActualGetText}' != ''
        Write Excel Cell  ${row}  5  ${ActualGetText}
    ELSE
        Write Excel Cell  ${row}  5  ${ActualValidation}
    END

Verify Equal Result Search Course
    [Arguments]  ${row}  ${Expected}  ${ActualValidation}  ${ActualGetText}
    IF  '${ActualGetText}' != '${None}' and '${ActualGetText}' != '' and '${Expected}' == '${ActualGetText}'
        Write Excel Cell  ${row}  6  PASS
    ELSE IF  '${ActualValidation}' != '${None}' and '${ActualValidation}' != '' and '${Expected}' == '${ActualValidation}'
        Write Excel Cell  ${row}  6  PASS
    ELSE
        Write Excel Cell  ${row}  6  Failed
        ${screenshotFailed}  Set Variable  ${screenshot}failed_row_${row}.png
        Run Keyword And Ignore Error  Capture Page Screenshot  ${screenshotFailed}
    END

Save Excel Search Course
    Save Excel Document  ${DataSearchCourse}

Close Excel Current Document
    Close Current Excel Document

Close WebSite Browser
    Close Browser