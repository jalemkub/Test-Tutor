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
    Click Element    ${LoginUser}
    Wait Until Page Contains Element    ${InputUsername}    timeout=10s

Login Form
    [Arguments]  ${row}
    ${email}=  Read Excel Cell  ${row}  3
    ${Password}=  Read Excel Cell  ${row}  4
    Input Text    ${InputUsername}    ${email}
    Input Text    ${InputPassword}    ${Password}
    Click Element    ${BtnLogin}

Go RegisterCourses
    Click Element    ${LocLinkCourse}
    Sleep  1s

Click RegisterCourse
    Wait Until Page Contains Element    ${BtnRegisterdescription}  timeout=10s
    Click Element    ${BtnRegisterdescription}    
    Sleep  1s

Submit RegisterCourse
    Click Element    ${Btn_Confirm}
    Sleep  2s

Read Expected Result Register Course
    [Arguments]  ${row}
    ${expected}=  Read Excel Cell  ${row}  6
    Log To Console    Expected Result: "${expected}"
    RETURN    ${expected}

Read ActualResult Result Register Course
    [Arguments]  ${row}
    ${actual}=  Read Excel Cell  ${row}  7
    Log To Console    Actual Result: "${actual}"
    RETURN    ${actual}

Read Excel Checkbox
    [Arguments]  ${row}
    ${notation}=    Read Excel Cell    ${row}    5
    ${notation}=    Strip String    ${notation}
    Log To Console    notation value: "${notation}"
    IF    '${notation}' != '' and '${notation}' != None and '${notation}' != 'None'
        Wait Until Element Is Visible    //input[@id='agree']    timeout=10s
        Run keyword and Ignore error  Select checkbox     ${Checkbox_F_Register}
    ELSE
        Log To Console    Notation is empty or None, checkbox not selected.
    END


Check Success RegisterCourse
    [Arguments]  ${row}
    Run Keyword And Ignore Error  Wait Until Element Is Visible    ${Success_Msg}
    ${status}  ${success_text}=  Run Keyword And Ignore Error  Get Text  ${Success_Msg}
    Run Keyword If  '${status}' == 'PASS'  Write Excel Cell    ${row}    7    ${success_text}
    Log To Console    SUCCESS: ${success_text}
    RETURN  ${success_text}

Verify RegisterCourse
    [Arguments]  ${row}  ${expected}  ${actual}
    ${flag}=    Run Keyword And Ignore Error    Should Be Equal    ${expected}    ${actual}    
    IF    ${flag}
        Write Excel Cell    ${row}    8    Pass
    ELSE
        Write Excel Cell    ${row}    8    Fail
        # ${screenshotFailed}    Set Variable    ${screenshot}failed_row_${row}.png
        # Capture Page Screenshot   ${screenshotFailed}
    END
Save Excel File RegisterCourse
    Save Excel Document    ${DataTableRegisterCourse}

Close Excel File RegisterCourse
    Close Current Excel Document

Close Browser Page
    Close Browser