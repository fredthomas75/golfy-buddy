import mapboxgl from 'mapbox-gl';
import MapboxGeocoder from '@mapbox/mapbox-gl-geocoder';

const isItAShowPage = () => {
  if (window.location.href.match(/courses\/\d+/)) {
    return true;
  } else if (window.location.href.match(/games\/\d+/)) {
    return true;
  } else {
    return false;
  };
};

const mapElement = document.getElementById('map');

const buildMap = () => {
  mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
  // If href is a courses/show ou games/show
  if (isItAShowPage() == true) {
    return new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/mapbox/streets-v10',
      zoom: 24, // starting zoom
    });
    // If href is Index of courses
  } else {
    return new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/mapbox/streets-v10'
    });
  }
};

const fitMapToMarkers = (map, markers) => {
  const bounds = new mapboxgl.LngLatBounds();
  markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
  map.fitBounds(bounds, { padding: 70, maxZoom: 15 });
};

const initMapbox = () => {
  if (mapElement) {
    const map = buildMap();
    const markers = JSON.parse(mapElement.dataset.markers);
    addMarkersToMap(map, markers);
    fitMapToMarkers(map, markers);
    // SI INDEX DE COURSE
    if (isItAShowPage() == false) {
      map.addControl(new MapboxGeocoder({ accessToken: mapboxgl.accessToken }));
    }
    // IF SHOW DE GAME OR COURSE
    if (isItAShowPage() == true) {
      map.scrollZoom.disable();
    }

    // Controller - + de Zoom
    map.addControl(new mapboxgl.NavigationControl());
  }
};

const addMarkersToMap = (map, markers) => {
  markers.forEach((marker) => {
    const popup = new mapboxgl.Popup().setHTML(marker.infoWindow);

    // IF INDEX DE COURSES
    if (isItAShowPage() == false) {
      new mapboxgl.Marker()
        .setLngLat([ marker.lng, marker.lat ])
        .setPopup(popup)
        .addTo(map);
    } else {
      // ELSE SHOW D'UN COURSE
      new mapboxgl.Marker()
        .setLngLat([ marker.lng, marker.lat ])
        .addTo(map);
    }
  });
};

export { initMapbox };
