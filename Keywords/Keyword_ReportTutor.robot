*** Settings ***
Library    SeleniumLibrary
Library    ExcelLibrary
Library    ../Keywords/screenshot_ReportTutor.py

Resource    ../Variables/Variable_ReportTutor.robot

*** Keywords ***

Open File Excel of Report Tutor
    Open Excel Document     ${DataTableReportTutor}    ${Sheet}


Open Browser Website
    Open Browser     ${URL}    ${BROWSER}
    Maximize Browser Window

Login As User
    [Arguments]    ${Row}
    ${email}=  Read Excel Cell  ${Row}  3
    ${password}=  Read Excel Cell  ${Row}  4
    Click Element    ${link_tologin}
    Input Text    ${Loc_Email}    ${email}
    Input Text    ${Loc_Password}    ${password}
    Click Button    ${Btn_submit}

Go To My Course Page
    Click Element    ${MycourseLink}
    BuiltIn.Sleep    2s
    Click Element    ${Descriptioncourse}
    BuiltIn.Sleep    2s
    Click Element    ${Report_Loc}
    BuiltIn.Sleep    2s

Input From ReportTutor
    [Arguments]    ${Row}
    ${Report}=  Read Excel Cell  ${Row}  5
    Run Keyword IF    ${Report} != '' and ${Report} != None and ${Report} != ${None}     
    ...    Input Text    ${Input_Report}    ${Report}
    
Submit Report Tutor
    Click Element    ${BTN_submitReport}
    BuiltIn.Sleep    2s

Check Alert Present
    [Arguments]    ${Row}
    ${alert_text}=    Run Keyword And Ignore Error    Handle Alert    LEAVE
    Run Keyword And Ignore Error    Write Excel Cell    ${Row}    5    ${alert_text}

Success alert
    [Arguments]    ${Row}
    ${status}  ${success_text}=  Run Keyword And Ignore Error  Get Text  ${Success_Message}
    Run Keyword If  '${status}' == 'PASS'  Write Excel Cell    ${Row}    7    ${success_text}
    Run Keyword And Ignore Error    Write Excel Cell    ${Row}    7    ${success_text}
    Log To Console    SUCCESS: ${success_text}
    RETURN    ${success_text}

Verify Report Tutor
    [Arguments]    ${Row}
    ${Expected}=  Read Excel Cell  ${Row}  6
    ${actual}=  Read Excel Cell  ${Row}  7
    Log To Console    Expected Result: "${Expected}"
    Log To Console    Actual Result: "${actual}"
    ${flag}=  Run Keyword And Return Status  Should Be Equal  ${Expected}  ${actual}

    IF    ${flag}
        Write Excel Cell    ${Row}    6    Pass
    ELSE
        Write Excel Cell    ${Row}    6    Fail
        ${path}=    Capture Alert Screenshot    ${Row}
        Log To Console    Screenshot saved at: ${path}
        Run Keyword And Ignore Error    Handle Alert    ACCEPT
    END


Save and Close Excel Report Tutor
    Save Excel Document    ${DataTableReportTutor}
    Close Current Excel Document

Close Browser Report Tutor
    Close Browser