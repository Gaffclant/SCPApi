@rem
@rem Copyright 2015 the original author or authors.
@rem
@rem Licensed under the Apache License, Version 2.0 (the "License");
@rem you may not use this file except in compliance with the License.
@rem You may obtain a copy of the License at
@rem
@rem      https://www.apache.org/licenses/LICENSE-2.0
@rem
@rem Unless required by applicable law or agreed to in writing, software
@rem distributed under the License is distributed on an "AS IS" BASIS,
@rem WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
@rem See the License for the specific language governing permissions and
@rem limitations under the License.
@rem

@if "%DEBUG%" == "" @echo off
@rem ##########################################################################
@rem
@rem  SCPApi startup script for Windows
@rem
@rem ##########################################################################

@rem Set local scope for the variables with windows NT shell
if "%OS%"=="Windows_NT" setlocal

set DIRNAME=%~dp0
if "%DIRNAME%" == "" set DIRNAME=.
set APP_BASE_NAME=%~n0
set APP_HOME=%DIRNAME%..

@rem Resolve any "." and ".." in APP_HOME to make it shorter.
for %%i in ("%APP_HOME%") do set APP_HOME=%%~fi

@rem Add default JVM options here. You can also use JAVA_OPTS and SCP_API_OPTS to pass JVM options to this script.
set DEFAULT_JVM_OPTS=

@rem Find java.exe
if defined JAVA_HOME goto findJavaFromJavaHome

set JAVA_EXE=java.exe
%JAVA_EXE% -version >NUL 2>&1
if "%ERRORLEVEL%" == "0" goto execute

echo.
echo ERROR: JAVA_HOME is not set and no 'java' command could be found in your PATH.
echo.
echo Please set the JAVA_HOME variable in your environment to match the
echo location of your Java installation.

goto fail

:findJavaFromJavaHome
set JAVA_HOME=%JAVA_HOME:"=%
set JAVA_EXE=%JAVA_HOME%/bin/java.exe

if exist "%JAVA_EXE%" goto execute

echo.
echo ERROR: JAVA_HOME is set to an invalid directory: %JAVA_HOME%
echo.
echo Please set the JAVA_HOME variable in your environment to match the
echo location of your Java installation.

goto fail

:execute
@rem Setup the command line

set CLASSPATH=%APP_HOME%\lib\SCPApi-1.0-SNAPSHOT.jar;%APP_HOME%\lib\selenium-java-2.41.0.jar;%APP_HOME%\lib\ktor-client-cio-jvm-1.6.3.jar;%APP_HOME%\lib\koin-ktor-3.1.2.jar;%APP_HOME%\lib\ktor-serialization-jvm-1.6.3.jar;%APP_HOME%\lib\ktor-server-netty-jvm-1.6.3.jar;%APP_HOME%\lib\ktor-server-host-common-jvm-1.6.3.jar;%APP_HOME%\lib\ktor-server-core-jvm-1.6.3.jar;%APP_HOME%\lib\ktor-client-core-jvm-1.6.3.jar;%APP_HOME%\lib\koin-logger-slf4j-3.1.2.jar;%APP_HOME%\lib\koin-core-jvm-3.1.2.jar;%APP_HOME%\lib\kotlinx-coroutines-jdk8-1.5.0-native-mt.jar;%APP_HOME%\lib\ktor-http-cio-jvm-1.6.3.jar;%APP_HOME%\lib\ktor-http-jvm-1.6.3.jar;%APP_HOME%\lib\ktor-network-tls-jvm-1.6.3.jar;%APP_HOME%\lib\ktor-network-jvm-1.6.3.jar;%APP_HOME%\lib\ktor-utils-jvm-1.6.3.jar;%APP_HOME%\lib\ktor-io-jvm-1.6.3.jar;%APP_HOME%\lib\kotlinx-coroutines-core-jvm-1.5.0-native-mt.jar;%APP_HOME%\lib\kotlin-stdlib-jdk8-1.5.20.jar;%APP_HOME%\lib\kotlin-stdlib-jdk7-1.5.20.jar;%APP_HOME%\lib\kotlin-reflect-1.5.20.jar;%APP_HOME%\lib\kotlinx-serialization-json-jvm-1.2.2.jar;%APP_HOME%\lib\kotlinx-serialization-core-jvm-1.2.2.jar;%APP_HOME%\lib\kotlin-stdlib-1.5.21.jar;%APP_HOME%\lib\logback-classic-1.2.5.jar;%APP_HOME%\lib\lettuce-core-6.1.4.RELEASE.jar;%APP_HOME%\lib\selenium-chrome-driver-2.41.0.jar;%APP_HOME%\lib\selenium-htmlunit-driver-2.41.0.jar;%APP_HOME%\lib\selenium-firefox-driver-2.41.0.jar;%APP_HOME%\lib\selenium-ie-driver-2.41.0.jar;%APP_HOME%\lib\selenium-safari-driver-2.41.0.jar;%APP_HOME%\lib\selenium-support-2.41.0.jar;%APP_HOME%\lib\webbit-0.4.14.jar;%APP_HOME%\lib\annotations-13.0.jar;%APP_HOME%\lib\kotlin-stdlib-common-1.5.21.jar;%APP_HOME%\lib\slf4j-api-1.7.31.jar;%APP_HOME%\lib\config-1.3.1.jar;%APP_HOME%\lib\netty-codec-http2-4.1.63.Final.jar;%APP_HOME%\lib\alpn-api-1.1.3.v20160715.jar;%APP_HOME%\lib\netty-transport-native-kqueue-4.1.63.Final.jar;%APP_HOME%\lib\netty-transport-native-epoll-4.1.63.Final.jar;%APP_HOME%\lib\logback-core-1.2.5.jar;%APP_HOME%\lib\netty-codec-http-4.1.63.Final.jar;%APP_HOME%\lib\netty-handler-4.1.65.Final.jar;%APP_HOME%\lib\netty-transport-native-unix-common-4.1.63.Final.jar;%APP_HOME%\lib\netty-codec-4.1.65.Final.jar;%APP_HOME%\lib\netty-transport-4.1.65.Final.jar;%APP_HOME%\lib\netty-buffer-4.1.65.Final.jar;%APP_HOME%\lib\netty-resolver-4.1.65.Final.jar;%APP_HOME%\lib\netty-common-4.1.65.Final.jar;%APP_HOME%\lib\reactor-core-3.3.18.RELEASE.jar;%APP_HOME%\lib\selenium-remote-driver-2.41.0.jar;%APP_HOME%\lib\htmlunit-2.13.jar;%APP_HOME%\lib\httpmime-4.3.1.jar;%APP_HOME%\lib\httpclient-4.3.1.jar;%APP_HOME%\lib\commons-io-2.4.jar;%APP_HOME%\lib\commons-exec-1.1.jar;%APP_HOME%\lib\jna-3.4.0.jar;%APP_HOME%\lib\platform-3.4.0.jar;%APP_HOME%\lib\selenium-api-2.41.0.jar;%APP_HOME%\lib\netty-3.5.2.Final.jar;%APP_HOME%\lib\reactive-streams-1.0.3.jar;%APP_HOME%\lib\cglib-nodep-2.1_3.jar;%APP_HOME%\lib\json-20080701.jar;%APP_HOME%\lib\guava-15.0.jar;%APP_HOME%\lib\xalan-2.7.1.jar;%APP_HOME%\lib\commons-collections-3.2.1.jar;%APP_HOME%\lib\commons-lang3-3.1.jar;%APP_HOME%\lib\commons-codec-1.8.jar;%APP_HOME%\lib\htmlunit-core-js-2.13.jar;%APP_HOME%\lib\xercesImpl-2.11.0.jar;%APP_HOME%\lib\nekohtml-1.9.19.jar;%APP_HOME%\lib\cssparser-0.9.11.jar;%APP_HOME%\lib\commons-logging-1.1.3.jar;%APP_HOME%\lib\jetty-websocket-8.1.12.v20130726.jar;%APP_HOME%\lib\httpcore-4.3.jar;%APP_HOME%\lib\serializer-2.7.1.jar;%APP_HOME%\lib\xml-apis-1.4.01.jar;%APP_HOME%\lib\sac-1.3.jar;%APP_HOME%\lib\jetty-http-8.1.12.v20130726.jar;%APP_HOME%\lib\jetty-io-8.1.12.v20130726.jar;%APP_HOME%\lib\jetty-util-8.1.12.v20130726.jar


@rem Execute SCPApi
"%JAVA_EXE%" %DEFAULT_JVM_OPTS% %JAVA_OPTS% %SCP_API_OPTS%  -classpath "%CLASSPATH%" io.ktor.server.netty.EngineMain %*

:end
@rem End local scope for the variables with windows NT shell
if "%ERRORLEVEL%"=="0" goto mainEnd

:fail
rem Set variable SCP_API_EXIT_CONSOLE if you need the _script_ return code instead of
rem the _cmd.exe /c_ return code!
if  not "" == "%SCP_API_EXIT_CONSOLE%" exit 1
exit /b 1

:mainEnd
if "%OS%"=="Windows_NT" endlocal

:omega
