console.log('Salut from icitte!')

var places = require('places.js');
var placesAutocomplete = places({
  appId: 'plZ3DRI7CQ0K',
  // appId: 'YOUR_PLACES_APP_ID',
  apiKey: '9c822ff7212e6fed7e4def6d5279482b',
  // apiKey: 'YOUR_PLACES_API_KEY',
  container: document.querySelector('#current_city')
});

export { placesAutocomplete }
