*** Settings ***
Library    SeleniumLibrary
Library    ExcelLibrary
Library    ../Keywords/screenshot_ReportTutor.py
Library    String
Resource    ../Variables/Variable_ReportTutor.robot

*** Keywords ***
Open File Excel of Report Tutor
    Open Excel Document     ${DataTableReportTutor}    ${Sheet}

Open Browser Website
    Open Browser     ${URL}    ${BROWSER}    options=add_experimental_option('detach',True)
    Set Selenium Speed    0.3s
    Maximize Browser Window

Login As User
    [Arguments]    ${Row}
    Click Element    ${Loc_LoginMenu}
    Click Element    ${Loc_gologin}
    Input Text    ${Loc_Email}    mju6504106414
    Input Text    ${Loc_Password}    Ptt123445678##
    Click Element    ${Btn_submit}

Go To My Course Page
    Click Element    ${Stu_Menu}
    Click Element    ${My_RegisterCourse}
    Click Element    ${Descriptioncourse}
    Click Element    ${Report_Loc}

Input From ReportTutor
    [Arguments]    ${Row}
    ${Report}=    Read Excel Cell    ${Row}    3
    ${Report}=    Set Variable If    '${Report}' == 'None' or '${Report}' == '${None}'    ${EMPTY}    ${Report}
    ${Report}=    Strip String    ${Report}
    Run Keyword If    '${Report}' != ''    Input Text    ${Input_Report}    ${Report}
    
Submit Report Tutor
    Click Element    ${Btn_SubmitReport} 
    BuiltIn.Sleep    2s

Check Report Tutor Result
    [Arguments]    ${row}
    Submit Report Tutor
    # 1) ลองจับ Alert ก่อน
    ${status}    ${alert_text}=    
    ...    Run Keyword And Ignore Error    
    ...    Handle Alert    LEAVE

    IF    '${status}' == 'PASS' and '${alert_text}' != ''
        Write Excel Cell    ${row}    5    ${alert_text}
        RETURN    ALERT:${alert_text}
    END

    # 2) ถ้าไม่มี Alert → ลองเช็ค Error message
    ${error_status}    ${error_text}=    
    ...    Run Keyword And Ignore Error    
    ...    Execute JavaScript    return document.querySelector("${Error_Message}").innerHTML

    IF    '${error_status}' == 'PASS' and '${error_text}' != ''
        Write Excel Cell    ${row}    5    ${error_text}
        RETURN    ERROR:${error_text}
    END

    # 3) ถ้าไม่ใช่ Alert และไม่ใช่ Error → ต้องเป็น Success
    ${success_status}    ${success_text}=    
    ...    Run Keyword And Ignore Error    
    ...    Get Text    ${Success_Message}

    ${success_text}    Set Variable If    '${success_status}' == 'PASS'    ${success_text}    ${EMPTY}

    Write Excel Cell    ${row}    5    ${success_text}
    RETURN    SUCCESS:${success_text}


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
    Log To Console    Expected: ${expected}    
    Log To Console    Actual: ${actual}
    Log To Console    ROW:${{${row}-1}}
    ${flag}=  Run Keyword And Return Status  Should Be Equal  ${expected}  ${actual}
    
    IF    ${flag}
        Write Excel Cell    ${Row}    6    Pass
        Run Keyword And Ignore Error    Handle Alert    ACCEPT
    ELSE
        Write Excel Cell    ${Row}    6    Fail
        ${path}=    Capture Alert Screenshot    ${Row}
        Log To Console    Screenshot saved at: ${path}
        Run Keyword And Ignore Error    Handle Alert    ACCEPT    5s
    END
Save Excel Report Tutor
    Save Excel Document    ${DataTableReportTutor}
    
Close Excel Report Tutor
    Close Current Excel Document

Close Browser Report Tutor
    Close Browser