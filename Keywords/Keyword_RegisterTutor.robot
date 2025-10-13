*** Settings ***
Library    SeleniumLibrary
Library    ExcelLibrary

Resource    ../Variables/Variable_RegisterTutor.robot
Resource    ../Keywords/Keyword_RegisterTutor.robot

*** Keywords ***
Open Excel file
    Open Excel Document  ${DataTableRegisterTutor}  ${Sheet}

Open Browser WebSite
    Open Browser  ${URL}  ${BROWSER}  options=add_experimental_option('detach',True)
    Set Selenium Speed    0.3s
    Maximize Browser Window
    # Wait Until Page Contains Element  ${Loc_Register}  timeout=10s
Go to page Login for Register Tutor
    [Arguments]  ${email}  ${password}
    Click Element  ${link_tologin}
    Wait Until Page Contains Element  ${Loc_Email}  timeout=10s
    Input Text  ${Loc_Email}  ${email}
    Input Text  ${Loc_Password}  ${password}
    Click Button  ${Btn_submit}

Go to Page Register Tutor
    Click Element  ${link_toregister}
    Wait Until Page Contains Element  ${Loc_TypeSubject}  timeout=10s

Fill Form Register Tutor
    [Arguments]  ${skill}  ${experience}
    # Run Keyword If  '${student_id}' != '' and '${student_id}' != '${None}'  Input Text  ${LocStuID}  ${student_id}
    Run Keyword If  '${skill}' != '' and '${skill}' != '${None}'  Input Text  ${Loc_TypeSubject}  ${skill}
    Run Keyword If  '${experience}' != '' and '${experience}' != '${None}'  Input Text  ${Loc_Experience}  ${experience}
Submit Form Register Tutor
    Wait Until Element Is Visible    ${Btn_Register}
    Click Element  ${Btn_Register}

Read Expected Result
    [Arguments]  ${row}
    ${expected}=  Read Excel Cell  ${row}  7
    RETURN  ${expected}
    

Alert Error Form Register Tutor
    [Arguments]  ${row}
    # พยายามกด Alert และดึงข้อความ
    ${status}  Run Keyword And Ignore Error  Handle Alert   ACCEPT
    ${alert_text}    Set Variable If    '${status[0]}' == 'PASS'    ${status[1]}    ${EMPTY}
    Run Keyword If    '${alert_text}' != ''  Write Excel Cell    ${row}    8    ${alert_text}
    Run Keyword And Ignore Error  Write Excel Cell    ${row}    8    ${alert_text}
    Log To Console    ALERT: ${alert_text}
    RETURN    ${alert_text}


Text Error Form Register Tutor
    [Arguments]  ${row}
    # ตรวจสอบข้อความ Error บนหน้า
    ${status1}  Run Keyword And Ignore Error  Get Text  ${Errorform}
    ${error_message}    Set Variable If    '${status1[0]}' == 'PASS'    ${status1[1]}    ${EMPTY}
    Run Keyword If    '${error_message}' != ''    Write Excel Cell    ${row}    8    ${Error_message}
    Log To Console    ERROR: ${error_message}
    RETURN    ${error_message}

Check Success Form Register Tutor
    [Arguments]  ${row}
    ${status}  ${success_text}=  Run Keyword And Ignore Error  Get Text  ${Loc_SuccessMessage}
    Run Keyword If  '${status}' == 'PASS'  Write Excel Cell    ${row}    6    ${success_text}
    Log To Console    SUCCESS: ${success_text}
    [Return]  ${success_text}

Read Actual Result
    [Arguments]  ${row}
    ${actual}=  Read Excel Cell  ${row}  8
    RETURN  ${actual}

Register Tutor Verify
    [Arguments]  ${row}  ${expected}  ${actual}
    ${flag}  Run Keyword And Return Status  Should Be Equal  ${expected}  ${actual}
    IF  ${flag}
        Write Excel Cell  ${row}  9  Pass
    ELSE
        Write Excel Cell  ${row}  9  Fail
        ${screenshotFailed}    Set Variable    ${screenshot}failed_row_${row}.png
        Capture Page Screenshot   ${screenshotFailed}
    END

Save Excel And Close Excel
    Save Excel Document  ${DataTableRegisterTutor}
    Close Current Excel Document

Close Website Page
    Close Browser