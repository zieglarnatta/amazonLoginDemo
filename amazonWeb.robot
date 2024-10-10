*** Settings ***
Documentation       Author: Roy Yap
...                 Creation date: Oct 9 2024
...                 Smoke Test the Amazon website
Suite Setup         Open Browser To Login Page
Suite Teardown      Close Browser
Resource            local.robot

*** Test Cases ***
Load The Main Page
    [Tags]        smoketest    login
    Load Main Page
    Check Title
    Click the Yellow Sign In

Sign in page
    [Tags]        smoketest    login    signin
    Sign in page
    Test text box




