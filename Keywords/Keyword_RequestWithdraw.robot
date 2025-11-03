*** Settings ***
Library    SeleniumLibrary
Library    ExcelLibrary
Library    ../Keywords/screenshot_helper.py
Resource    ../Variables/Variable_RequestWithdraw.robot

*** Keywords ***
Open Browser Website
    Open Browser    ${URL}    ${BROWSER}    options=add_experimental_option('detach',True)
    set selenium speed    0.3s
    Maximize Browser Window

Open Excel Request Withdraw
    Open Excel Document    ${DataTableRequestWithdraw}    ${Sheet}

Go to Login Page for Request Withdraw
    [Arguments]    ${row}
    Click Element    ${Loc_tologinmenu}
    BuiltIn.Sleep    1s
    Click Element    ${Loc_tologin}
    Input Text    ${Loc_Email}    mju6504106381
    Input Text    ${Loc_Password}    Ptt123445678##
    Click Element    ${Btn_submit}

Go to Request Withdraw Page
    [Arguments]    ${row}
    ${BankName}=    Read Excel Cell    ${row}    3
    ${Number}    Read Excel Cell    ${row}    4
    ${Amount}    Read Excel Cell    ${row}    5

    Click Element    ${Loc_PathMenu}
    BuiltIn.Sleep    1s
    Click Element    ${Loc_PathRequestWithdraw}

    ${should_select_ฺBank}=    Evaluate    '${BankName}' != '' and '${BankName}' != 'กรุณาเลือกธนาคาร' and '${BankName}' != None and '${BankName}' != '${None}'
    Run Keyword If    ${should_select_ฺBank}    
    ...    Select From List By Label    ${SubjectCategory}    ${BankName}

    Run Keyword If    '${AccountNumber}' != '' and '${AccountNumber}' != '${None}' and '${AccountNumber}' != 'None'    
    ...    Input Text    ${AccountNumber}    ${Number}
    Run Keyword If    '${AmountWithdraw}' != '' and '${AmountWithdraw}' != '${None}' and '${AmountWithdraw}' != 'None'   
    ...    Input Text    ${AmountWithdraw}     ${Amount}
    Click Element    ${BTN_RequestWithdraw}

Check Alert And Error Message
    [Arguments]    ${row}

    # ดึง Alert text ถ้ามี
    ${Status}    ${alert_text}=    Run Keyword And Ignore Error    Handle Alert    LEAVE
    Run Keyword And Ignore Error    Write Excel Cell    ${row}    7    ${alert_text}
    # ถ้าเจอ Alert และมีคำว่า 'ยืนยันการถอนเงิน' อยู่
    BuiltIn.Sleep    3s
    Run Keyword If    '${Status}'== 'ยืนยันการถอนเงิน' in '${alert_text}'    Handle Alert    Accept
    
    ...    ELSE IF    '${Status}'=='PASS'    Handle Alert    LEAVE

Check Success_Msg RequestWithdraw
    [Arguments]    ${row}
    ${success_text}=    Run Keyword And Ignore Error    Get Text    ${Loc_success}
    Run Keyword And Ignore Error   Write Excel Cell    ${row}    7    ${success_text}


Verify RequestWithdraw
    [Arguments]    ${row}
    ${Expected}    Read Excel Cell    ${row}    6
    ${Actual}    Read Excel Cell    ${row}    7
    ${flag}    Run keyword And Return Status     Should Be Equal    ${Expected}    ${Actual}
    IF    ${flag}
        Write Excel Cell    ${row}    8    Pass
    ELSE    
        Write Excel Cell    ${Row}    8    Fail
        ${path}=    Capture Alert Screenshot    ${Row}
        Log To Console    Screenshot saved at: ${path}
        BuiltIn.Sleep    3s
        Run Keyword And Ignore Error    Handle Alert    ACCEPT
    END

Close Excel Request Withdraw
    Save Excel Document    ${DataTableRequestWithdraw}    
    Close Current Excel Document

Close Browser Page
    Close Browser