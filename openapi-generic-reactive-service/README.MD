# Create Generic Microservice Client with OpenAPI tool

---

### Build with maven

Enter the command below from the Command line.

`mvn clean install 
    -Pdev  \
    -DserviceName=order-rest-service \
    -DremoteServiceName=payment-client-service  \
    -DserviceKey=order  \
    -DremoteServiceKey=payment  \
    -Dservice-server-Url=http://localhost:8080/api-docs  \
    -Dservice-client-Url=http://localhost:4010/api-docs `

-Pdev

- to activate a specific profile in the pom.xml
- other possible options are (dev, test, preprod, prod)

-DserviceName=order-service

- Customise by specifying which service to create an api for

-DremoteServiceName=payment-client-service

- Customise by specifying which service to create a client for

-DserviceKey=order
-DremoteServiceKey=payment

- A unique name included in the package structure of generated code. Serves to create workspace for different service codes

-service-server-Url=http://localhost:8080/api-docs

- Specify the URL of the service to create an api for. The plugin will use this to access the OpenAPI specification yaml file.
- It can also be the location of the OpenAPI specification yaml file on the local machine during development

-Dservice-client-Url=http://localhost:4010/api-docs

- Specify the URL of the service to create a client for. The plugin will use this to access the OpenAPI specification yaml file.
- It can also be the location of the OpenAPI specification yaml file on the local machine during development

### Add as Dependency and Use

In your microservice pom.xml, you can reference as dependency.

For Reactive generated artifact:
`       <dependency>
            <groupId>org.cometbid.openapi.code</groupId>
            <artifactId>order-service-reactive-api</artifactId>
        </dependency>
  `

For Non-Reactive generated artifact:
`       <dependency>
            <groupId>org.cometbid.openapi.code</groupId>
            <artifactId>order-service-api</artifactId>
        </dependency>
  `
