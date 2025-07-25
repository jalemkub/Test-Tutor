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
            # Wait Until Page Contains Element  ${locGetText}  timeout=5s
            ${Expected}  Read Expected Result From Excel Search Course  ${i}
            ${ActualValidation}  ${ActualGetText}  Get Validation Message Search Course  ${Search}
            Write Actual Result To Excel  ${i}  ${Expected}  ${ActualValidation}  ${ActualGetText}
            Verify Equal Result Search Course  ${i}  ${Expected}  ${ActualValidation}  ${ActualGetText}
            Close WebSite Browser
        END
    END
    Save Excel Search Course
    Close Excel Document
    