*** Settings ***
Library  SeleniumLibrary
Library  ExcelLibrary
Resource  ../Keywords/Keyword_AddCourse.robot
Resource  ../Variables/Variable_AddCourse.robot

***Test Cases ***
Test AddCourse
    Open Excel Document File
    FOR    ${i}    IN RANGE    2    ${Row}+1
        ${Execute}=  Read Excel Cell    ${i}    1
        IF   '${Execute}' == 'Y'
            Open Browser Page
            Go Login
            Login Form    ${i}
            Go Add Course     
            ${course_name}=    Read Excel Cell    ${i}   3
            ${course_type}=    Read Excel Cell    ${i}   4
            ${course_description}=    Read Excel Cell    ${i}   5
            ${course_quantity}=    Read Excel Cell    ${i}   6
            ${course_price}=    Read Excel Cell    ${i}   7
            ${thai_date}=    Read Excel Cell    ${i}    8
            ${course_date}=   Convert Thai Full Year Date    ${thai_date}
            ${course_starttime}=  Read Excel Cell    ${i}    9
            ${course_endtime}=    Read Excel Cell    ${i}    10
            ${course_topic}=     Read Excel Cell    ${i}    11
            Fill Form Input Add Course    ${course_name}    ${course_type}    ${course_description}    ${course_quantity}    
            ...    ${course_price}    ${course_date}    ${course_starttime}    ${course_endtime}    ${course_topic}
            Set Time Input From Excel   ${Loc_Course_StartTime}  ${course_starttime}
            Set Time Input From Excel   ${Loc_Course_EndTime}  ${course_endtime}
            Click Submit Form
            Handle Alert Error    ${i}
            Check Success Form Add Course    ${i}
            ${Expected}=    Read Expected Result    ${i}
            ${Actual}=    Read Actual Result    ${i}
            Verify Add Course    ${i}    ${Expected}    ${Actual}
            Sleep    2s
            Close Browser Page
        END
    END
    Save Excel And Close