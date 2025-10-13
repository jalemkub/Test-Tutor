*** Settings ***
Library    SeleniumLibrary
Library    ExcelLibrary

Resource    ../Variables/Variable_LoginAdmin.robot
Resource    ../Keywords/Keyword_LoginAdmin.robot

*** Test Cases ***
Test Login Admin
    Open Excel file
    FOR  ${i}  IN RANGE  2  ${Row}+1
        ${Execute}=  Read Excel Cell  ${i}  1
        IF  '${Execute}' == 'Y'
            Open Page Browser
            GO to page Login
            ${email}=  Read Excel Cell  ${i}  3
            ${Password}=  Read Excel Cell  ${i}  4
            Fill Form Login  ${email}  ${Password}
            Submit Login
            ${Expected}=  Read Expected Result Login  ${i}
            Check Alert  ${i}
            Check Error  ${i}
            Check Success  ${i}
            ${actualresult}=  Read Actual Result Login  ${i}
            ${flag}=  Verify Equal Result Login  ${i}  ${Expected}  ${actualresult}
            Sleep    2s
            Close Browser Login
        END
    END
    Save Excel Login And Close
   Close Browser Login
