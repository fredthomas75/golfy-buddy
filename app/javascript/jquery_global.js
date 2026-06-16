// Expose jQuery globally BEFORE any plugin/inline script runs.
// Bootstrap 4, Select2, the datepicker plugin, the vendored Filterrific JS, and the
// server-generated `.js.erb` responses (likes, guests, filterrific) all rely on
// window.$ / window.jQuery. This module is imported first in application.js so the
// global is set before the plugin imports are evaluated.
import jquery from "jquery";

window.jQuery = jquery;
window.$ = jquery;

export default jquery;
