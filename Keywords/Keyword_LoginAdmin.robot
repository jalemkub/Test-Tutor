*** Settings ***
Library    SeleniumLibrary
Library    ExcelLibrary

Resource    ../Variables/Variable_LoginAdmin.robot
Resource    Keyword_SearchCourse.robot
*** Keywords ***


Open Page Browser
    Open Browser  ${URL}  ${BROWSER}  options=add_experimental_option('detach',True)
    Set Selenium Speed    0.1s
    Maximize Browser Window
    Wait Until Page Contains Element  ${link_tologin}  timeout=10s

GO to page Login
    Click Element  ${link_tologin}

Fill Form Login
    [Arguments]  ${email}  ${Password}
    Run Keyword If  '${email}' != '' and '${email}' != '${None}'  Input Text  ${Loc_EmailAM}  ${email}
    Run Keyword If  '${Password}' != '' and '${Password}' != '${None}'  Input Text  ${Loc_PasswordAM}  ${Password}

Submit Login
    Click Element  ${Btn_submit}
    Wait Until Page Contains Element  ${Btn_submit}  timeout=5s



Read Expected Result Login
    [Arguments]  ${row}
    ${Expected}  Read Excel Cell  ${row}  5
    RETURN  ${Expected}

Alert Login 
    [Arguments]  ${row}  ${Expected}
    ${alert_status}=  Run Keyword And Ignore Error    Handle Alert  accept
    ${alert_message}=  Set Variable If    '${alert_status[0]}' == 'PASS'    ${alert_status[1]}    ${EMPTY}

    Run Keyword If    '${alert_message}' != ''    Write Excel Cell    ${row}    6    ${alert_message}


    IF    '${alert_message}' == ''

        Wait Until Element Is Visible    ${TXtError}    timeout=5s


        ${expected}    Read Excel Cell    ${row}    5
        ${actualresult}    Read Excel Cell    ${row}    6

        ${text_show}    Run Keyword And Ignore Error    Get Text    ${TXtError}
        ${text_message}    Set Variable If    '${text_show[0]}' == 'PASS'    ${text_show[1]}    ${EMPTY}

        Write Excel Cell    ${row}    6    ${text_message}
    END

Verify Equal Result RegisterStudent
    [Arguments]  ${row}  ${expected}  ${actualresult}

    ${flag}=  Run Keyword And Return Status  Should Contain  ${actualresult}  ${expected}
    Log To Console    Expected: ${expected}

    IF    ${flag}
        Write Excel Cell    ${row}    7    Pass
        Write Excel Cell    ${row}    8    Pass
    ELSE
        Write Excel Cell    ${row}    7    Failed
        Write Excel Cell    ${row}    8    Pass
        ${screenshotFailed}=    Set Variable    ${EXECDIR}/screenshot/failed_row_${row}.png
        Run Keyword And Ignore Error    Capture Page Screenshot    ${screenshotFailed}
    END



Save Excel Login
    Save Excel Document  ${DataTableRegisterStudent}


Close Excel Login
    Close Excel Current Document

Close Browser Login
    Close Browser