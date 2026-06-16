/**
 * Filterrific behaviors — vendored from the filterrific gem (v5.2.7) and adapted for
 * esbuild/ESM: implicit globals are now declared (strict mode), the dead `removed()`
 * check is fixed, and Filterrific.init guards against pages without a filter form.
 * Released under the MIT license.
 */
const Filterrific = {};

Filterrific.submitFilterForm = function () {
  const form = Filterrific.findParents(this, "#filterrific_filter")[0];
  form.dispatchEvent(new Event("loadingFilterrificResults"));
  document.querySelector(".filterrific_spinner").style.display = "block";

  if (Filterrific.lastRequest && Filterrific.lastRequest.readyState != 4) {
    Filterrific.lastRequest.abort();
  }

  Filterrific.lastRequest = Filterrific.prepareRequest(form);
  Filterrific.lastRequest.send();
};

Filterrific.prepareRequest = function (form) {
  let url = form.getAttribute("action");
  const formData = new FormData(form);
  const params = new URLSearchParams(formData);
  const xhr = new XMLHttpRequest();

  url += (url.indexOf("?") < 0 ? "?" : "&") + params;

  xhr.open("GET", url, true);
  xhr.setRequestHeader("Accept", "text/javascript, application/javascript, application/ecmascript, application/x-ecmascript, */*; q=0.01");
  xhr.setRequestHeader("X-Requested-With", "XMLHttpRequest");
  xhr.onreadystatechange = function () {
    if (xhr.readyState === XMLHttpRequest.DONE) {
      return Filterrific.processResponse(form, xhr);
    }
  };

  return xhr;
};

Filterrific.processResponse = function (form, xhr) {
  const rawResponse = xhr.response != null ? xhr.response : xhr.responseText;
  let type = xhr.getResponseHeader("Content-Type");
  let response;

  if (typeof rawResponse === "string" && typeof type === "string") {
    if (type.match(/\bjson\b/)) {
      try { response = JSON.parse(rawResponse); } catch (_error) {}
    } else if (type.match(/\b(?:java|ecma)script\b/)) {
      const script = document.createElement("script");
      script.setAttribute("nonce", Filterrific.cspNonce());
      script.text = rawResponse;
      document.head.appendChild(script).parentNode.removeChild(script);
    } else if (type.match(/\b(xml|html|svg)\b/)) {
      const parser = new DOMParser();
      type = type.replace(/;.+/, "");
      try { response = parser.parseFromString(rawResponse, type); } catch (_error) {}
    }
  }

  form.dispatchEvent(new Event("loadedFilterrificResults"));
  document.querySelector(".filterrific_spinner").style.display = "none";

  return response;
};

Filterrific.cspNonce = function () {
  const meta = document.querySelector("meta[name=csp-nonce]");
  return meta ? meta.content : undefined;
};

Filterrific.findParents = function (elem, selector) {
  const elements = [];
  const hasSelector = selector !== undefined;

  while ((elem = elem.parentElement) !== null) {
    if (elem.nodeType !== Node.ELEMENT_NODE) continue;
    if (!hasSelector || elem.matches(selector)) elements.push(elem);
  }

  return elements;
};

Filterrific.observe_field = function (inputs_selector, frequency, callback) {
  frequency = frequency * 1000;

  document.querySelectorAll(inputs_selector).forEach((input) => {
    let prev = input.value;
    let ti;
    const removed = function () { return input.closest("html") === null; };
    const check = function () {
      if (removed()) { if (ti) clearInterval(ti); return; }
      const val = input.value;
      if (prev != val) {
        prev = val;
        if (callback && typeof callback === "function") callback.call(input);
      }
    };
    const reset = function () { if (ti) { clearInterval(ti); ti = setInterval(check, frequency); } };
    check();
    ti = setInterval(check, frequency);
    input.addEventListener("keyup", reset);
    input.addEventListener("click", reset);
    input.addEventListener("mousemove", reset);
  });
};

Filterrific.init = function () {
  const filterrificForm = document.querySelector("#filterrific_filter");
  if (!filterrificForm) return; // guard: not every page has a filter form

  filterrificForm.querySelectorAll("input, textarea, select").forEach((input) => {
    input.addEventListener("change", Filterrific.submitFilterForm);
  });

  Filterrific.observe_field(".filterrific-periodically-observed", 0.5, Filterrific.submitFilterForm);
};

document.addEventListener("turbolinks:load", Filterrific.init);
document.addEventListener("DOMContentLoaded", Filterrific.init);

window.Filterrific = Filterrific;

export default Filterrific;
