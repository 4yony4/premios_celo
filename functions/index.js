/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

const {onRequest} = require("firebase-functions/v2/https");
const logger = require("firebase-functions/logger");

const {onDocumentCreated} = require("firebase-functions/v2/firestore");

// The Firebase Admin SDK to access Firestore.
const {initializeApp} = require("firebase-admin/app");
const {getFirestore} = require("firebase-admin/firestore");

initializeApp();


// Create and deploy your first functions
// https://firebase.google.com/docs/functions/get-started

// Take the text parameter passed to this HTTP endpoint and insert it into
// Firestore under the path /messages/:documentId/original
/*exports.agregarMensajeAChat = onRequest(async (req, res) => {
  // Grab the text parameter.
  const sCuerpo = req.query.textoMensaje;
  // Push the new message into Firestore using the Firebase Admin SDK.
  const writeResult = await getFirestore()
      .collection("chats/9jsvxsiwVEEGMcKy1YNm/mensajes")
      .add({sCuerpo: sCuerpo,sTitulo:basjklfbasd,});
  // Send back a message that we've successfully written the message
  res.json({result: `Message with ID: ${writeResult.id} added.`});
});
*/

 exports.helloWorld = onRequest((request, response) => {
   logger.info("Hello logs!", {structuredData: true});

   //response.send("Hello from Firebase! HOLA DESDE PREMIOS CELO!!!");
 });
