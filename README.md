<h2>Usage</h2>

<h3>Build</h3>

Run the following command from this Project's root folder.

```
docker build -t devops-sonar-scanner:tag .
```
This will save your image for future uses.

<h3>Run Analysis</h3>

Run the following command from Project's root folder where your sonar-project.properties file is  present

```
docker container run --rm -v $PWD:/app/ devops-sonar-scanner:tag -Dsonar.projectBaseDir=/app/ 
```