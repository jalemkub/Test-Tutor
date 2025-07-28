*** Settings ***
Library    SeleniumLibrary
Library    ExcelLibrary
Resource    ../Variables/Variable_SearchCourse.robot
Resource    ../Keywords/Keyword_SearchCourse.robot
*** Test Cases ***
Test Search Course
    Open Excel  ${DataSearchCourse}  ${sheet}
    FOR  ${i}  IN RANGE  2  ${Row}+1
        ${Execute}  Read Excel Cell  ${i}  1
        IF  '${Execute}' == 'Y'
            Open Browser WebSite
            ${Search}  Read Excel Cell  ${i}  3
            Fill Search Form  ${Search}
            Submit Search Form
            ${Expected}  Read Expected Result From Excel Search Course  ${i}
            Alert Message and Get Text  ${i}
            Close WebSite Browser
        END
    END
    Save Excel Search Course
    Close Excel Current Document
    