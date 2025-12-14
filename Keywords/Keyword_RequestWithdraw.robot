*** Settings ***
Library    SeleniumLibrary
Library    ExcelLibrary
Library    ../Keywords/screenshot_RequestWithdraw.py
Resource    ../Variables/Variable_RequestWithdraw.robot

*** Keywords ***
Open Browser Website
    Open Browser    ${URL}    ${BROWSER}    options=add_experimental_option('detach',True)
    set selenium speed    0.5s
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

    Run Keyword If    '${AccountNumber}' != '' and '${AccountNumber}' != '${None}' and '${AccountNumber}' != 'None'    
    ...    Input Text    ${AccountNumber}    ${Number}
    Run Keyword If    '${AmountWithdraw}' != '' and '${AmountWithdraw}' != '${None}' and '${AmountWithdraw}' != 'None'   
    ...    Input Text    ${AmountWithdraw}     ${Amount}
    


Submit and Handle Alerts
    [Arguments]    ${row}
    # [Documentation]    คลิกปุ่มยืนยัน และจัดการ Alert ทั้ง 2 แบบ (Error Alert และ Confirmation Alert)
    
    Click Element    ${BTN_RequestWithdraw}
    BuiltIn.Sleep    1s
    ${has_alert}    ${alert_text}=    Run Keyword And Ignore Error    
    ...    Handle Alert    action=LEAVE
    
    # ถ้าไม่มี Alert (ไม่น่าจะเกิด)
    IF    '${has_alert}' == 'FAIL'
        Log To Console    No alert detected
        RETURN    NO_ALERT
    END
    
    Log To Console    Alert detected: ${alert_text}
    
    # ตรวจสอบว่าเป็น Confirmation หรือ Error
    ${is_confirmation}=    Run Keyword And Return Status
    ...    Should Contain Any    ${alert_text}    ยืนยันการถอนเงิน    ไปยังบัญชี
    
    IF    ${is_confirmation}
        # กรอกถูก → Confirmation Alert
        Log To Console    Type: Confirmation (data correct) - Accepting...
        Handle Alert    ACCEPT
        BuiltIn.Sleep    2s
        
        # ดึง Success Message และเขียนลง Excel ทันที
        ${status}    ${success_text}=    Run Keyword And Ignore Error    
        ...    Get Text    ${Loc_success}
        
        IF    '${status}' == 'PASS'
            Log To Console    Success Message: ${success_text}
            Write Excel Cell    ${row}    7    ${success_text}
        ELSE
            Log To Console    Warning: Success message not found
            Write Excel Cell    ${row}    7    No Success Message
        END
        
        RETURN    SUCCESS
    ELSE
        # กรอกผิด → Error Alert → เขียนลง Excel
        Log To Console    Type: Error (data incorrect)
        Write Excel Cell    ${row}    7    ${alert_text}
        Handle Alert    LEAVE
        RETURN    ERROR
    END

Verify RequestWithdraw
    [Arguments]    ${row}
    [Documentation]    ตรวจสอบผลลัพธ์ว่าตรงกับที่คาดหวังหรือไม่
    
    # อ่านค่า Expected
    ${Expected}=    Read Excel Cell    ${row}    6
    
    # ส่งฟอร์มและจัดการ Alert (ข้อความถูกเขียนลง Excel แล้วใน Check Alert)
    # ${result}=    Submit and Handle Alerts    ${row}
    
    # อ่าน Actual จาก Excel (ถูกเขียนไว้แล้วใน Check Alert)
    ${Actual}=    Read Excel Cell    ${row}    7
    
    # Log ผลลัพธ์
    Log To Console    === Row ${row} ===
    Log To Console    Expected: ${Expected}
    Log To Console    Actual: ${Actual}
    
    # เปรียบเทียบ Expected กับ Actual
    ${is_match}=    Run Keyword And Return Status    Should Be Equal    ${Expected}    ${Actual}
    
    IF    ${is_match}
        Write Excel Cell    ${row}    8    Pass
        Log To Console    Result: PASS
    ELSE
        Write Excel Cell    ${row}    8    Fail
        ${path}=    Capture Alert Screenshot    ${row}
        Log To Console    Result: FAIL
        Log To Console    Screenshot: ${path}
    END

Close Excel Request Withdraw
    Save Excel Document    ${DataTableRequestWithdraw}    
    Close Current Excel Document

Close Browser Page
    Close Browser