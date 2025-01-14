@echo off

set FILE_NAME=CUBRID ADO.NET Data Provider 11.2.1.0003

if "%VS2017COMNTOOLS%x" == (
    echo "Please add 'VS2017COMNTOOLS' in the environment variable\n ex) C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\Common7\Tools"
    GOTO :EOF
)

cd ..\..\Code\Src
call "%VS2017COMNTOOLS%VsDevCmd.bat"
devenv CUBRID.Data.CUBRIDClient.csproj /rebuild "Release|Any CPU" 
cd ..\..\Installer\nsis
rd /s/q Build
md Build

makensis CUBRID.nsi

copy "%FILE_NAME%.exe" Build\
del /q "%FILE_NAME%.exe"

rd /s/q "%FILE_NAME%"
md "%FILE_NAME%"
copy "BSD License.txt" "%FILE_NAME%"\
copy "cascci32.dll" "%FILE_NAME%"\
copy "cascci64.dll" "%FILE_NAME%"\
copy "Release Notes.txt" "%FILE_NAME%"\
copy "..\..\Code\Src\bin\Release\CUBRID.Data.dll" "%FILE_NAME%"\
copy "..\..\Documentation\CUBRID ADO.NET Data Provider.chm" "%FILE_NAME%"\
7za a "%FILE_NAME%.zip" -tzip "%FILE_NAME%"
rd /s/q "%FILE_NAME%"

move "%FILE_NAME%.zip" Build\
