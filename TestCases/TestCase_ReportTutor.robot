*** Settings ***
Library    SeleniumLibrary
Library    ExcelLibrary
Library    ../Keywords/screenshot_helper.py
Resource    ../Variables/Variable_ReportTutor.robot
Resource       ../Keywords/Keyword_ReportTutor.robot

*** Test Cases ***
Report Tutor Test Case
    FOR    ${i}    IN RANGE    2    ${Row}+1
        ${Execute}    Read Excel Cell    ${i}    1
        IF    '${Execute}' == 'Y'
            Open File Excel of Report Tutor
            Open Browser Website
            Login As User    ${i}
            Go To My Course Page
            Input From ReportTutor    ${i}
            Submit Report Tutor
            Check Alert Present    ${i}
            Success alert    ${i}
            Verify Report Tutor    ${i}
            Close Browser
        END
    END
    Save and Close Excel Report Tutor