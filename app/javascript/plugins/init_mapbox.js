import mapboxgl from 'mapbox-gl';
import MapboxGeocoder from '@mapbox/mapbox-gl-geocoder';

const isItAShowPage = () =>
  /courses\/\d+/.test(window.location.href) || /games\/\d+/.test(window.location.href);

const buildMap = (mapElement) => {
  mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
  return new mapboxgl.Map({
    container: 'map',
    style: 'mapbox://styles/mapbox/light-v10',
  });
};

const fitMapToMarkers = (map, markers) => {
  const bounds = new mapboxgl.LngLatBounds();
  markers.forEach((marker) => bounds.extend([marker.lng, marker.lat]));
  if (isItAShowPage()) {
    map.fitBounds(bounds, { padding: 70, maxZoom: 11, duration: 0 });
  } else {
    map.fitBounds(bounds, { padding: 70, maxZoom: 15 });
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

    const mk = new mapboxgl.Marker(element).setLngLat([marker.lng, marker.lat]);
    if (!isItAShowPage()) mk.setPopup(popup);
    mk.addTo(map);
  });
};

// Looks up #map at call time so it works across Turbolinks navigations.
const initMapbox = () => {
  const mapElement = document.getElementById('map');
  if (!mapElement) return;

  const map = buildMap(mapElement);
  const markers = JSON.parse(mapElement.dataset.markers);
  addMarkersToMap(map, markers);
  fitMapToMarkers(map, markers);

  if (!isItAShowPage()) {
    map.addControl(new MapboxGeocoder({ accessToken: mapboxgl.accessToken }));
  } else {
    map.scrollZoom.disable();
  }
  map.addControl(new mapboxgl.NavigationControl());
};

export { initMapbox };
