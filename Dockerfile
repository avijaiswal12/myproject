# Use an official Tomcat image with Java 17 (or 21 if needed)
FROM tomcat:9.0.89-jdk17-temurin

# Remove default ROOT application (optional)
RUN rm -rf /usr/local/tomcat/webapps/ROOT

# Copy your WAR file to Tomcat's webapps folder
COPY target/SampleWebApplication.war /usr/local/tomcat/webapps/ROOT.war

# Expose Tomcat port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
