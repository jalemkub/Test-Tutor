*** Settings ***
Library    SeleniumLibrary
Library    ExcelLibrary
Resource    ../Keywords/Keyword_RegisterStudent.robot
Resource    ../Variables/Variable_RegisterStudent.robot
*** Test Cases ***
*** Test Cases ***
Register Student
    Open Excel  ${DataTableRegisterStudent}  ${Sheet}
    FOR  ${i}  IN RANGE  2  ${Row}+1
        ${Execute}=  Read Excel Cell  ${i}  1
        IF  '${Execute}' == 'Y'
            Open Browser WebSite
            Click go To From Register

            ${student_id}=       Read Excel Cell  ${i}  3
            ${Firstname}=        Read Excel Cell  ${i}  4
            ${Lastname}=         Read Excel Cell  ${i}  5
            ${telephone}=        Read Excel Cell  ${i}  6
            ${year_of_study}=    Read Excel Cell  ${i}  7
            ${email}=            Read Excel Cell  ${i}  8
            ${password}=         Read Excel Cell  ${i}  9
            ${image_name}=       Read Excel Cell  ${i}  10

            ${Expected}=  Read Expected Result RegisterStudent  ${i}
            Input Fill From Excel  ${student_id}  ${Firstname}  ${Lastname}  ${telephone}  ${year_of_study}  ${email}  ${password}
            Upload Student Image   ${image_name}
            Submit Register Button
            ${ActualResult}=  Get All Error Messages  ${i}
            Verify Equal Result RegisterStudent  ${i}  ${Expected}  ${ActualResult}

            Close Browser Register Student
        END
    END
    Save Excel Register Student
    Close Excel Register Student





    