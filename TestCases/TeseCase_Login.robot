*** Settings ***
Library    SeleniumLibrary
Library    ExcelLibrary

Resource    ../Variables/Variable_Login.robot
Resource    ../Keywords/Keyword_Login.robot

*** Test Cases ***
Register Student
    Open Excel  ${DataTableRegisterStudent}  ${Sheet}
    FOR  ${i}  IN RANGE  2  ${Row}+1
        ${Execute}=  Read Excel Cell  ${i}  1
        IF  '${Execute}' == 'Y'
            Open Browser WebSite
            Go to page Login
            ${email}=  Read Excel Cell  ${i}  3
            ${password}=  Read Excel Cell  ${i}  4
            Fill Form Login  ${email}  ${password}
            Submit Login
            ${Expected}=  Read Expected Result Login  ${i}
            Alert Login  ${i}  ${Expected}
            ${actualresult}=  Read Excel Cell  ${i}  5
            Should Be Equal As Strings  ${Expected}  ${actualresult}
            Close Browser Login
        END
    END
   Save Excel Login
   Close Excel Login
   Close Browser Login
