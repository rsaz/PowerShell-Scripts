<#
.SYNOPSIS
    PowerShell script to create python project template
.DESCRIPTION
	This script creates a basic python project structure including docs, examples, source, and test folders. Also contains a requirements.txt,
    and a basic setup.py and setup.cfg
.EXAMPLE
	PS> ./create-proj
	Project name: "your project name" <CONFIRM>
	...
.LINK
	https://github.com/rsaz/PowerShell-Scripts/blob/main/Scripts/Python/create-proj.ps1
.NOTES
	Author: Richard Zampieri
#>


try {
    # Variable declarations
    $gitignore = "https://raw.githubusercontent.com/rsaz/PowerShell-Scripts/main/Scripts/Python/Data/.gitignore"
    $projectName = Read-Host -Prompt 'Project name '

    # Create a python project boilerplate
    Write-Output "=> Generating Python Project -----------------------------------"

    # Create Folder Structure
    New-Item $projectName -ItemType Directory
    Set-Location $projectName
    New-Item docs, examples, source, tests -ItemType Directory
    New-Item requirements.txt

    # Setting up Main
    Set-Location source
    New-Item main.py, __init__.py
    New-Item $projectName"_package" -ItemType Directory
    Set-Location $projectName"_package"
    New-Item $projectName".py", __init__.py
    Set-Location ..\..\
    Set-Location tests
    New-Item $projectName"_package" -ItemType Directory
    Set-Location $projectName"_package"
    New-Item "test_${projectName}_package.py"

    # Downloading gitgnore
    Set-Location ..\..\
    Invoke-WebRequest -Uri $gitignore -OutFile .\.gitignore

    # Create a python environment
    Write-Output "=> Creating Python Enviornment -----------------------------------"
    py -m venv venv

    # Activating python environment
    Write-Output "=> Activating Python Enviornment -----------------------------------"
    Set-Location .\venv\Scripts\
    .\activate

    # Updating Pip
    Write-Output "=> Updating pip -----------------------------------"
    Set-Location ..\..\
    py -m pip install --upgrade pip

    # Installing basic dependencies
    Write-Output "=> Installing basic dependencies -----------------------------------"
    py -m pip install autopep8 pytest

    # Updating dependencies
    Write-Output "=> Updating project dependencies -----------------------------------"
    py -m pip freeze > requirements.txt

    # Finalizing the project creation
    Write-Output "=> Project created successfully -----------------------------------"    
}
catch {
    Write-Host "An error occurred:"
    Write-Host $_.ScriptStackTrace
}



