*** Settings ***
Library    SeleniumLibrary
Library    ExcelLibrary
Resource    ../Variables/Variable_ReportTutor.robot
Resource       ../Keywords/Keyword_ReportTutor.robot

*** Test Cases ***
Report Tutor Test Case
    Open File Excel of Report Tutor
    FOR    ${i}    IN RANGE    2    ${Row}+1
        ${Execute}    Read Excel Cell    ${i}    1
        IF    '${Execute}' == 'Y'
            Open Browser Website
            Login As User    ${i}
            Go To My Course Page
            Input From ReportTutor    ${i}
            Submit Report Tutor
            Alert form Report Tutor    ${i}
            Success form Report Tutor    ${i}
            Check Error form Report Tutor    ${i}
            ${expected}=    Read Expected Result Report Tutor    ${i}
            ${actual}=    Read Actual Result Report Tutor    ${i}
            Verify Report Tutor    ${i}    ${expected}    ${actual}
            Close Browser
        END
    END
    Save and Close Excel Report Tutor