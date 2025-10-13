*** Settings ***
Library  SeleniumLibrary
Library  ExcelLibrary

*** Variables ***
${URL}  http://localhost:8080/SpringMVCProject/
${BROWSER}  chrome

${Sheet}  AddCourse
${DataTableAddCourse}  ExcelProject/AddCourse.xlsx
${Row}  73

${Screenshot}  screenshotAddCourse/



${Loc_Go_AddCourse}  //a[contains(text(),'เพิ่มคอร์ส')]
${Loc_Go_Login}   //img[@alt='Login']
${Loc_Input_Email}  //input[@id='email_prefix']
${Loc_Input_Password}  //input[@id='password']
${Loc_Btn_Login}  //input[@value='เข้าสู่ระบบ']

${Loc_Course_Name}  //input[@id='courseName']
${Loc_Course_Type}  //input[@id='cateName']
${Loc_Course_Description}  //textarea[@name='courseDescrip']
${Loc_Course_Qultity}  //select[@name='maxStu']  #dropdown
${Loc_Course_Price}  //input[@id='price']
${Loc_Course_date}  input#classDate
${Loc_Course_StartTime}  input#startTime
${Loc_Course_EndTime}    input#endTime
${Loc_Course_Topic}  //input[@id='topicName']
${Loc_Btn_AddCourse}  //input[@value='Submit']

# ${Error}

#Success
${Success_Msg}  .success-msg
# //div[@class='success-msg']