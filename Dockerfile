# Java Runtime Environment version (default = 8)
ARG jre_version=8-jre-alpine
ARG sonar_scanner_version=3.2.0.1227
# Choose desired JDK as the base image
FROM openjdk:${jre_version}
LABEL maintainer="Ajitem Sahasrabuddhe <ajitem.s@outlook.com>"

RUN apk add --no-cache curl grep sed unzip
# Set timezone to India 
ENV TZ=Asia/Kolkata
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

WORKDIR /root
# Get Sonar Scanner CLI + Cleanup
RUN curl -o sonarscanner.zip -L https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-${sonar_scanner_version}-linux.zip &&  \
    unzip sonarscanner.zip && \
    rm sonarscanner.zip && \
    mv sonar-scanner-${sonar_scanner_version}-linux sonar-scanner

# prefer embedded java for musl over glibc
RUN sed -i 's/use_embedded_jre=true/use_embedded_jre=false/g' /root/sonar-scanner/bin/sonar-scanner

ENTRYPOINT [ "/root/sonar-scanner/bin/sonar-scanner", "-Dsonar.projectBaseDir=" ]

CMD [ "." ]
