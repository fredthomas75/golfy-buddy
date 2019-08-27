import places from 'places.js';

const initUserAutocomplete = () => {
  const addressInput = document.getElementById('current_city');
  if (addressInput) {
    places({ container: addressInput });
  }
};

export { initUserAutocomplete };
