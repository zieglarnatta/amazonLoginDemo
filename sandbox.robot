*** Settings ***
Documentation       Author: Roy Yap
...                 Creation date: Oct 9 2024
...                 Smoke Test the Amazon website
Suite Setup         Open Browser To Login Page
Suite Teardown      Close Browser
Library           SeleniumLibrary


*** Variables ***
${url}            https://www.amazon.com
${BROWSER}        headlessfirefox
${DELAY}          0.5
${accList}        //*[@id="nav-link-accountList"]/span
${text}           Account & Lists
${a}              //*[@id="authportal-main-section"]/div[2]/div[2]/div[1]/form/div/div/div/h1
${b}              //*[@id="authportal-main-section"]/div[2]/div[2]/div[1]/form/div/div/div/div[1]/label
&{DICT}            ${a}=Sign in    ${b}=Email or mobile phone number

*** Test Cases ***
test dictionary
    Test Dict

*** Keywords ***
Test Dict
    FOR  ${key}    ${value}    IN    &{DICT}
        log to console        this is the key: ${key} and this is the value: ${value}
    END

Open Browser To Login Page
    Open Browser                ${url}    ${BROWSER}  add_argument("--headless");add_argument("--start-maximized")   #uncomment this to use headless
    Maximize Browser Window
    Set Selenium Speed          ${DELAY}
    Capture Page Screenshot                EMBED