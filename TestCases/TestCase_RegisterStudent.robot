*** Settings ***
Library    SeleniumLibrary
Library    ExcelLibrary
Resource    ../Keywords/Keyword_RegisterStudent.robot
Resource    ../Variables/Variable_RegisterStudent.robot
*** Test Cases ***
Test Register Student
    Open Excel Student
    FOR  ${i}  IN RANGE  2  ${Row}+1
        ${Execute}=  Read Excel Cell  ${i}  1
         IF  '${Execute}' == 'Y'
            Open Browser WebSite
            Click go To From Register
            Input Fill From Excel  ${i}
            Upload Student Image  ${i}
            Submit Register Button
            ${ActualResult}=  Get Visible Register Student Message  ${i}
            Read Expected Result RegisterStudent  ${i}
            Read ActualResult Result RegisterStudent    ${i}
            Verify Register Student Result  ${i}
            Close Browser Register Student
        END
    END
    Save And Close Excel Register Student



    