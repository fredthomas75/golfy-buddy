// Auto-completion for map
import places from 'places.js';

const initAutocomplete = () => {
  const addressInput = document.getElementById('course_address');
  if (addressInput) {
    places({ container: addressInput });
  }
};

export { initAutocomplete };
