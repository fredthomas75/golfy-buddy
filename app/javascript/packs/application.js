import "bootstrap";
// CSS for Mapbox
import 'mapbox-gl/dist/mapbox-gl.css';
// internal imports for Mapbox
import { initMapbox } from '../plugins/init_mapbox';
import '@mapbox/mapbox-gl-geocoder/dist/mapbox-gl-geocoder.css';
initMapbox();
import { initUserAutocomplete } from '../plugins/autocomplete';
initUserAutocomplete();

import "select2";
import $ from 'jquery';
import 'select2/dist/css/select2.css';


$('#game_course_id').select2();
