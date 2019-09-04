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
      style: 'mapbox://styles/mapbox/light-v10',
    });
    // If href is Index of courses
  } else {
    return new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/mapbox/light-v10',
    });
  }
};

const fitMapToMarkers = (map, markers) => {
  const bounds = new mapboxgl.LngLatBounds();
  markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
  if (isItAShowPage() == true) {
    map.fitBounds(bounds, { padding: 70, maxZoom: 11, duration: 0 });
  } else {
    map.fitBounds(bounds, { padding: 70, maxZoom: 15 });
  };
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

    const element = document.createElement('div');
    element.className = 'marker';
    element.style.backgroundImage = `url('${marker.image_url}')`;
    element.style.backgroundSize = 'contain';
    element.style.width = '25px';
    element.style.height = '25px';

    // If map display on games index
    if (isItAShowPage() == false) {
      new mapboxgl.Marker(element)
        .setLngLat([ marker.lng, marker.lat ])
        .setPopup(popup)
        .addTo(map);
    } else {
      // Else if map display on another page
      new mapboxgl.Marker(element)
        .setLngLat([ marker.lng, marker.lat ])
        .addTo(map);
    }
  });
};

export { initMapbox };
