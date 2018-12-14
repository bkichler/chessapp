var firebase = require("firebase/app");
require("firebase/messaging");
  // Initialize Firebase
  var config = {
    apiKey: "AIzaSyCrCXnxjNxlfdeGdm4y1TeTr0xkCO5xEk8",
    authDomain: "team-finishers.firebaseapp.com",
    databaseURL: "https://team-finishers.firebaseio.com",
    projectId: "team-finishers",
    storageBucket: "team-finishers.appspot.com",
    messagingSenderId: "950046404815"
  };
  firebase.initializeApp(config);