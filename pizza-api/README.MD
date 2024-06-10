# Serverless Architecture with Claudia

---

## Install Claudia

To create a Node.js project from scratch, run the following command at the root directory:

`npm init`

It will run through series of prompts to create a package.json

Claudia is a regular Node.js module, published on NPM.

To install Claudia and make the claudia command available in your terminal, run the following:

`npm install claudia -g`

To install Claudia as a development dependency to your Node.js project run the following command in your project.

`npm install claudia --save-dev`

### Configuring Claudia prerequisites

Claudia uses the AWS SDK for Node.js to function, and that SDK requires AWS profile keys.

If you have configured AWS CLI on your machine you should have a _*.aws*_ in your home directory containing two files: config and credentials.

The credential file will have the default profile and, if you named your profile with any other name than the default an addition section of credentials tagged with the name.

Provide that name to Claudia. You can do that by passing the --profile flag with a profile name.

`claudia update --profile app-dev`

or by setting an AWS_PROFILE environment variable

`AWS_PROFILE=app-dev claudia update`

Update the package.json file so that it looks like this.

json`{
  "name": "pizza-api",
  "version": "1.0.0",
  "main": "api.js",
  "scripts": {
    "create": "claudia create --version dev --region us-east-1 --profile app-dev --api-module api --role node-lambda-api-role",
    "update": "claudia update --version dev --profile app-dev --role node-lambda-api-role",
    "deploy": "claudia create --version dev --region us-east-1 --profile app-dev --handler api.handler --role node-lambda-api-role --runtime nodejs20.x",
    "release": "claudia set-version --version production",
    "test": "claudia test-lambda",
    "start": "ntl"
  },
  "author": "Samuel Adebowale",
  "license": "MIT",
  "description": "",
  "devDependencies": {
    "claudia": "5.14.1",
    "ntl": "5.1.0"
  }
}`

## Install ntl (Optional)

The ntl module is a nice way to create a console menu system, so people don’t even need to look up the available scripts in package.json.
Install it as a development dependency:

`npm install ntl -D`

Now, the only thing people need to remember is to run:

`npm start`

NPM will present a nice menu for the available deployment options.

### Create a Dedicated role for Lambda IAM User

Go to the AWS Console, Click Roles and add the following Permissions to the Role.

- AmazonAPIGatewayAdministrator: Required if you want to use Claudia API Builder, Claudia Bot Builder or deploy API Gateway Proxy APIs.
- AmazonAPIGatewayPushToCloudWatchLogs: Optional; used for logging full requests and responses from API Gateway
- AmazonDynamoDBFullAccess: Required for managing a DynamoDb database
- AWSLambda_FullAccess: Required for Claudia deployments

Give the Policies a dedicated name.

### Install the Claudia API Builder

Install the claudia-api-builder module from NPM as a package dependency.

`npm install claudia-api-builder --save`

## Install DynamoDB using AWS CLI

`aws dynamodb create-table \
   --table-name pizza-orders \ 
   --attribute-definitions AttributeName=orderId,AttributeType=S \
   --key-schema AttributeName=orderId,KeyType=HASH \
   --provisioned-throughput ReadCapacityUnits=1,WriteCapacityUnits=1 \
   --region us-east-1 \
   --query TableDescription.TableArn \
   --output text
  `
Output:
arn:aws:dynamodb:us-east-1:205225161852:table/pizza-orders

## Connecting to Dynamodb

In order to be able to connect to your DynamoDB table from Node.js, you need to install AWS SDK for Node.js.

Run this command to install AWS SDK for JavaScript
`npm i aws-sdk`
