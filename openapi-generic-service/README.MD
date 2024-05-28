# Create Generic Microservice Client with OpenAPI tool

---
What is the purpose of generic-service-client?
---

In microservices, instead of sending a request to another microservice with the Rest API, it is used to directly access the methods of the other microservice by setting it as a spring bean.

--- 
You can read my Medium article
https://medium.com/@lastjavabuilder/create-generic-microservice-client-with-openapi-tool-and-add-as-dependency-fdf67ea25ab6

---
You can build project on command line via (for example demo-rest-service client)
mvn clean install -Pdev -DserviceName=demo-rest-service -DserviceKey=demoService -DserviceUrl=http://localhost:8080/api-docs
