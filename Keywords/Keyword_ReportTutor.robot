*** Settings ***
Library    SeleniumLibrary
Library    ExcelLibrary
Library    pyautogui
Library    ../Keywords/screenshot_ReportTutor.py
Resource    ../Variables/Variable_ReportTutor.robot

*** Keywords ***
Open File Excel of Report Tutor
    Open Excel Document     ${DataTableReportTutor}    ${Sheet}


Open Browser Website
    Open Browser     ${URL}    ${BROWSER}
    # Set Selenium Speed    0.2s
    Maximize Browser Window


Login As User
    [Arguments]    ${Row}
    Click Element    ${Loc_LoginMenu}
    Click Element    ${Loc_gologin}
    Wait Until Page Contains Element    ${Loc_Email}    timeout=10s
    Input Text    ${Loc_Email}    mju6504106414
    Input Text    ${Loc_Password}    Ptt123445678##
    Click Button    ${Btn_submit}


Go To My Course Page
    Click Element    ${Stu_Menu}
    Click Element    ${My_RegisterCourse}
    Click Element    ${Descriptioncourse}
    Wait Until Page Contains Element    ${Report_Loc}    timeout=10s
    Click Element    ${Report_Loc}


Input From ReportTutor
    [Arguments]    ${Row}
    ${Report}=  Read Excel Cell  ${Row}  3
    Run Keyword IF    '${Report}' != '' and '${Report}' != None and '${Report}' != ${None}     
    ...    Input Text    ${Input_Report}    ${Report}
    

Submit Report Tutor
    Click Element    ${BTN_submitReport}


Alert form Report Tutor
    [Arguments]    ${row}
    
    ${status}    ${alert_msg}=    Run Keyword And Ignore Error    Handle Alert    LEAVE
    ${alert_msg}=    Set Variable If    '${status}' == 'PASS'    ${alert_msg}    ${EMPTY}
    Run Keyword If    '${alert_msg}' != ''    Write Excel Cell    ${Row}    5    ${alert_msg} 
    Log To Console    Alert: ${alert_msg}
    RETURN    ${alert_msg}


Success form Report Tutor
    [Arguments]    ${row}
    Run Keyword And Ignore Error    Wait Until Element Is Visible    ${Success_Message}    timeout=10s
    ${status1}=    Run Keyword And Ignore Error    Get Text    ${Success_Message}
    ${text_Message}    Set Variable If    '${status1[0]}' == 'PASS'    ${status1[1]}    ${EMPTY}
    Run Keyword If    '${text_Message}' != ''    Write Excel Cell    ${row}    5    ${text_Message}
    Run Keyword And Ignore Error    Write Excel Cell    ${Row}    5    ${text_Message}
    Log To Console    SUCCESS: ${text_Message}
    RETURN    ${text_Message}


Check Error form Report Tutor
    [Arguments]    ${row}
    Run Keyword And Ignore Error    Wait Until Element Is Visible    ${Error_Message}    timeout=10s
    ${status2}=    Run Keyword And Ignore Error    Execute Javascript    return document.querySelector("${Error_Message}").innerHTML
    ${Error_Msg}    Set Variable If    '${status2[0]}' == 'PASS'    ${status2[1]}    ${EMPTY}
    Run Keyword If    '${Error_Msg}' != ''    Write Excel Cell    ${row}    5    ${Error_Msg}
    Log To Console    ERROR: ${Error_Msg}
    RETURN    ${Error_Msg}


Read Expected Result Report Tutor
    [Arguments]    ${Row}
    ${expected}=  Read Excel Cell  ${Row}  4
    Log To Console    Expected Result: "${expected}"
    RETURN    ${expected}
    

Read Actual Result Report Tutor
    [Arguments]    ${Row}
    ${actual}=  Read Excel Cell  ${Row}  5
    Log To Console    Actual Result: "${actual}"
    RETURN    ${actual}


Verify Report Tutor
    [Arguments]    ${Row}   ${expected}   ${actual} 
    ${flag}=  Run Keyword And Return Status  Should Be Equal  ${expected}  ${actual}

    IF    ${flag}
        Write Excel Cell    ${Row}    6    Pass
    ELSE
        Write Excel Cell    ${Row}    6    Fail
        ${path}=    Capture Alert Screenshot    ${Row}
        Log To Console    Screenshot saved at: ${path}
    END


Save and Close Excel Report Tutor
    Save Excel Document    ${DataTableReportTutor}
    Close Current Excel Document


Close Browser Report Tutor
    Close Browser