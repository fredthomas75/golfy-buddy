import "bootstrap";
// CSS for Mapbox
import 'mapbox-gl/dist/mapbox-gl.css';
// internal imports for Mapbox
import { initMapbox } from '../plugins/init_mapbox';
import '@mapbox/mapbox-gl-geocoder/dist/mapbox-gl-geocoder.css';
initMapbox();
