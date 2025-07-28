*** Settings ***
Library    SeleniumLibrary
Library    ExcelLibrary
Resource    ../Variables/Variable_RegisterStudent.robot
*** Keywords ***

Open Excel
    [Arguments]  ${DataTableRegisterStudent}  ${Sheet}
    Open Excel Document  ${DataTableRegisterStudent}  ${Sheet}

Open Browser WebSite
    Open Browser  ${URL}  ${BROWSER}  options=add_experimental_option('detach',True)
    Set Selenium Speed    0.1s
    Maximize Browser Window
    Wait Until Page Contains Element  ${Loc_Register}  timeout=10s

Click go To From Register
    Click Element  ${Loc_Register}
    Wait Until Page Contains Element  ${LocStuID}  timeout=10s


Input Fill From Excel
    [Arguments]  ${student_id}  ${Firstname}  ${Lastname}  ${email}  ${telephone}  ${Image}  ${year of study}  ${password}
    Input Text  ${LocStuID}  ${student_id}
    Input Text  ${LocEmail}  ${email}
    Input Text  ${LocFName}  ${Firstname}
    Input Text  ${LocLName}  ${Lastname}
    Input Text  ${LocPhone}  ${telephone}
    Select From List By Value  ${LocYear_of_Study}  ${year of study}
    Input Text  ${LocPassword}  ${password}
    Choose File  ${LocBTTImage}  ${Image}



Click Register Button
    Click Element    ${ButtonRegister}



Read Expected Result RegisterStudent
    [Arguments]  ${row}  ${Expected}
    ${Expected}  Read Excel Cell  ${row}  10
    RETURN  ${Expected}


Write Actual Result RegisterStudent
    [Arguments]  ${row}  ${ActualResult}
    Write Excel Cell  ${row}  11  ${ActualResult}
    RETURN  ${ActualResult}

Get All Error Messages
    ${err_id}=        Get Text    ${textErrorID}
    ${err_email}=     Get Text    ${textErrorEmail}
    ${err_fname}=     Get Text    ${textErrorFName}
    ${err_lname}=     Get Text    ${textErrorLName}
    ${err_phone}=     Get Text    ${textErrorPhone}
    ${err_password}=  Get Text    ${textErrorPassword}
    # ... เพิ่มเติมตามต้องการ
    # รวมข้อความแจ้งเตือนทั้งหมด (ถ้ามี) แยกด้วยเครื่องหมาย | หรือ \n
    ${all_errors}=    Set Variable    ${err_id} | ${err_email} | ${err_fname} | ${err_lname} | ${err_phone} | ${err_password}
    [Return]    ${all_errors}




Verify Equal Result RegisterStudent
    [Arguments]  ${row}  ${Expected}  ${ActualResult}
    IF  '${Expected}' == '${ActualResult}'  
        Write Excel Cell  ${row}  12  'Pass'
    ELSE  
        Write Excel Cell  ${row}  12  'Failed'
        ${screenshotFailed}    Set Variable    ${screenshot}failed_row_${row}.png
        Run Keyword And Ignore Error    Capture Page Screenshot    ${screenshotFailed}
    END



Save Excel Register Student
    Save Excel Document  ${DataTableRegisterStudent}

Close Excel Register Student
    Close Current Excel Document

Close Browser Register Student
    Close Browser