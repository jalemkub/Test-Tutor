*** Settings ***
Library    SeleniumLibrary
Library    ExcelLibrary

Resource    ../Variables/Variable_LoginAdmin.robot
*** Keywords ***
Open Excel file
    Open Excel Document  ${DataTableLoginAdmin}    ${Sheet}

Open Page Browser
    Open Browser  ${URL}  ${BROWSER}  options=add_experimental_option('detach',True)
    Set Selenium Speed    0.3s
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



Read Expected Result Login
    [Arguments]  ${row}
    ${Expected}  Read Excel Cell  ${row}  5
    RETURN  ${Expected}

Check Alert
    [Arguments]  ${row}
    # พยายามกด Alert และดึงข้อความ
    ${status}  Run Keyword And Ignore Error  Handle Alert   ACCEPT
    ${alert_text}    Set Variable If    '${status[0]}' == 'PASS'    ${status[1]}    ${EMPTY}
    Run Keyword If    '${alert_text}' != ''    Write Excel Cell    ${row}    6    ${alert_text}
    Run Keyword And Ignore Error  Write Excel Cell    ${row}    6    ${alert_text}
    Log To Console    ALERT: ${alert_text}
    RETURN    ${alert_text}


Check Error
    [Arguments]  ${row}
    # ตรวจสอบข้อความ Error บนหน้า
    ${status1}  Run Keyword And Ignore Error  Get Text  ${Errorform}
    ${error_message}    Set Variable If    '${status1[0]}' == 'PASS'    ${status1[1]}    ${EMPTY}
    Run Keyword If    '${error_message}' != ''    Write Excel Cell    ${row}    6    ${Error_message}
    Log To Console    ERROR: ${error_message}
    RETURN    ${error_message}

Check Success
    [Arguments]  ${row}
    ${status}  ${success_text}=  Run Keyword And Ignore Error  Get Text  ${success_form}
    Run Keyword If  '${status}' == 'PASS'
    ...    Write Excel Cell    ${row}    6    ${success_text}
    Log To Console    SUCCESS: ${success_text}
    [Return]  ${success_text}



Read Actual Result Login
    [Arguments]  ${row}
    ${actualresult}  Read Excel Cell  ${row}  6
    RETURN  ${actualresult}

Verify Equal Result Login
    [Arguments]  ${row}  ${expected}  ${actualresult}
    
    Log To Console    Expected: ${expected}    Actual: ${actualresult}

    ${flag}=  Run Keyword And Return Status  Should Be Equal  ${expected}  ${actualresult}

    IF  ${flag}
        Write Excel Cell    ${row}    7    Pass
    ELSE
        Write Excel Cell    ${row}    7    Failed
        ${screenshotFailed}=  Set Variable    ${screenshot}failed_row_${row}.png
        Run Keyword And Ignore Error    Capture Page Screenshot   ${screenshotFailed}
    END




Save Excel Login And Close
    Save Excel Document  ${DataTableLoginAdmin}
    Close Current Excel Document


Close Browser Login
    Close Browser