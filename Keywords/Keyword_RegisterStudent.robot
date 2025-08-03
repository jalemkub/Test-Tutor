*** Settings ***
Library    SeleniumLibrary
Library    ExcelLibrary
Library    OperatingSystem
Library    String
Resource    ../Keywords/Keyword_RegisterStudent.robot
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
    [Arguments]  ${student_id}  ${Firstname}  ${Lastname}  ${telephone}  ${year_of_study}  ${email}  ${password} 
    Run Keyword If  '${student_id}' != '' and '${student_id}' != '${None}'  Input Text  ${LocStuID}  ${student_id}
    Run Keyword If  '${Firstname}' != '' and '${Firstname}' != '${None}'  Input Text  ${LocFName}  ${Firstname}
    Run Keyword If  '${Lastname}' != '' and '${Lastname}' != '${None}'  Input Text  ${LocLName}  ${Lastname}
    Run Keyword If  '${telephone}' != '' and '${telephone}' != '${None}'  Input Text  ${LocPhone}  ${telephone}
    Run Keyword If  '${year_of_study}' != '' and '${year_of_study}' != '${None}'  Select From List By Label  ${LocYear_of_Study}  ${year_of_study}
    Run Keyword If  '${email}' != '' and '${email}' != '${None}'  Input Text  ${LocEmail}  ${email}
    Run Keyword If  '${password}' != '' and '${password}' != '${None}'  Input Text  ${LocPassword}  ${password}



Upload Student Image
    [Arguments]    ${image_name}
    ${image_name}=    Strip String    ${image_name}
    ${image_path}=    Catenate    SEPARATOR=    ${EXECDIR}/ExcelProject/Images/    ${image_name}
    Run Keyword If    '${image_name}' != '' and '${image_name}' != '${None}'  
    ...    Choose File    ${LocBTTImage}    ${image_path}
    Log To Console    Uploaded image: ${image_path}


Submit Register Button
    Click Element    ${BtnRegister}
 
Read Expected Result RegisterStudent
    [Arguments]  ${row}
    ${Expected}  Read Excel Cell  ${row}  11
    RETURN  ${Expected}


Get All Error Messages
    [Arguments]  ${row}

    ${status}   ${err_stu_id}=     Run Keyword And Ignore Error    Get Text    ${textErrorID}
    ${status2}  ${err_fname}=      Run Keyword And Ignore Error    Get Text    ${textErrorFName}
    ${status3}  ${err_lname}=      Run Keyword And Ignore Error    Get Text    ${textErrorLName}
    ${status4}  ${err_phone}=      Run Keyword And Ignore Error    Get Text    ${textErrorPhone}
    ${status5}  ${err_year}=       Run Keyword And Ignore Error    Get Text    ${textErrorYear}
    ${status6}  ${err_email}=      Run Keyword And Ignore Error    Get Text    ${textErrorEmail}
    ${status7}  ${err_password}=   Run Keyword And Ignore Error    Get Text    ${textErrorPassword}
    ${status8}  ${err_image}=      Run Keyword And Ignore Error    Get Text    ${textErrorImage}

    ${err_stu_id}=     Set Variable If    '${status}'=='PASS'     ${err_stu_id}     ${EMPTY}
    ${err_fname}=      Set Variable If    '${status2}'=='PASS'    ${err_fname}      ${EMPTY}
    ${err_lname}=      Set Variable If    '${status3}'=='PASS'    ${err_lname}      ${EMPTY}
    ${err_phone}=      Set Variable If    '${status4}'=='PASS'    ${err_phone}      ${EMPTY}
    ${err_year}=       Set Variable If    '${status5}'=='PASS'    ${err_year}       ${EMPTY}
    ${err_email}=      Set Variable If    '${status6}'=='PASS'    ${err_email}      ${EMPTY}
    ${err_password}=   Set Variable If    '${status7}'=='PASS'    ${err_password}   ${EMPTY}
    ${err_image}=      Set Variable If    '${status8}'=='PASS'    ${err_image}      ${EMPTY}
    

    Run Keyword If    '${err_stu_id}' != ''    Write Excel Cell    ${row}    5    ${err_stu_id}
    Run Keyword If    '${err_fname}' != ''    Write Excel Cell    ${row}    5    ${err_fname}
    Run Keyword If    '${err_lname}' != ''    Write Excel Cell    ${row}    5    ${err_lname}
    Run Keyword If    '${err_phone}' != ''    Write Excel Cell    ${row}    5    ${err_phone}
    Run Keyword If    '${err_year}' != ''    Write Excel Cell    ${row}    5    ${err_year}
    Run Keyword If    '${err_email}' != ''    Write Excel Cell    ${row}    5    ${err_email}
    Run Keyword If    '${err_password}' != ''    Write Excel Cell    ${row}    5    ${err_password}
    Run Keyword If    '${err_image}' != ''    Write Excel Cell    ${row}    5    ${err_image}

    

    

    ${ActualResult}=  ${err_stu_id}  ${err_fname}  ${err_lname}  ${err_phone}  ${err_year}  ${err_email}  ${err_password}  ${err_image}

    Write Excel Cell    ${row}    12    ${ActualResult}
    RETURN    ${ActualResult}


Verify Equal Result RegisterStudent
    [Arguments]  ${row}  ${expected}  ${ActualResult}

    ${expected}=    Read Excel Cell  11    ${expected}
    ${ActualResult}=    Read Excel Cell  12    ${ActualResult}

    ${flag}=  Run Keyword And Return Status  Should Contain  ${ActualResult}  ${expected}
    Log To Console    Expected: ${expected}

    IF    ${flag}
        Write Excel Cell    ${row}    13    Pass
        Write Excel Cell    ${row}    14    Pass
    ELSE
        Write Excel Cell    ${row}    13    Failed
        Write Excel Cell    ${row}    14    Pass
        ${screenshotFailed}=    Set Variable    ${EXECDIR}/screenshotRegisterStudent/failed_row_${row}.png
        Run Keyword And Ignore Error    Capture Page Screenshot    ${screenshotFailed}
    END


Save Excel Register Student
    Save Excel Document  ${DataTableRegisterStudent}

Close Excel Register Student
    Close Current Excel Document

Close Browser Register Student
    Close Browser