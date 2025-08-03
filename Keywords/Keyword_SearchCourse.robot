*** Settings ***
Library    SeleniumLibrary
Library    ExcelLibrary

Resource  ../Variables/Variable_SearchCourse.robot
Resource  ../Keywords/Keyword_SearchCourse.robot
*** Keywords ***
Open Excel
    [Arguments]  ${DataTableSearchCourse}  ${Sheet}
    Run Keyword And Continue On Failure  Open Excel Document  ${DataTableSearchCourse}  ${Sheet}

Open Browser WebSite
    Open Browser  ${URL}  ${BROWSER}  options=add_experimental_option('detach',True)
    Set Selenium Speed    0.1s
    Maximize Browser Window
    Wait Until Page Contains Element  ${locSearch}  timeout=10s

Fill Search Form
    [Arguments]  ${Search}
    Run Keyword If  '${Search}' != '' and '${Search}' != '${None}'  Input Text  ${locSearch}  ${Search}

Submit Search Form
    Wait Until Element Is Visible  ${clickSearchCourse}  timeout=5s
    Click Button  ${clickSearchCourse}


# Read Expected Result From Excel Search Course
#     [Arguments]  ${row}
#     ${Expected}  Read Excel Cell  ${row}  4
#     RETURN  ${Expected}

Alert Message and Get Text
    [Arguments]    ${row}

    ${alert_status}    Run Keyword And Ignore Error    Handle Alert    accept    2s
    ${alert_message}    Set Variable If    '${alert_status[0]}' == 'PASS'    ${alert_status[1]}    ${EMPTY}


    Run Keyword If    '${alert_message}' != ''    Write Excel Cell    ${row}    5    ${alert_message}


    IF    '${alert_message}' == ''

        Wait Until Element Is Visible    ${locGetText}    timeout=5s

        ${text_show}    Run Keyword And Ignore Error    Get Text    ${locGetText}
        ${text_message}    Set Variable If    '${text_show[0]}' == 'PASS'    ${text_show[1]}    ${EMPTY}

        Write Excel Cell    ${row}    5    ${text_message}
    END

    ${expected}    Read Excel Cell    ${row}    4
    ${actualresult}    Read Excel Cell    ${row}    5

    ${flag}    Run Keyword And Return Status    Should Be Equal    ${actualresult}    ${expected}

    IF    ${flag}
        Write Excel Cell    ${row}    6    Pass
    ELSE
        Write Excel Cell    ${row}    6    Failed
        ${screenshotFailed}    Set Variable    ${screenshot}failed_row_${row}.png
        Run Keyword And Ignore Error    Capture Page Screenshot   ${screenshotFailed}
    END

        ${revise_pass}    Run Keyword And Return Status    Should Match Regexp    ${actualresult}    (?i).*การค้นหา.*|.*แสดง.*|.*ค้นหา.*|.*สำเร็จ.*

    IF    ${revise_pass}
    Write Excel Cell    ${row}    7    Pass
    ELSE
    Write Excel Cell    ${row}    7    Fail
    END



Save Excel Search Course
    Save Excel Document  ${DataSearchCourse}

Close Excel Current Document
    Close Current Excel Document

Close WebSite Browser
    Close Browser
