# Secure File Transfer System

This project is done as a part of [Network Security](http://go.utdallas.edu/cs6349.001.13f) course, I did in UT Dallas in Fall 2013.
Please refer to [requirement document](https://docs.google.com/file/d/0B2OZg77xly1YY0U1SlFtMUozeWM/edit) for
details of the requirements. In short, we needed to design a [Kerberos](http://en.wikipedia.org/wiki/Kerberos_(protocol) alike protocol,
which includes a *Authentication Server* that authenticates clients and provides tokens for *Master File Server*
and *Department File Servers*. Client only communicate with master server that relays client's request for file to
department server and response from department server to client. In addition all these communications are encrypted.


# Our Implementation

Our protocol for this project

[Google Drawing of designed protocol](https://docs.google.com/drawings/d/1pHUXRm_G7lpaCbiAJhBWWk8RvXEJx7usANGYkOlzeTE/edit)


# Packet Encoding

In this project we needed to design a common mechanism for encoding and encrypting variable number of
variable length fields. As we need to do multiple layer of encrypt then encode so using JSON or XML directly
wasn't an option for us. So I designed the following encoding scheme.

[Google Drawing for packet encoding scheme](https://docs.google.com/drawings/d/1JEsAV2_QMP4MamgAFtu-wV-rd1g6qMAS7UxV4xaYkXI/edit)

# Overview

There are 5 executable components of the projects

1. Initializer                  // creates shared keys for Authentication Server and other entities
2. AuthenticationServer
3. Client
4. MasterServer
5. DepartmentServer


# Project Management

This project is managed using [maven](http://maven.apache.org/).

## Installing Maven on Linux

- Please refer to [Maven Download Page](http://maven.apache.org/download.cgi) for download and install instructions. In unix like environment it is as simple as extracting the tar then including the bin folder to `PATH` variable.
- For example in any of the net machine you can install maven using the following instructions.

        $ mkdir lib
        $ cd lib
        $ wget http://apache.mesi.com.ar/maven/maven-3/3.1.1/binaries/apache-maven-3.1.1-bin.tar.gz
        $ tar xvvzf apache-maven-3.1.1-bin.tar.gz


- Now add the following lines in ~/.bashrc file

        export MAVEN_HOME="$HOME/lib/apache-maven-3.1.1"
        export PATH="$MAVEN_HOME/bin:$PATH"

- Then source the `.bashrc` or simple logout then login you are good to go.

# Compile

To compile a maven based project, first go to the project home.

    $ mvn clean compile

# Java AES 256 bit key.

We used aes 256 bit key. For that the jre must have "Unlimited Strength Jurisdiction Policy Files 6 (or 7)" files.

Pleas download from [Oracle Official Site](http://www.oracle.com/technetwork/java/javase/downloads/index.html) and
follow the readme file.

# Execution

First need to make sure that proper configuration file exists. Two set of configuration files are provided
under `data/staging` folder.

Then follow the steps

1. Generate shared keys
2. Run Authentication Server
3. Run Master Server
4. Department Server
5. Run Client with file request


# Execution using Maven

## Commands for running in a Single machine

### Generating Keys:

    mvn exec:java -Dexec.mainClass="edu.utdallas.netsec.sfts.Initializer" -Dexec.args="keys data/staging/auth_server/as.properties"

### Running Authentication Server

    mvn exec:java -Dexec.mainClass="edu.utdallas.netsec.sfts.as.AuthenticationServer" -Dexec.args="data/staging/auth_server/"

### Running Department

Showing example for finance. You can execute marketing and payroll department similarly

    mvn exec:java -Dexec.mainClass="edu.utdallas.netsec.sfts.ds.DepartmentServer" -Dexec.args="data/staging/dept_finance/"

### Running Master

    mvn exec:java -Dexec.mainClass="edu.utdallas.netsec.sfts.master.MasterFileServer" -Dexec.args="data/staging/master_server/"

### Running Client

Showing example for client bumblebee for department finance. You can execute other departments and client ironhide similarly

    mvn exec:java -Dexec.mainClass="edu.utdallas.netsec.sfts.client.Client" -Dexec.args="data/staging/client_bumblebee/ finance test.txt"

# Team

* Fahad Shaon - Designed packet encoding decoding scheme, Authentication Server and manages the project.
* Aditya Thakkar - Department file servers
* Karthik Gunasekaran - Master file server

# Final Comment

Please don't copy this if it matches your project. In long term you will gain nothing. We are
making this available for everybody because we think there are few aspects of the project that
everybody will find interesting and helpful. Specially our packet encoding - decoding scheme is very generic
and can be applied in wide verity of scenarios. Feel free to reuse that part.

Finally, if you find any real life application for this project, don't hesitate to contact with us.


# License

The MIT License (MIT)
Copyright (c) 2013, Fahad Shaon <fahad.shaon@gmail.com>, Aditya Thakkar, Karthik Gunasekaran

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

