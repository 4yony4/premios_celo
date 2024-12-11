const {initializeApp} = require("firebase-admin/app");
const app=initializeApp();

const authFunctions = require('./modulos/authFunctions');
const ddbbFunctions = require('./modulos/ddbbFunctions');
const storageFunctions = require('./modulos/storageFunctions');




// Export your functions
exports.validatenewuser = authFunctions.validatenewuser;
exports.generateThumbnail = storageFunctions.generateThumbnail;
exports.expressApp = ddbbFunctions.expressApp;