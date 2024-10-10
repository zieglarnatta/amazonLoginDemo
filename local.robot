*** Settings ***
Documentation       Author: Roy Yap
...                 Creation date: Oct 9 2024
...                 Smoke Test the Amazon website
Library           SeleniumLibrary

*** Variables ***
${url}                https://www.amazon.com
${BROWSER}            headlessfirefox
${DELAY}              0.5
${accList}            //*[@id="nav-link-accountList"]/span
${text}               Account & Lists
${emailPhone}         //*[@id="ap_email"]
# element with text values
${signIn}              //*[@id="authportal-main-section"]/div[2]/div[2]/div[1]/form/div/div/div/h1
${emailOrMobile}       //*[@id="authportal-main-section"]/div[2]/div[2]/div[1]/form/div/div/div/div[1]/label
${continueButton}      //*[@id="continue-announce"]
${legal}               //*[@id="legalTextRow"]
${needHelp}            //*[@id="authportal-main-section"]/div[2]/div[2]/div[1]/form/div/div/div/div[3]/div/a/span
${buyForWork}          //*[@id="ab-signin-link-section"]/div/span

${new2Amazon}          //*[@id="authportal-main-section"]/div[2]/div[2]/div[2]/h5
${createAmAcc}         //*[@id="createAccountSubmit"]

&{DICTLogin}                ${signIn}=Sign in    ${emailOrMobile}=Email or mobile phone number    ${legal}=By continuing, you agree to Amazon's Conditions of Use and Privacy Notice.
...                    ${needHelp}=Need help?      ${buyForWork}=Buying for work?    ${continueButton}=Continue     ${new2Amazon}=New to Amazon?

# element with hyperlink values
${condOfUse}           //*[@id="legalTextRow"]/a[1]
${privacyNotice}       //*[@id="legalTextRow"]/a[2]
${shopAmBusiness}      //*[@id="ab-signin-ingress-link"]    https://www.amazon.com/business/register/welcome?ref_=ab_reg_signin
&{DICThyper}            ${condOfUse}=https://www.amazon.com/gp/help/customer/display.html/ref=ap_signin_notification_condition_of_use?ie=UTF8&nodeId=508088
...                     ${privacyNotice}=https://www.amazon.com/gp/help/customer/display.html/ref=ap_signin_notification_privacy_notice?ie=UTF8&nodeId=468496
...                     ${shopAmBusiness}=https://www.amazon.com/business/register/welcome?ref_=ab_reg_signin
@{elements}            //*[@id="ap_email"]    //*[@id="continue"]

*** Keywords ***
Open Browser To Login Page
    Open Browser                ${url}    ${BROWSER}  add_argument("--headless");add_argument("--start-maximized")   #uncomment this to use headless
    Maximize Browser Window
    Set Selenium Speed          ${DELAY}
    
Load Main Page
    Log To Console            Loading the main page
#    wait and assert that the login element is present
    Try Except Element With Value & Assertion        //*[@id="nav-link-accountList"]      Hello, sign in
    Try Except Element With Value & Assertion        //*[@id="nav-link-accountList"]       ${text}

#    click / hover on the dropdown and grab a screen shot to embed
    TRY
        Mouse Over                        //*[@id="nav-link-accountList"]
        Capture Page Screenshot                EMBED
    EXCEPT
        Log                                    Unable to mouse over        WARN
        Capture Page Screenshot                EMBED
    END

Check Title
    #validate the title of page landed
    Log To Console                Checking the title
    Try Except Title Assertion             Amazon.com. Spend less. Smile more.

Click the Yellow Sign In
    Log To Console                Clicking the Sign In Button
#    Wait, assert and click on the Sign in yellow button
    Try Except Element With Value & Assertion        //*[@id="nav-flyout-ya-signin"]/a/span       Sign in
    Try Except Click Element                        //*[@id="nav-flyout-ya-signin"]/a/span



Sign in page
    Log To Console                Begin validation of signin page elements
    Try Except Title Assertion             Amazon Sign-In
#    Check logo 
    Try Except Element Assertion                    //*[@id="a-page"]/div[1]/div[1]/div/a
#    Check Main box 
    Try Except Element Assertion                    //*[@id="authportal-main-section"]/div[2]/div[2]/div[1]/form/div/div/div
    
    FOR    ${key}    ${value}    IN    &{DICTLogin}
        Try Except Element With Value & Assertion        ${key}    ${value}
    END
    
    FOR    ${i}    IN   @{elements}
        Try Except Element Assertion        ${i}
    END

    Log To Console                Checking on URL elements:

    FOR    ${key}    ${value}    IN    &{DICThyper}
        Try Except hyperlinks        ${key}    ${value}
    END

Test text box
    FOR    ${i}    IN   yada@yada.com     2068675309      +12068675309      (206) 867-5309       206-867-5309
        TRY
            Input text      ${emailPhone}     ${i}     clear=True
            Capture Page Screenshot                EMBED
        EXCEPT
            Capture Page Screenshot                EMBED
            Log     Input Text ${i} at Email / Phone element ${emailPhone} is having an issue!             WARN
        END
    END
    

#Check Logos and Text

Try Except Title Assertion
    [Arguments]            ${title}
    Log To Console                Checkin page title
    TRY
        Title should be             ${title}
    EXCEPT
#        grab the page screen shot & embed into the automation log, also output in the console a warning of sorts
        Capture Page Screenshot                EMBED
        Log     Title ${title} not found!             WARN
    END

Try Except Element Assertion
    [Arguments]            ${element}
    Log To Console                Checking on element assertion
    TRY
        Element Should Be Visible            ${element}
    EXCEPT
#        grab the page screen shot & embed into the automation log, also output in the console a warning of sorts
        Capture Page Screenshot                EMBED
        Log     Element ${element} not found!             WARN
    END

Try Except Element With Value & Assertion
    [Arguments]            ${element}    ${value}
    Log To Console                Checking on element assertion with text value
    TRY
        Element Should Contain            ${element}        ${text}
    EXCEPT
        Capture Page Screenshot                EMBED
        Log     Element for ${text} at ${element} not found!       WARN
    END

Try Except Click element
    [Arguments]            ${element}
    Log To Console                Clicking on element / button
    TRY
        Click element            ${element}
    EXCEPT
        Capture Page Screenshot                EMBED
        Log     Element for link / button ${element} not found!       WARN
    END

Try Except hyperlinks
    [Arguments]            ${element}    ${value}
    Log To Console                Checking on element assertion with text value
    TRY
        Page Should Contain Link            ${element}        ${text}
    EXCEPT
        Capture Page Screenshot                EMBED
        Log     Hyperlink for ${text} at ${element} not found!       WARN
    END