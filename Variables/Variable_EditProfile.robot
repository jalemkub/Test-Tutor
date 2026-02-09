*** Settings ***
Library    SeleniumLibrary
Library    ExcelLibrary

*** Variables ***
${URL}       http://localhost:8080/wep-tutor/
${BROWSER}   chrome

${DataTableEditProfile}    ExcelProject/EditProfile.xlsx
${Sheet}                  EditProfile
${Row}                    51

${screenshot}    Screenshots_EditProfile/

# Login
${Loc_LoginMenu}    //a[contains(text(),'เข้าสู่ระบบ ▼')]
${Loc_Login}        //a[@href='goLogin']
${Loc_Username}     //input[@id='email_prefix']
${Loc_Password}     //input[@id='password']
${Loc_BtnLogin}     //input[@value='เข้าสู่ระบบ']

# Edit Profile Menu
${Loc_EditStdMenu}   //a[contains(text(),'นักศึกษา ▼')]
${Loc_ViewProfile}   //a[contains(text(),'ดูโปรไฟล์')]
${Loc_EditProfile}   //a[contains(text(),'แก้ไขโปรไฟล์')]

# Input
${Loc_EditFName}     //input[@id='fname']
${Loc_EditLName}     //input[@id='lname']
${Loc_EditPhone}     //input[@id='phon_num']
${Loc_EditYear}      //select[@id='yfs']
${LocBTTImage}       //input[@id='image']

${BtnSaveData}       //input[@value='บันทึก']

# Result
${textErrorFName}    //span[@id='err_fname']
${textErrorLName}    //span[@id='err_lname']
${textErrorPhone}    //span[@id='err_phone']
${textErrorYear}     //span[@id='err_yfs']
${textErrorImage}    //span[@id='err_image']
${success_form}      //div[@id='editMessage']
${error_form}        //p[@class='error']

