*** Settings ***
Library    SeleniumLibrary
Library    ExcelLibrary
Library    String
Library    OperatingSystem

Resource   ../Variables/Variable_EditProfile.robot

*** Keywords ***
Open Excel EditProfile
    Open Excel Document    ${DataTableEditProfile}    ${Sheet}

Open Browser WebSite
    Open Browser    ${URL}    ${BROWSER}    options=add_experimental_option('detach',True)
    Maximize Browser Window
    # Set Selenium Speed    0.3s

Click Login Menu
    Click Element    ${Loc_LoginMenu}
    Click Element    ${Loc_Login}

Input Login
    Wait Until Element Is Visible    ${Loc_Username}    10s
    Input Text    ${Loc_Username}    mju6504106336
    Input Text    ${Loc_Password}    Ptt123445678##
    Click Element    ${Loc_BtnLogin}

Go To Edit Profile Page
    Wait Until Element Is Visible    ${Loc_EditStdMenu}    10s
    Click Element    ${Loc_EditStdMenu}
    Click Element    ${Loc_ViewProfile}
    Wait Until Element Is Visible    ${Loc_EditProfile}    10s
    Click Element    ${Loc_EditProfile}

Input Fill From EditProfile Excel
    [Arguments]    ${row}

    ${fname}=    Read Excel Cell    ${row}    3
    ${lname}=    Read Excel Cell    ${row}    4
    ${phone}=    Read Excel Cell    ${row}    5
    ${year}=     Read Excel Cell    ${row}    6

    Clear And Input    ${Loc_EditFName}    ${fname}
    Clear And Input    ${Loc_EditLName}    ${lname}
    Clear And Input    ${Loc_EditPhone}    ${phone}

    ${select_year}=    Evaluate    $year not in ['', 'None', 'เลือกชั้นปี']
    Run Keyword If    ${select_year}
    ...    Select From List By Label    ${Loc_EditYear}    ${year}

Clear And Input
    [Arguments]    ${locator}    ${value}
    Click Element    ${locator}
    Press Keys       ${locator}    CTRL+A
    Press Keys       ${locator}    DELETE
    Run Keyword If   '${value}' not in ['', 'None']
    ...    Input Text    ${locator}    ${value}

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

Submit EditProfile
    Click Element    ${BtnSaveData}

Get Actual EditProfile Result
    [Arguments]    ${row}

    ${result}=    Set Variable    EMPTY

    ${success_status}    ${success_text}=    Run Keyword And Ignore Error
    ...    Get Text    ${success_form}

    IF    $success_status == 'PASS' and $success_text != ''
        Write Excel Cell    ${row}    9    ${success_text}
        ${result}=    Set Variable    ${success_text}
        RETURN    ${result}
    END

    ${locators}=    Create List
    ...    ${textErrorFName}
    ...    ${textErrorLName}
    ...    ${textErrorPhone}
    ...    ${textErrorYear}
    ...    ${textErrorImage}
    ...    ${error_form}

    FOR    ${loc}    IN    @{locators}
        ${error_status}=    Run Keyword And Return Status
        ...    Wait Until Element Is Visible    ${loc}    3s
        IF    ${error_status}
            ${error_text}=    Get Text    ${loc}

            IF    $error_text != '' and $error_text != 'None'
                Write Excel Cell    ${row}    9    ${error_text}
                ${result}=    Set Variable    ${error_text}
                RETURN    ${result}

            END
        END
    END

    ${result}=    Set Variable    ERROR:No Message Found
    Write Excel Cell    ${row}    9    No Message Found
    RETURN    ${result}


Verify EditProfile Result
    [Arguments]    ${row}    ${actual}

    ${expected}=    Read Excel Cell    ${row}    8

    

    ${flag}=    Run Keyword And Return Status    Should Be Equal    ${expected}    ${actual}
    Log To Console    Expected: ${expected}    
    Log To Console    Actual: ${actual}
    Log To Console    ROW:${{${row}-1}}

    IF    ${flag}
        Write Excel Cell    ${row}    10    Pass
    ELSE
        Write Excel Cell    ${row}    10    Fail
        ${screenshotFailed}=    Set Variable    ${screenshot}failed_row_${row}.png
        Capture Page Screenshot    ${screenshotFailed}
    END

Save And Close Excel EditProfile
    Save Excel Document  ${DataTableEditProfile}
    Close Current Excel Document

Close Browser EditProfile
    Close Browser