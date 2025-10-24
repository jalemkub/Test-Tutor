*** Settings ***
Library  SeleniumLibrary
Library  ExcelLibrary
Library    String

Resource  ../Variables/Variable_AddCourse.robot

*** Keywords ***
Open Excel Document File
    Open Excel Document    ${DataTableAddCourse}    ${Sheet}

Open Browser Page
    Open Browser  ${URL}  ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed  0.3s
Go Login
    Click Element    ${Loc_Go_Login}
    Sleep  2s

Login Form
    [Arguments]   ${Row}
    Input Text    ${Loc_Input_Email}    mju6504106383
    Input Text    ${Loc_Input_Password}    Ptt123445678##
    Click Element    ${Loc_Btn_Login}

Go Add Course
    Click Element   ${Loc_Go_AddCourse}

Fill Form Input Add Course
    [Arguments]    ${course_name}    ${course_type}    ${course_description}    ${course_quantity}    ${course_price}   
    ...    ${coursedate}  ${course_starttime}  ${course_endtime}    ${course_topic}
     
    Run Keyword If  '${course_name}' != '' and '${course_name}' != '${None}'  
    ...  Input Text    ${Loc_Course_Name}    ${course_name}

    # Run Keyword If  '${course_type}' != '' and '${course_type}' != '${None}'  Input Text    ${Loc_Course_Type}    ${course_type}


    ${should_select_type}=    Evaluate    '${course_type}' != '' and 
    ...    '${course_type}' != 'เลือกประเภทของวิชา' and '${course_type}' != None
    Run Keyword If    ${should_select_type}    
    ...    Select From List By Label    ${Loc_Course_Type}    ${course_type}


    Run Keyword If  '${course_description}' != '' and '${course_description}' != '${None}'  
    ...  Input Text    ${Loc_Course_Description}    ${course_description}


    ${should_select_Quantity}=    Evaluate    '${course_quantity}' != '' and 
    ...    '${course_quantity}' != 'เลือกจำนวนนักศึกษา' and '${course_quantity}' != None
    Run Keyword If    ${should_select_Quantity}    
    ...    Select From List By Label    ${Loc_Course_Qultity}    ${course_quantity}
    ...    

    Run Keyword If  '${course_price}' != '' and '${course_price}' != '${None}'  
    ...  Input Text    ${Loc_Course_Price}    ${course_price}

    # กรอกวันที่
    Run Keyword If    '${coursedate}' != '' and '${coursedate}' != '${None}'  
    ...    Set Date Input    ${Loc_Course_date}    ${coursedate}

    
    # กรอกเวลาเริ่ม
    ${start_time_formatted}=    Run Keyword If  '${course_starttime}' != '' and '${course_starttime}' != '${None}'  
    ...    Set Time Input From Excel   ${Loc_Course_StartTime}    ${course_starttime}

    # กรอกเวลาสิ้นสุดพร้อมตรวจสอบ > Start Time
    Run Keyword If  '${course_endtime}' != '' and '${course_endtime}' != '${None}'  
    ...    Set Time Input From Excel   ${Loc_Course_EndTime}  ${course_endtime}
    
    Run Keyword If  '${course_topic}' != '' and '${course_topic}' != '${None}'  
    ...  Input Text   ${Loc_Course_Topic}    ${course_topic}



#DATE
Convert Thai Full Year Date
    [Arguments]    ${ENG_date}           # เช่น 26/08/2568 หรือ datetime object

    # ถ้าค่าว่าง ให้ RETURN ว่างเลย
    Run Keyword If    '${ENG_date}' == '' or '${ENG_date}' == '${None}'   RETURN FROM KEYWORD    ${EMPTY}

    # ถ้าเป็น datetime object ให้แปลงเป็น string DD/MM/YYYY
    Run Keyword If    '${ENG_date.__class__.__name__}' == 'datetime' 
    ...    ${ENG_date}=    Convert To String    ${ENG_date.strftime("%d/%m/%Y")}

    ${split_date}=    Split String    ${ENG_date}    /  # แยกวัน/เดือน/ปี
    ${day}=          Set Variable    ${split_date[0]}
    ${day}=          Evaluate    str(${day}).zfill(2)
    ${month}=        Set Variable    ${split_date[1]}
    ${month}=        Evaluate    str(${month}).zfill(2)
    ${thai_year}=    Set Variable    ${split_date[2]}
    ${year}=         Evaluate        int(${thai_year}) - 543
    ${iso_date}=     Catenate        SEPARATOR=-    ${year}    ${month}    ${day}  # ISO format: YYYY-MM-DD
    RETURN           ${iso_date}




Set Date Input
    [Arguments]    ${locator}    ${date}
    Execute JavaScript    document.querySelector("${locator}").value="${date}"


#TIME
Set Time Input From Excel
    [Arguments]    ${locator}    ${time_excel}

    Run Keyword If    '${time_excel}' == '' or '${time_excel}' == '${None}' or '${time_excel}' == 'None' or '${time_excel}' == '-'    
    ...    RETURN FROM KEYWORD

    ${time_str}=    Convert To String    ${time_excel}
    ${time_str}=    Convert AMPM To 24Hour    ${time_str}

    ${split}=      Split String    ${time_str}    :
    ${hour}=       Convert To Integer    ${split[0]}
    ${minute}=     Convert To Integer    ${split[1]}

    ${hour_str}=   Evaluate    str(${hour}).zfill(2)
    ${minute_str}=  Evaluate    str(${minute}).zfill(2)
    ${time_str}=   Set Variable    ${hour_str}:${minute_str}

    Execute JavaScript    document.querySelector("${locator}").value = "${time_str}";
    Log To Console    Set time "${time_str}" in locator "${locator}"




Validate End Time
    [Arguments]    ${start_time}    ${end_time}
    ${start_time_24}=    Convert AMPM To 24Hour    ${start_time}
    ${end_time_24}=      Convert AMPM To 24Hour    ${end_time}

    ${split_start}=    Split String    ${start_time_24}    :
    ${start_hour}=     Convert To Integer    ${split_start}[0]
    ${start_min}=      Convert To Integer    ${split_start}[1]
    ${start_total}=    Evaluate    ${start_hour}*60 + ${start_min}

    ${split_end}=      Split String    ${end_time_24}    :
    ${end_hour}=       Convert To Integer    ${split_end}[0]
    ${end_min}=        Convert To Integer    ${split_end}[1]
    ${end_total}=      Evaluate    ${end_hour}*60 + ${end_min}

    Run Keyword If    ${end_total} <= ${start_total}    Fail    End time (${end_time}) must be after start time (${start_time})




Convert AMPM To 24Hour
    [Arguments]    ${ampm_time}

    ${ampm_time}=    Strip String    ${ampm_time}
    ${ampm_time}=    Replace String   ${ampm_time}    .    :

    ${has_ampm}=    Run Keyword And Return Status    Should Contain Any    ${ampm_time}    AM    PM
    Run Keyword If    not ${has_ampm}    RETURN FROM KEYWORD    ${ampm_time}

    ${parts}=    Split String    ${ampm_time}    ${SPACE}
    Run Keyword If    len(${parts}) != 2    Fail    Invalid time format: ${ampm_time}

    ${time_part}=    Strip String    ${parts[0]}
    ${ampm}=         Strip String    ${parts[1]}

    ${split}=    Split String    ${time_part}    :
    ${hour}=    Convert To Integer    ${split[0]}
    ${minute}=  Convert To Integer    ${split[1]}

    ${hour_24}=     Set Variable    ${hour}
    Run Keyword If    '${ampm}' == 'PM' and ${hour} < 12    ${hour_24}=    Evaluate    ${hour} + 12
    Run Keyword If    '${ampm}' == 'AM' and ${hour} == 12    ${hour_24}=    Set Variable    0

    ${hour_str}=     Evaluate    str(${hour_24}).zfill(2)
    ${minute_str}=   Evaluate    str(${minute}).zfill(2)
    ${converted}=    Set Variable    ${hour_str}:${minute_str}
    RETURN    ${converted}



Click Submit Form
    Click Element    ${Loc_Btn_AddCourse}

Select Date
    [Arguments]    ${course_date}
    Click Element    ${course_date}
    Input Text    ${course_date}    ${course_date}

Handle Alert Error
    [Arguments]    ${row}
    ${status}    ${msg}=    Run Keyword And Ignore Error    Handle Alert    accept
    Log To Console    ALERT STATUS: ${status}  MESSAGE: ${msg}
    Run Keyword If    '${status}' != 'PASS'    Write Excel Cell    ${row}    15    ${msg}
    Run Keyword And Ignore Error   Write Excel Cell    ${row}    15    ${msg}
    RETURN    ${status}

Check Success Form Add Course
    [Arguments]    ${row}
    ${Alert}  Run Keyword And Ignore Error    Get Text  ${Success_Msg}
    Log To Console    ${Alert}
    Run Keyword If    '${Alert}'=='PASS'    Write Excel Cell    ${row}    15    ${Alert}
    RETURN    ${Alert}

Read Expected Result
    [Arguments]  ${row}
    ${expected}    Read Excel Cell    ${row}    14
    RETURN  ${expected}

Read actual Result
    [Arguments]  ${row}
    ${actual}    Read Excel Cell    ${row}    15
    RETURN  ${actual}

Verify Add Course
    [Arguments]    ${row}  ${expected}  ${actual}
    ${flag}  Run Keyword And Return Status  Should Be Equal    ${expected}   ${actual}
    Log To Console    ${actual}  
    Log To Console    ${expected}

    IF  ${flag}
        Write Excel Cell    ${row}    16    Pass
    ELSE
        Write Excel Cell    ${row}    16    Fail
        ${screenshotFailed}=  Set Variable    ${screenshot}failed_row_${row}.png
        Capture Page Screenshot   ${screenshotFailed}
    END

Save Excel And Close
    Save Excel Document    ${DataTableAddCourse}
    Close Browser

Close Browser Page
    Close Browser
