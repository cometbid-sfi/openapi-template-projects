const AWS = require("aws-sdk");
const NOTES_TABLE = process.env.NOTES_TABLE;

const documentClient = new AWS.DynamoDB.DocumentClient();

const listNotes = async (event, context) => {
  const allNotes = await documentClient
    .scan({
      TableName: NOTES_TABLE,
    })
    .promise();

  const { Items = [] } = allNotes;
  return {
    statusCode: 200,
    body: JSON.stringify(Items),
  };
};

module.exports = listNotes;
