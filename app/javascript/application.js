// Golfy Buddy — single esbuild entrypoint.
// Replaces the old Webpacker packs AND the Sprockets `app/assets/javascripts` manifest.

// jQuery must be global first (see jquery_global.js).
import "./jquery_global";

// Rails UJS: powers `remote: true` forms/links and the `.js.erb` responses (likes, guests).
import Rails from "@rails/ujs";
if (!window._rails_loaded) Rails.start();

// Turbolinks (Turbo migration is intentionally out of scope for now).
import Turbolinks from "turbolinks";
Turbolinks.start();

// jQuery plugins — attach to the shared jQuery instance.
import "bootstrap";
import "select2";
import "@chenfengyuan/datepicker";

// Filterrific live-filtering (self-initializes on turbolinks:load / DOMContentLoaded).
import "./filterrific";

// App behaviors.
import { initMapbox } from "./plugins/init_mapbox";
import { initAutocomplete } from "./plugins/init_autocomplete";
import { initUserAutocomplete } from "./plugins/autocomplete";

// Reverse-geocode the visitor's position into the #current_city field (home page).
function initLocate() {
  const locate = document.getElementById("locate");
  const result = document.getElementById("current_city");
  if (!locate || !result) return;

  locate.addEventListener("click", (event) => {
    event.preventDefault();
    navigator.geolocation.getCurrentPosition((data) => {
      const url = "https://places-dsn.algolia.net/1/places/reverse?aroundLatLng=";
      fetch(`${url}${data.coords.latitude},%20${data.coords.longitude}&language=default`)
        .then((response) => response.json())
        .then((d) => { result.value = d.hits[0].city; });
    });
  });
}

function initPage() {
  const $ = window.jQuery;
  if ($ && $.fn.select2) {
    $("#game_course_id").select2();
    $(".chosen-it").select2(); // chosen-rails dropped — Select2 takes over the enhanced selects
  }
  if ($) {
    $(".preference-choice").off("click.pref").on("click.pref", function () {
      $(this).toggleClass("active");
    });
  }
  initMapbox();
  initAutocomplete();
  initUserAutocomplete();
  initLocate();
}

document.addEventListener("turbolinks:load", initPage);
