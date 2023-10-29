*** Settings ***
Resource        ../resources/serve-rest-front.resource

Suite Setup     Register user and log in


*** Test Cases ***
Login com sucesso Serve Rest Front
    Open Navigator
    Go to Serve Rest Front website
    Signup a user
    Check if the user was created

Check if the new user is in the userlist
    Open the Site Serve Rest Front login
    Get user list
    Check if there is the an user in a list

Create product and get in the list
    Open the Site Serve Rest Front login
    Register a new product
    Check if there is the product in the product list

Creating new user using HTTP requests
    Open Navigator
    Go to Serve Rest Front website
    Create a new user by API
    Login with the new user via API

Using Storage in the context
    Open the Site Serve Rest Front login
    Get user list
