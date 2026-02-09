*** Settings ***
Library    SeleniumLibrary
Library    ExcelLibrary
Library    ../Keywords/screenshot_RequestWithdraw.py
Resource    ../Variables/Variable_RequestWithdraw.robot

*** Keywords ***
Open Browser Website
    Open Browser    ${URL}    ${BROWSER}    options=add_experimental_option('detach',True)
    # set selenium speed    0.3s
    Maximize Browser Window

Open Excel Request Withdraw
    Open Excel Document    ${DataTableRequestWithdraw}    ${Sheet}

Go to Login Page for Request Withdraw
    [Arguments]    ${row}
    Click Element    ${Loc_tologinmenu}
    BuiltIn.Sleep    1s
    Click Element    ${Loc_tologin}
    Input Text    ${Loc_Email}    mju6504106383
    Input Text    ${Loc_Password}    Ptt123445678##
    Click Element    ${Btn_submit}

Go to Request Withdraw Page
    [Arguments]    ${row}
    ${BankName}=    Read Excel Cell    ${row}    3
    ${Number}    Read Excel Cell    ${row}    4
    ${Amount}    Read Excel Cell    ${row}    5

    Click Element    ${Loc_PathMenu}
    Click Element    ${Loc_PathRequestWithdraw}

    ${should_select_ฺBank}=    Evaluate    '${BankName}' != '' and '${BankName}' != 'กรุณาเลือกธนาคาร' and '${BankName}' != '${None}' and '${BankName}' != '${None}'
    Run Keyword If    ${should_select_ฺBank}    
    ...    Select From List By Label    ${SubjectCategory}    ${BankName}

    IF    ${Number} is not None and ${Number} != ''
        Input Text    ${AccountNumber}    ${Number}
    ELSE
        Press Keys    ${AccountNumber}    SPACE
    END

    IF    ${Amount} is not None and ${Amount} != ''
        Input Text    ${AmountWithdraw}    ${Amount}
    ELSE
        Press Keys    ${AmountWithdraw}    SPACE
    END
    
Submit and Handle Alerts
    [Arguments]    ${row}


    Click Element    ${BTN_RequestWithdraw}
    ${has_alert}    ${alert_text}=    Run Keyword And Ignore Error    Handle Alert    LEAVE

    IF    '${has_alert}' == 'FAIL'
        ${validation_msg}=    Get Element Attribute    ${AccountNumber}    validationMessage
        IF    '${validation_msg}' == ''
            ${validation_msg}=    Get Element Attribute    ${AmountWithdraw}    validationMessage
        END

        IF    '${validation_msg}' != ''
            Write Excel Cell    ${row}    7    ${validation_msg}
        END
    ELSE
        ${is_confirmation}=    Run Keyword And Return Status
        ...    Should Contain Any    ${alert_text}    ยืนยันการถอนเงิน    ไปยังบัญชี

        IF    ${is_confirmation}
            Handle Alert    ACCEPT
            ${status}    ${success_text}=    Run Keyword And Ignore Error    Get Text    ${Loc_success}
            IF    '${status}' == 'PASS'
                Write Excel Cell    ${row}    7    ${success_text}
            ELSE
                Write Excel Cell    ${row}    7    Success message not found
            END
        ELSE
            Write Excel Cell    ${row}    7    ${alert_text}
        END
    END

Verify RequestWithdraw
    [Arguments]    ${row}
    [Documentation]    ตรวจสอบผลลัพธ์ว่าตรงกับที่คาดหวังหรือไม่
    
    # อ่านค่า Expected
        ${Expected}=    Read Excel Cell    ${row}    6
        ${Actual}=    Read Excel Cell    ${row}    7
    
    # Log ผลลัพธ์
    Log To Console    === Row ${row} ===
    Log To Console    Expected: ${Expected}
    Log To Console    Actual: ${Actual}
    
    # เปรียบเทียบ Expected กับ Actual
    ${is_match}=    Run Keyword And Return Status    Should Be Equal    ${Expected}    ${Actual}
    
        IF    ${is_match}
            Write Excel Cell    ${row}    8    Pass
        ELSE
            Write Excel Cell    ${row}    8    Fail
            ${path}=    Capture Alert Screenshot    ${row}
            Log To Console    Screenshot: ${path}
        END

Close Excel Request Withdraw
    Save Excel Document    ${DataTableRequestWithdraw}    
    Close Current Excel Document

Close Browser Page
    Close Browser