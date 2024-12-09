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

const express = require('express');
const expressApp = express();

const app=initializeApp();

// Initialize Cloud Firestore and get a reference to the service
const db = getFirestore(app);


// Create and deploy your first functions
// https://firebase.google.com/docs/functions/get-started

// Take the text parameter passed to this HTTP endpoint and insert it into
// Firestore under the path /messages/:documentId/original
exports.agregarMensajeAChat = onRequest(async (req, res) => {
  // Grab the text parameter.
  const sCuerpo = req.query.textoMensaje;
  // Push the new message into Firestore using the Firebase Admin SDK.
  const writeResult = await db
      .collection("chats/9jsvxsiwVEEGMcKy1YNm/mensajes")
      .add({sCuerpo: sCuerpo,sTitulo:basjklfbasd,});
  // Send back a message that we've successfully written the message
  res.json({result: `Message with ID: ${writeResult.id} added.`});
});

//exports.mostrarTodosLosMensajes = onRequest(async (req, res) => {
expressApp.get('/mostrarTodosLosMensajes', async (req, res) => {
    //const docRef= db.collection("chats").doc("9jsvxsiwVEEGMcKy1YNm");
    const sUserToken = req.query.sUserToken;
    if (!sUserToken) {
      return res.status(400).send('sUserToken is required');
    }
    if(!checkAndChargeCredits(sUserToken,2500)){
      return res.status(400).send('No tienes suficientes creditos'); 
    }
   

    const sChatUID = req.query.sChatUID;
    if (!sChatUID) {
      return res.status(400).send('sChatUID is required');
    }
    console.log("PRUEBA QUE PASA "+sChatUID);
    const valor1 = req.query.valor1;
    const valor2 = req.query.valor2;
    const valor3 = req.query.valor3;
    const valor4 = req.query.valor4;

    const docRef=db.collection("chats/"+sChatUID+"/mensajes");
    const mensajesDescargado = await docRef.get();

    // Store documents in an array
    const documentsArray = [];
    mensajesDescargado.forEach(doc => {
        documentsArray.push({
            id: doc.id,  // Optionally include the document ID
            ...doc.data() // Include the document data
        });
    });

    // Return the array as a response
    res.status(200).json(documentsArray);

    /*if (chatDescargado.exists()) {
      console.log("Document data:", chatDescargado.data());
      res.json(chatDescargado.data());
    } else {
      // docSnap.data() will be undefined in this case
      console.log("No such document!");
      res.json({result:"NO EXISTE"});
    }*/
   /*const arDocs=[];
   for(doc in chatDescargado.docs){
    arDocs.push(doc.data);
   }
      res.json(arDocs);*/

});


 exports.helloWorld = onRequest((request, response) => {
   logger.info("Hello logs!", {structuredData: true});

   response.send("Hello from Firebase! HOLA DESDE PREMIOS CELO!!!");
 });

 
async function checkAndChargeCredits(sCompanyToken,iCreditCost){

  //const docRef =db.ref('/tokens/'+sCompanyToken);
  const docRef= db.collection("tokens").doc(sCompanyToken);
  const docSnap = await docRef.get();
  const datosDoc=docSnap.data();
  console.log("DATOS!!!!! "+datosDoc);
  const creditos=datosDoc['credits'];

  if((creditos-iCreditCost)>=0){
    datosDoc['credits']=(creditos-iCreditCost);
    console.log("CANTIDAD DE CREDITOS RESTANTES: "+datosDoc['credits']);
    //docRef.set(datosDoc);
    const writeResult = await db.collection('tokens').doc(sCompanyToken).set(datosDoc);
    return true;
  }
  else{
    return false;
  }
}
