*** Settings ***
Library    SeleniumLibrary
Library    ExcelLibrary
Resource    ../Keywords/Keyword_EditProfile.robot
Resource    ../Variables/Variable_EditProfile.robot
*** Test Cases ***
Test Edit Profile From Excel
    Open Excel EditProfile
    FOR    ${i}    IN RANGE    2    ${Row}+1
        ${run}=    Read Excel Cell    ${i}    1
        IF    '${run}' == 'Y'
            Open Browser WebSite
            Click Login Menu
            Input Login
            Go To Edit Profile Page
            Input Fill From EditProfile Excel    ${i}
            Upload EditProfile image    ${i}
            Submit EditProfile
            ${actual}=    Get Actual EditProfile Result    ${i}
            Verify EditProfile Result    ${i}    ${actual}
            Close Browser EditProfile
        END
    END
    Save And Close Excel EditProfile