# Variable declarations
$gitignore = "/Scripts/Python/Data/.gitignore"

# Create a python project boilerplate
Write-Output "Generating Python Project . . ."

# Create Folder Structure
New-Item project-template -ItemType Directory
Set-Location project-template
New-Item docs, examples, source, tests -ItemType Directory
New-Item requirements.txt

# Setting up Main
Set-Location source
New-Item main.py, __init__.py
New-Item package_name -ItemType Directory
Set-Location package_name
New-Item my_package.py, __init__.py
Set-Location ..

# Downloading gitgnore
Write-Output "Downloading .gitgnore"
Set-Location ..
Invoke-WebRequest -Uri $gitignore -OutFile .\.gitignore

# Create a python environment
Write-Output "Creating Python Enviornment . . ."
py -m venv venv

# Activating python environment
Write-Output "Activating Python Enviornment . . ."
Set-Location .\venv\Scripts\
.\activate

# Installing basic dependencies
Write-Output "Installing basic dependencies"
Set-Location ..\..\
py -m pip install autopep8 pytest

# Updating dependencies
Write-Output "Updating project dependencies . . ."
py -m pip freeze > requirements.txt

# Finalizing the project creation
Write-Output "Project created successfully"