#!/bin/sh
                    
if [ $# -ne 4 ]
  then
    echo "Wrong number of arguments. First one is the name of your project, second one your group, third one your artifact and fourth one is the spring boot version."    
	exit 1
fi

echo Creating a spring boot project with name $1, group $2, artifact $3 and parent version $4
packageFolder=$(echo "$2" | tr '.' '/')
mkdir -p ./$1/src/main/java/$packageFolder   

# Writing pom           
echo '<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <groupId>'$2'</groupId>
    <artifactId>'$3'</artifactId>
    <version>1.0.0-SNAPSHOT</version>
	<url>http://maven.apache.org</url>

    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>'$4'</version>              
        <relativePath/>
    </parent>

    <dependencies>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>
    </dependencies>

    <properties>
        <java.version>1.8</java.version>
    </properties>


    <build>
        <plugins>
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
            </plugin>
        </plugins>
    </build>

</project>' > ./$1/pom.xml

# Writing application class
echo "
package $2;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.EnableConfigurationProperties;

@EnableConfigurationProperties
@SpringBootApplication
public class Application {
  public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }
}" > ./$1/src/main/java/$packageFolder/Application.java

echo Done.
