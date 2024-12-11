/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

//const functions = require('firebase-functions');
const {onRequest} = require("firebase-functions/v2/https");
const logger = require("firebase-functions/logger");
const {beforeUserCreated, beforeUserSignedIn, HttpsError,} = require("firebase-functions/v2/identity");

const {onDocumentCreated,onDocumentDeleted,onDocumentUpdated} = require("firebase-functions/v2/firestore");

// The Firebase Admin SDK to access Firestore.
const {initializeApp} = require("firebase-admin/app");
const {getFirestore} = require("firebase-admin/firestore");
const {onObjectFinalized} = require("firebase-functions/v2/storage");
const {getStorage} = require("firebase-admin/storage");

const path = require("path");
// library for image resizing
const sharp = require("sharp");

const express = require('express');
const expressApp = express();

expressApp.use(express.json());

const app=initializeApp();

// Initialize Cloud Firestore and get a reference to the service
const db = getFirestore(app);

const knownInsults = [
  'idiot',
  'stupid',
  'dumb',
  'fool',
  'jerk',
  'moron',
  'idiota',
  'estúpido',
  'imbécil',
  'tonto',
  'tarado',
  'inútil',
  'burro',
  'cabrón',
  'cabron',
  'mierda',
  'payaso',
  'gilipollas',
  'pendejo',
  'asno',
  'zopenco',
  'cretino'
];




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
      .add({sCuerpo: sCuerpo});
  // Send back a message that we've successfully written the message
  res.json({result: `Message with ID: ${writeResult.id} added.`});
});

// Listens for new messages added to /messages/:documentId/original
// and saves an uppercased version of the message
// to /messages/:documentId/uppercase
exports.makeuppercase = onDocumentCreated("/chats/9jsvxsiwVEEGMcKy1YNm/mensajes/{documentId}", (event) => {

  const datosMensaje = event.data.data();
  
  //logger.log("Uppercasing", event.params.documentId, datosMensaje.sCuerpo);

  //const sCuerpoMayusculas=datosMensaje.sCuerpo.toUpperCase();

  let words = datosMensaje.sCuerpo.split(/\b/); 

  const censoredWords = words.map(word => {

    const lowercaseWord = word.toLowerCase();

    if (knownInsults.includes(lowercaseWord)) {
      return censorWord(word);
    }
    return word;
  });

  // Reconstruct the censored text
  const censoredText = censoredWords.join('');

  return event.data.ref.set({sCuerpo:censoredText,blModificadoEnServidor:true}, {merge: true});
});

//exports.mostrarTodosLosMensajes = onRequest(async (req, res) => {
expressApp.get('/api/mostrarTodosLosMensajes', async (req, res) => {
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

// A helper function to hide insults by replacing characters with asterisks.
// This function attempts to preserve word length while obscuring its letters.
function censorWord(word) {
  return word[0] + '*'.repeat(word.length - 1);
}

expressApp.get('/api/hello', (req, res) => {
  console.log('Received GET /hello request');
  res.send('Hello from Express!');
});

exports.validatenewuser = beforeUserCreated((event) => {
  // [END v2beforeCreateFunctionTrigger]
  // [START v2readUserData]
  // User data passed in from the CloudEvent.
  const user = event.data;
  console.log("PRUEBA!!!!!!!!:");
  // [END v2readUserData]

  // [START v2domainHttpsError]
  // Only users of a specific domain can sign up.
  if (!user?.email?.includes("@acme.com")) {
    // Throw an HttpsError so that Firebase Auth rejects the account creation.
    console.log("EMAIL ERROR:"+user?.email);
    throw new HttpsError("invalid-argument", "Unauthorized email");
    
  }
  // [END v2domainHttpsError]
});

/**
 * When an image is uploaded in the Storage bucket,
 * generate a thumbnail automatically using sharp.
 */
exports.generateThumbnail = onObjectFinalized({cpu: 2}, async (event) => {

  const fileBucket = event.data.bucket; // Storage bucket containing the file.
  const filePath = event.data.name; // File path in the bucket.
  const contentType = event.data.contentType; // File content type.

  // Exit if this is triggered on a file that is not an image.
  if (!contentType.startsWith("image/")) {
    return logger.log("This is not an image.");
  }
  // Exit if the image is already a thumbnail.
  const fileName = path.basename(filePath);
  if (fileName.startsWith("thumb_")) {
    return logger.log("Already a Thumbnail.");
  }

  // Download file into memory from bucket.
  const bucket = getStorage().bucket(fileBucket);
  const downloadResponse = await bucket.file(filePath).download();
  const imageBuffer = downloadResponse[0];
  logger.log("Image downloaded!");

  // Generate a thumbnail using sharp.
  const thumbnailBuffer = await sharp(imageBuffer).resize({
    width: 200,
    height: 200,
    withoutEnlargement: true,
  }).toBuffer();
  logger.log("Thumbnail created");

  // Prefix 'thumb_' to file name.
  const thumbFileName = `thumb_${fileName}`;
  const thumbFilePath = path.join(path.dirname(filePath), thumbFileName);

  // Upload the thumbnail.
  const metadata = {contentType: contentType};
  await bucket.file(thumbFilePath).save(thumbnailBuffer, {
    metadata: metadata,
  });
  return logger.log("Thumbnail uploaded!");
});

//exports.api = functions.https.onRequest(expressApp); // Ensure this export is correct
exports.expressApp = onRequest(expressApp);