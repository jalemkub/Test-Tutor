*** Settings ***
Library    SeleniumLibrary
Library    ExcelLibrary
Library    String
Library    OperatingSystem



Resource    ../Keywords/Keyword_EditProfile.robot
Resource    ../Variables/Variable_EditProfile.robot


*** Keywords ***
Open Excel EditProfile
    Open Excel Document  ${DataTableEditProfile}  ${Sheet}

Open Browser WebSite
    Open Browser  ${URL}  ${BROWSER}  options=add_experimental_option('detach',True)
    Set Selenium Speed    0.1s
    Maximize Browser Window
    Wait Until Element Is Visible    ${Loc_LoginMenu}  timeout=10s

Click Login For EditProfile
    Click Element  ${Loc_LoginMenu}
    Click Element    ${Loc_Login}
    Wait Until Page Contains Element  ${Loc_Username}  timeout=10s
Input Login
    Input Text  ${Loc_Username}   mju6504106428
    Input Text  ${Loc_Password}   Ptt123445678##
    Click Element  ${Loc_BtnLogin}
    Wait Until Page Contains Element  ${Loc_EditStdMenu}  timeout=10s
    Click Element  ${Loc_EditStdMenu}
    Click Element  ${Loc_ViewProfile}
    Wait Until Page Contains Element  ${Loc_EditProfile}  timeout=10s
    Click Element  ${Loc_EditProfile}
    Wait Until Page Contains Element  ${Loc_EditFName}  timeout=10s


Click To Edit EditProfile    
    Click Element  ${Loc_EditStdMenu}
    Click Element  ${Loc_ViewProfile}
    Wait Until Page Contains Element  ${Loc_EditProfile}  timeout=10s
    Click Element  ${Loc_EditProfile}
    Wait Until Page Contains Element  ${Loc_EditFName}  timeout=10s

Input Fill From EditProfile Excel
    [Arguments]  ${row}
    ${Firstname}  Read Excel Cell  ${row}  3
    ${Lastname}  Read Excel Cell  ${row}  4
    ${telephone}  Read Excel Cell  ${row}  5
    ${year_of_study}  Read Excel Cell  ${row}  6

    Run Keyword If  '${Firstname}' != '' and '${Firstname}' != '${None}'  
    ...  Input Text  ${Loc_EditFName}  ${Firstname}
    Run Keyword If  '${Lastname}' != '' and '${Lastname}' != '${None}'  
    ...  Input Text  ${Loc_EditLName}  ${Lastname}
    Run Keyword If  '${telephone}' != '' and '${telephone}' != '${None}'  
    ...  Input Text  ${Loc_EditPhone}  ${telephone}

    ${should_select}=    Evaluate    
    ...    '${year_of_study}' != '' and '${year_of_study}' != 'เลือกชั้นปี' and '${year_of_study}' != '${None}'
    Run Keyword If    ${should_select}    
    ...    Select From List By Label    ${Loc_EditYear}    ${year_of_study}



Upload EditProfile Image
    [Arguments]    ${row}
    ${image_name}  Read Excel Cell  ${row}  7
    Run Keyword If    '${image_name}' == ''    RETURN From Keyword
    Run Keyword If    '${image_name}' == 'None'    RETURN From Keyword

    ${image_name}=    Strip String    ${image_name}
    ${image_path}=    Catenate    SEPARATOR=    ${EXECDIR}/ExcelProject/Images/    ${image_name}
    Run Keyword And Ignore Error    Choose File    ${LocBTTImage}    ${image_path}
    Log To Console    Uploaded image: ${image_path}
    Run Keyword And Ignore Error    Wait Until Page Contains Element    ${LocBTTImage}    timeout=10s



Submit EditProfile Button
    Click Element    ${BtnSaveData}

    
 
Read Expected Result EditProfile
    [Arguments]  ${row}
    ${Expected}  Read Excel Cell  ${row}  11
    RETURN  ${Expected}


Read ActualResult Result EditProfile
    [Arguments]  ${row}
    ${ActualResult}  Read Excel Cell  ${row}  12
    RETURN  ${ActualResult}  


Get Visible Error Alert
    [Arguments]    @{locators}
    FOR    ${loc}    IN    @{locators}
        ${status}    Run Keyword And Return Status    Wait Until Element Is Visible    ${loc}    5s
        IF    ${status}
            ${status}    Get Text    ${loc}
            ${actualResult}=    Set Variable    ${status}
            Write Excel Cell    ${row}    12    ${actualResult}
            RETURN    ${actualResult}
        END
    END


Check Error And Verify Result
    [Arguments]    ${row}
    ${expected}=    Read Excel Cell    ${row}    11
    
    # Success Text
    ${status}    ${result}=    Run Keyword And Ignore Error    Get Text    ${success_form}
    ${success_text}=    Set Variable If    '${status}' == 'PASS'    ${result}    ${EMPTY}
    Run Keyword If    '${status}' == 'PASS'    Write Excel Cell    ${row}    12    ${success_text}

    #List of Error Locators
    ${locators}=    Create List
    ...    ${textErrorFName}    ${textErrorLName}    ${textErrorPhone}
    ...    ${textErrorYear}    ${textErrorPassword}    ${textErrorImage}
    ...    ${error_form}
    # Get Actual Error Text
    ${ActualResult}=    Get Visible Error Alert    @{locators}
    Run Keyword If    '${status}' != 'PASS'    Write Excel Cell    ${row}    12    ${ActualResult}
    
    # Verify Result
    ${is_pass1}=    Run Keyword And Return Status    Should Be Equal    ${expected}    ${success_text}
    ${is_pass2}=    Run Keyword And Return Status    Should Be Equal    ${expected}    ${ActualResult}
    
    IF    ${is_pass1} or ${is_pass2}
        Write Excel Cell    ${row}    13    Pass
    ELSE
        Write Excel Cell    ${row}    13    Fail
        ${screenshotFailed}=    Set Variable    ${screenshot}failed_row_${row}.png
        Capture Page Screenshot    ${screenshotFailed}
    END



Save And Close Excel EditProfile
    Save Excel Document  ${DataTableEditProfile}
    Close Current Excel Document

Close Browser EditProfile
    Close Browser