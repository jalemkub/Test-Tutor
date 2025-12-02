*** Settings ***
Library    SeleniumLibrary
Library    ExcelLibrary

*** Variables ***
#website URL and Browser
${URL}    http://localhost:8080/wep-tutor/
${BROWSER}    chrome
${DataTableEditProfile}  ExcelProject/EditProfile.xlsx
${Sheet}    EditProfile
${Loc_LoginMenu}  //a[contains(text(),'เข้าสู่ระบบ ▼')]
${Loc_Login}  //a[@href='goLogin']
${LocImageFile}  ExcelProject/Images/


# screenshot Fail
${screenshot}  Screenshots_EditProfile/


#row Excel
${Row}  80


#Fill Login
${Loc_Username}    //input[@id='email_prefix']
${Loc_Password}    //input[@id='password']
${Loc_BtnLogin}    //input[@value='เข้าสู่ระบบ']


#Locator Edit Fpofile
${Loc_EditStdMenu}    //a[contains(text(),'นักศึกษา ▼')]
${Loc_ViewProfile}    //a[contains(text(),'ดูโปรไฟล์')]   
${Loc_EditProfile}    //a[contains(text(),'✏️ แก้ไขโปรไฟล์')] 





#Input Fill Locators
${Loc_EditFName}    //input[@id='fname']
${Loc_EditLName}    //input[@id='lname']
${Loc_EditPhone}    //input[@id='phon_num']
${Loc_EditYear}    //select[@id='yfs']
${LocBTTImage}    //input[@id='image']


#button Save Data
${BtnSaveData}  //input[@value='บันทึก']



#Text Error Locators
${textErrorFName}  //span[@id='err_fname']

${textErrorLName}  //span[@id='err_lname']

${textErrorPhone}  //span[@id='err_phone']

${textErrorPassword}  //span[@id='err_password']

${textErrorImage}  //span[@id='err_image']

${textErrorYear}  //span[@id='err_yfs']

${TextErrorOverSizeImage}  //span[@id='err_image']

${error_form}  //p[@class='error']


#Text Success Locators
${success_form}  //p[@class='success']