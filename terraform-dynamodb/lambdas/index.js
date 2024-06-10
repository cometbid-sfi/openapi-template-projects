"use strict";

const Api = require("claudia-api-builder");
const api = new Api();

const listNotes = require("./handlers/get-all-notes");
const createNote = require("./handlers/create-note");
const deleteNote = require("./handlers/delete-note");

// Define Routes
// 1. Home Pizzas Route
api.get("/", () => "Welcome to sample app: Notes API");

// 2. POST New note Route
api.post(
  "/notes",
  (request) => {
    return createNote(request.body);
  },
  { success: 201, error: 400 }
);

// 3. DELETE a note Route
api.delete(
  "/notes/{id}",
  (request) => {
    return deleteNote(request.pathParams.id);
  },
  { error: 400 }
);

// 4. LIST all notes Route
api.get("/notes", (request) => {
  return async listNotes();
});

module.exports.handler = api;
//module.exports = api;
