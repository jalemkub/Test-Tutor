*** Settings ***
Library    SeleniumLibrary
Library    ExcelLibrary
Library    OperatingSystem
Library    String
Library    Collections
Resource    ../Keywords/Keyword_RegisterStudent.robot
Resource    ../Variables/Variable_RegisterStudent.robot


*** Keywords ***
Open Excel Student
    Open Excel Document  ${DataTableRegisterStudent}  ${Sheet}

Open Browser WebSite
    Open Browser  ${URL}  ${BROWSER}  options=add_experimental_option('detach',True)
    Set Selenium Speed    0.3s
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
    ${should_select}=    Evaluate    '${year_of_study}' != '' and '${year_of_study}' != 'เลือกชั้นปี' and '${year_of_study}' != None
    Run Keyword If    ${should_select}    Select From List By Label    ${LocYear_of_Study}    ${year_of_study}

    Run Keyword If  '${email}' != '' and '${email}' != '${None}'  Input Text  ${LocEmail}  ${email}
    Run Keyword If  '${password}' != '' and '${password}' != '${None}'  Input Text  ${LocPassword}  ${password}



Upload Student Image
    [Arguments]    ${image_name}
    Run Keyword If    '${image_name}' == ''    RETURN From Keyword
    Run Keyword If    '${image_name}' == 'None'    RETURN From Keyword

    ${image_name}=    Strip String    ${image_name}
    ${image_path}=    Catenate    SEPARATOR=    ${EXECDIR}/ExcelProject/Images/    ${image_name}
    Run Keyword And Ignore Error    Choose File    ${LocBTTImage}    ${image_path}
    Log To Console    Uploaded image: ${image_path}
    Run Keyword And Ignore Error    Wait Until Page Contains Element    ${LocBTTImage}    timeout=10s



Submit Register Button
    Click Element    ${BtnRegister}

    
 
Read Expected Result RegisterStudent
    [Arguments]  ${row}
    ${Expected}  Read Excel Cell  ${row}  11
    RETURN  ${Expected}
    
Get Visible Alert
    [Arguments]    @{locators}
    FOR    ${loc}    IN    @{locators}
        ${status}    Run Keyword And Return Status    Wait Until Element Is Visible    ${loc}    5s
        IF    ${status}
            ${actualResult}    Get Text    ${loc}
            Write Excel Cell    ${row}    12    ${actualResult}
            RETURN     ${actualResult}
        END
    END
    RETURN     NONE

Handle Alert And Validate
    [Arguments]    ${row}
    ${expected}=    Read Excel Cell    ${row}    11

    ${status}    ${result}=    Run Keyword And Ignore Error     Get Text      ${success_form}
    Run Keyword If    '${status}' == 'PASS'    Write Excel Cell    ${row}    12    ${result}

    ${locators}=    Create List
    ...    ${textErrorID}    ${textErrorFName}    ${textErrorLName}
    ...    ${textErrorPhone}    ${textErrorYear}    ${textErrorEmail}
    ...    ${textErrorPassword}    ${textErrorImage}    ${error_form}

    ${alert_text}=    Get Visible Alert    @{locators}
    Run Keyword If    '${status}' != 'PASS'    Write Excel Cell    ${row}    12    ${alert_text}

    ${is_pass1}=    Run Keyword And Return Status    Should Be Equal    ${expected}    ${result}    
    ${is_pass2}=    Run Keyword And Return Status    Should Be Equal    ${expected}    ${alert_text}
    IF    ${is_pass1}
        Write Excel Cell    ${row}    13    Pass
    ELSE IF    ${is_pass2}
        Write Excel Cell    ${row}    13    Pass
    ELSE
        Write Excel Cell    ${row}    13    Fail
        # ${screenshotFailed}    Set Variable    ${screenshot}failed_row_${row}.png
        # Capture Page Screenshot   ${screenshotFailed}

    END


Read ActualResult Result RegisterStudent
    [Arguments]  ${row}
    ${ActualResult}  Read Excel Cell  ${row}  12
    RETURN  ${ActualResult}

Save And Close Excel Register Student
    Save Excel Document  ${DataTableRegisterStudent}
    Close Current Excel Document

Close Browser Register Student
    Close Browser