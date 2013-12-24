#!/bin/bash


function new_java_file_exists() {

    java_regex='.*.java.?$'
    class_regex='.*.class.?$'

    java_flag='N'
    system_type=`uname`

    if test $system_type = 'Darwin'
    then
        x='-f "%m %N"'
    fi

    if test $system_type = 'Linux'
    then
        x="--format=\"%Y %n\""
    fi

    find . -type f \( -regex '.*.class' -or -regex '.*.java' \) -exec stat "$x" {} \; | sort -n -r | awk '{print $2}' | while read file
    do
        if [[ $file =~ $java_regex ]]
        then
            java_flag='Y'
        fi

        if [[ $file =~ $class_regex ]]
        then
            if test $java_flag = 'Y'
            then
                echo 'Y'
                return
            fi
        fi
    done
}

# Best effort
if test \( "$1" == 'lib'  \) -o \( ! -d "lib" \)
then
    echo 'Copying dependencies.'
    mkdir -p lib/
    mvn clean compile
    mvn process-sources -P dependency-cp
fi

compiled='N'
if [[ `new_java_file_exists` == 'Y' ]]
then

    echo 'Changed java file detected. Cleaning and Compiling'
    mvn clean compile
    compiled='Y'

fi

if test $1 = 'init'
then
    echo 'Initializing keys.'
    cp=`find lib -regex ".*\.jar" -print0 | tr '\0' ':'`
    java -classpath ./target/classes/:$cp edu.utdallas.netsec.sfts.Initializer "$2"
fi

if test $1 = 'client'
then
    echo 'Running client'
    cp=`find lib -regex ".*\.jar" -print0 | tr '\0' ':'`
    echo "$2" "$3" "$4"
    java -classpath ./target/classes/:$cp edu.utdallas.netsec.sfts.client.Client "$2" "$3" "$4"
fi

if test $1 = 'as'
then
    echo 'Running Authentication Server'
    cp=`find lib -regex ".*\.jar" -print0 | tr '\0' ':'`
    java -classpath ./target/classes/:$cp edu.utdallas.netsec.sfts.as.AuthenticationServer "$2"
fi

if test $1 = 'master'
then
    echo 'Running Master Server'
    cp=`find lib -regex ".*\.jar" -print0 | tr '\0' ':'`
    java -classpath ./target/classes/:$cp edu.utdallas.netsec.sfts.master.MasterFileServer "$2"
fi

if test $1 = 'dept'
then
    echo 'Running Department File Server'
    cp=`find lib -regex ".*\.jar" -print0 | tr '\0' ':'`
    java -classpath ./target/classes/:$cp edu.utdallas.netsec.sfts.ds.DepartmentServer "$2"
fi
