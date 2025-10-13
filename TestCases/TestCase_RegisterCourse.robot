*** Settings ***
Library    SeleniumLibrary
Library    ExcelLibrary
Resource    ../Keywords/Keyword_RegisterCourse.robot
Resource    ../Variables/Variable_RegisterCourse.robot

*** Test Cases ***
Test RegisterCourse
    Open Excel Document File
    FOR  ${i}  IN RANGE  2  ${Row}+1
        ${Execute}=  Read Excel Cell  ${i}  1
        IF  '${Execute}' == 'Y'
            Open Browser Page
            Go Login
            Login Form  ${i}
            Go RegisterCourses
            Click RegisterCourse
            Read Expected Result Register Course  ${i}
            Read Excel Checkbox  ${i}
            Submit RegisterCourse
            Check Success RegisterCourse  ${i}
            Read ActualResult Result Register Course  ${i}
            ${expected}=  Read Excel Cell  ${i}  6
            ${actual}=  Read Excel Cell  ${i}  7
            Verify RegisterCourse  ${i}  ${expected}  ${actual}
            Close Browser Page
        END
    END
    Save Excel File RegisterCourse
    Close Excel File RegisterCourse