*** Settings ***
Library      AppiumLibrary

*** Variables ***

${appium_server}     http://127.0.0.1:4726/wd/hub
${deviceType}        Android
${deviceName}        R9TWB14LB7F  #R58J46QJDTL  #
${appPackage}        com.amazon.mShop.android.shopping
${androidAutomation}    UiAutomator2
${logo}                 //android.widget.ImageView[@resource-id="com.amazon.mShop.android.shopping:id/sso_splash_logo"]
${signInToAcct}        //android.widget.TextView[@resource-id="com.amazon.mShop.android.shopping:id/signin_to_yourAccount"]
${viewWishList}        //android.widget.TextView[@resource-id="com.amazon.mShop.android.shopping:id/view_your_wish_list"]


@{elements}            ${logo}    ${signInToAcct}

${existingCust}        com.amazon.mShop.android.shopping:id/sign_in_button
${newCust}            com.amazon.mShop.android.shopping:id/new_user
${skipSignIn}        com.amazon.mShop.android.shopping:id/skip_sign_in_button
&{dictElemText}        ${existingCust}=Already a customer? Sign in    ${newCust}=New to Amazon.ca? Create an account    ${skipSignIn}=Skip sign in

*** Test Cases ***
Basic Smoketest
    [Documentation]    Basic fresh launch & get to landing page
    Open Test Application
    Capture screen shot
    Check Main components
    Check Buttons
    Skip sign in
    Close Application


*** Keywords ***
Open Test Application
    Log To Console        \nOpening the Amazon App
    open application      ${appium_server}  platformName=${deviceType}    deviceName=R9TW10K7ZJW    appPackage=${appPackage}
    ...    automationName=${androidAutomation}      #appActivity=com.amazon.mShop.android.shopping.Main  automationName=${androidAutomation}

Capture screen shot
    Log To Console        Capturing a screenshot
    Capture Page Screenshot

Check Main components
    Log To Console                checking main components
    FOR    ${i}    IN   @{elements}
        Try Except Element Assertion        ${i}
    END

Check Buttons
    Log To Console                Checking key buttons exists
    FOR    ${key}    ${value}    IN    &{dictElemText}
        Try Except Element With Value & Assertion        ${key}    ${value}
    END

Skip sign in
    Log To Console                Skip sign in and then log from middle button
    TRY
        Wait Until Element Is Visible        (//android.widget.ImageView[@resource-id="com.amazon.mShop.android.shopping:id/bottom_tab_button_icon"])[3]
        Element Should Be Visible            (//android.widget.ImageView[@resource-id="com.amazon.mShop.android.shopping:id/bottom_tab_button_icon"])[3]
        Click Element                        (//android.widget.ImageView[@resource-id="com.amazon.mShop.android.shopping:id/bottom_tab_button_icon"])[3]
    EXCEPT
        Capture Page Screenshot                EMBED
        Log     Element for Profile (//android.widget.ImageView[@resource-id="com.amazon.mShop.android.shopping:id/bottom_tab_button_icon"])[3] not found!             WARN
    END
    
    Log To Console                Verify & click the Sign in yellow button
    TRY
        Wait Until Element Is Visible    //android.view.ViewGroup[@content-desc="sib"]    
        Element Should Be Visible        //android.view.ViewGroup[@content-desc="sib"]
        Click Element                    //android.view.ViewGroup[@content-desc="sib"]
    EXCEPT
        Capture Page Screenshot                EMBED
        Log     Element for Sign in //android.view.ViewGroup[@content-desc="sib"] not found!             WARN
    END

    Log To Console                Verify & click the Sign in yellow button
    TRY
        Wait Until Element Is Visible    ap_email_login    
        Element Should Be Visible        ap_email_login
        Click Element                    ap_email_login
    EXCEPT
        Capture Page Screenshot                EMBED
        Log     Element for Sign in //android.view.ViewGroup[@content-desc="sib"] not found!             WARN
    END
    
    TRY
        Wait Until Element Is Visible    //android.widget.Button[@resource-id="continue"]
        Element Should Be Visible        //android.widget.Button[@resource-id="continue"]
        Click Element                    //android.widget.Button[@resource-id="continue"]
    EXCEPT
        Capture Page Screenshot                EMBED
        Log     Element for Continue //android.widget.Button[@resource-id="continue"] not found!             WARN
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
        Wait Until Element Is Visible        ${element}
        Element Should Contain            ${element}        ${text}
    EXCEPT
        Capture Page Screenshot                EMBED
        Log     Element for ${text} at ${element} not found!       WARN
    END