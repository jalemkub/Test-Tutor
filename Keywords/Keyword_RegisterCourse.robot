*** Settings ***
Library    SeleniumLibrary
Library    ExcelLibrary
Library    String
Resource    ../Variables/Variable_RegisterCourse.robot

*** Keywords ***
Open Excel Document File
    Open Excel Document    ${DataTableRegisterCourse}    ${Sheet}

Open Browser Page
    Open Browser    ${URL}    ${BROWSER}  options=add_experimental_option('detach',True)
    # Set Selenium Speed    0.3s
    Maximize Browser Window

Go login
    Click Element    ${Loc_LoginMenu}
    Click Element    ${Loc_goLogin}
    Wait Until Page Contains Element    ${InputUsername}    timeout=10s

Login Form
    [Arguments]  ${row}
    ${email}=  Read Excel Cell  ${row}  3
    Input Text    ${InputUsername}    ${email}
    Input Text    ${InputPassword}    Ptt123445678##
    Click Element    ${BtnLogin}

Go RegisterCourses
    Click Element    ${Loc_RegisterCourse}
    BuiltIn.Sleep  1s

Click RegisterCourse
    Wait Until Page Contains Element    ${BtnRegisterdescription}  timeout=10s
    Click Element    ${BtnRegisterdescription}    
    BuiltIn.Sleep  1s

Submit RegisterCourse
    Click Element    ${Btn_Confirm}
    BuiltIn.Sleep  2s

Read Expected Result Register Course
    [Arguments]  ${row}
    ${expected}=  Read Excel Cell  ${row}  5
    Log To Console    Expected Result: "${expected}"
    RETURN    ${expected}

Read ActualResult Result Register Course
    [Arguments]  ${row}
    ${actual}=  Read Excel Cell  ${row}  6
    Log To Console    Actual Result: "${actual}"
    RETURN    ${actual}

Read Excel Checkbox
    [Arguments]  ${row}
    ${notation}=    Read Excel Cell    ${row}    4
    # ถ้าเซลล์ว่าง ให้ข้ามการ strip
    Run Keyword If    '${notation}' != '' and '${notation}' != '${None}'    ${notation}=    Strip String    ${notation}
    Log To Console    notation value: "${notation}"
    IF    '${notation}' != '' and '${notation}' != '${None}' and '${notation}' != 'None'
        Wait Until Element Is Visible    ${Checkbox_F_Register}    timeout=10s
        Run keyword and Ignore error  Select checkbox     ${Checkbox_F_Register}
    ELSE
        Log To Console    ไม่พบการแจ้งเตือน
        Write Excel Cell    ${row}    6    ไม่พบการแจ้งเตือน
    END


Check Success RegisterCourse
    [Arguments]  ${row}
    Run Keyword And Ignore Error  Wait Until Element Is Visible    ${Success_Msg}
    ${status}  ${success_text}=  Run Keyword And Ignore Error  Get Text  ${Success_Msg}
    Run Keyword If  '${status}' == 'PASS'  Write Excel Cell    ${row}    6    ${success_text}
    Log To Console    SUCCESS: ${success_text}
    RETURN  ${success_text}

Verify RegisterCourse
    [Arguments]  ${row}  ${expected}  ${actual}
    # ตรวจสอบว่า expected และ actual ตรงกันหรือไม่
    Log To Console    Expected: ${expected}    
    Log To Console    Actual: ${actual}
    Log To Console    ROW:${{${row}-1}}
    ${flag}=    Run Keyword And Return Status    Should Be Equal    ${expected}    ${actual}
    
    
    IF    ${flag}
        Write Excel Cell    ${row}    7    Pass
    ELSE
        Write Excel Cell    ${row}    7    Fail
        ${screenshotFailed}    Set Variable    ${screenshot}failed_row_${row}.png
        Run Keyword And Ignore Error    Capture Page Screenshot    ${screenshotFailed}
    END
Save Excel File RegisterCourse
    Save Excel Document    ${DataTableRegisterCourse}

Close Excel File RegisterCourse
    Close Current Excel Document

Close Browser Page
    Close Browser