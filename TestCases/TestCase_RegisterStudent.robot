*** Settings ***
Library    SeleniumLibrary
Library    ExcelLibrary
Resource    ../Keywords/Keyword_RegisterStudent.robot
Resource    ../Variables/Variable_RegisterStudent.robot
*** Test Cases ***
Register Student
    Open Excel  ${DataTableRegisterStudent}  ${Sheet}
    FOR  ${i}  IN RANGE  2  ${Row}+1
        ${Execute}  Read Excel Cell  ${i}  1
        IF  '${Execute}' == 'Y'
            Open Browser WebSite
            Click go To From Register
            ${student_id}  Read Excel Cell  ${i}  3
            ${email}  Read Excel Cell  ${i}  4
            ${Firstname}  Read Excel Cell  ${i}  5
            ${Lastname}  Read Excel Cell  ${i}  6
            ${telephone}  Read Excel Cell  ${i}  7
            ${year_of_study}  Read Excel Cell  ${i}  8
            ${Image}  Read Excel Cell  ${i}  9
            ${password}  Read Excel Cell  ${i}  10
            ${Expected}  Read Expected Result RegisterStudent  ${i}  11
            Input Fill From Excel  ${student_id}  ${email}  ${Firstname}  ${Lastname}  ${telephone}  ${Image}  ${year_of_study}  ${password}
            Click Register Button
            ${ActualResult}=  Get All Error Messages
            Write Actual Result RegisterStudent  ${i}  ${ActualResult}
            Verify Equal Result RegisterStudent  ${i}  ${ActualResult}
            # ${Expected} 
            Close Browser Register Student
        END
    END
    Save Excel Register Student

    