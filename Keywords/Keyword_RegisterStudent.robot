*** Settings ***
Library    SeleniumLibrary
Library    ExcelLibrary
Library    String
Library    OperatingSystem



Resource    ../Keywords/Keyword_RegisterStudent.robot
Resource    ../Variables/Variable_RegisterStudent.robot


*** Keywords ***
Open Excel Student
    Open Excel Document  ${DataTableRegisterStudent}  ${Sheet}

Open Browser WebSite
    Open Browser  ${URL}  ${BROWSER}  options=add_experimental_option('detach',True)
    Set Selenium Speed    0.1s
    Maximize Browser Window
    Wait Until Element Is Visible    ${Loc_For_Register}  timeout=10s

Click go To From Register
    Click Element  ${Loc_For_Register}
    Click Element    ${Loc_RegisterStudent}
    Wait Until Page Contains Element  ${LocStuID}  timeout=10s

Input Fill From Excel
    [Arguments]  ${row}
    ${student_id}  Read Excel Cell  ${row}  3
    ${Firstname}  Read Excel Cell  ${row}  4
    ${Lastname}  Read Excel Cell  ${row}  5
    ${telephone}  Read Excel Cell  ${row}  6
    ${year_of_study}  Read Excel Cell  ${row}  7
    ${email}  Read Excel Cell  ${row}  8
    ${password}  Read Excel Cell  ${row}  9

    Run Keyword If  '${student_id}' != '' and '${student_id}' != '${None}'  Input Text  ${LocStuID}  ${student_id}
    Run Keyword If  '${Firstname}' != '' and '${Firstname}' != '${None}'  Input Text  ${LocFName}  ${Firstname}
    Run Keyword If  '${Lastname}' != '' and '${Lastname}' != '${None}'  Input Text  ${LocLName}  ${Lastname}
    Run Keyword If  '${telephone}' != '' and '${telephone}' != '${None}'  Input Text  ${LocPhone}  ${telephone}

    ${should_select}=    Evaluate    '${year_of_study}' != '' and '${year_of_study}' != 'เลือกชั้นปี' and '${year_of_study}' != '${None}'
    Run Keyword If    ${should_select}    Select From List By Label    ${LocYear_of_Study}    ${year_of_study}
    
    Run Keyword If  '${email}' != '' and '${email}' != '${None}'  Input Text  ${LocEmail}  ${email}  
    Run Keyword If  '${password}' != '' and '${password}' != '${None}'  Input Text  ${LocPassword}  ${password}



Upload Student Image
    [Arguments]    ${row}
    ${image_name}  Read Excel Cell  ${row}  10
    Run Keyword If    '${image_name}' == ''    RETURN From Keyword
    Run Keyword If    '${image_name}' == 'None'    RETURN From Keyword

    ${image_name}=    Strip String    ${image_name}
    ${image_path}=    Catenate    SEPARATOR=    ${EXECDIR}/ExcelProject/Images/    ${image_name}
    Run Keyword And Ignore Error    Choose File    ${LocBTTImage}    ${image_path}
    Log To Console    Uploaded image: ${image_path}
    Run Keyword And Ignore Error    Wait Until Page Contains Element    ${LocBTTImage}    timeout=10s



Submit Register Button
    Click Element    ${BtnRegister} 


Get Visible Register Student Message
    [Arguments]    ${row}    @{locators}

    FOR    ${loc}    IN    @{locators}
        ${status}=    Run Keyword And Return Status
        ...    Wait Until Element Is Visible    ${loc}    5s

        IF    ${status}
            ${text}=    Get Text    ${loc}
            Write Excel Cell    ${row}    12    ${text}
            RETURN    ${text}
        END
    END

    RETURN    ${EMPTY}


Read Expected Result RegisterStudent
    [Arguments]  ${row}
    ${Expected}  Read Excel Cell  ${row}  11
    RETURN  ${Expected}


Read ActualResult Result RegisterStudent
    [Arguments]  ${row}
    ${ActualResult}  Read Excel Cell  ${row}  12
    RETURN  ${ActualResult} 

    
Verify Register Student Result
    [Arguments]    ${row}

    ${expected}=    Read Excel Cell    ${row}    11

    ${status}    ${result}=    Run Keyword And Ignore Error
    ...    Get Text    ${success_form}

    ${success_text}=    Set Variable If    '${status}' == 'PASS'    ${result}    ${EMPTY}
    Run Keyword If    '${status}' == 'PASS'
    ...    Write Excel Cell    ${row}    12    ${success_text}

    ${locators}=    Create List
    ...    ${textErrorID}
    ...    ${textErrorFName}
    ...    ${textErrorLName}
    ...    ${textErrorPhone}
    ...    ${textErrorYear}
    ...    ${textErrorEmail}
    ...    ${textErrorPassword}
    ...    ${textErrorImage}
    ...    ${error_form}

    ${actual}=    Get Visible Register Student Message    ${row}    @{locators}

    Log To Console    Expected: ${expected}
    Log To Console    Actual: ${actual}
    Log To Console    ROW:${{${row}-1}}

    ${pass1}=    Run Keyword And Return Status
    ...    Should Be Equal    ${expected}    ${success_text}

    ${pass2}=    Run Keyword And Return Status
    ...    Should Be Equal    ${expected}    ${actual}

    IF    ${pass1} or ${pass2}
        Write Excel Cell    ${row}    13    Pass
    ELSE
        Write Excel Cell    ${row}    13    Fail
        ${screenshotFailed}=    Set Variable    ${screenshot}failed_row_${row}.png
        Capture Page Screenshot    ${screenshotFailed}
    END



Save And Close Excel Register Student
    Save Excel Document  ${DataTableRegisterStudent}
    Close Current Excel Document

Close Browser Register Student
    Close Browser