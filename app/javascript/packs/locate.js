  const locate = document.getElementById('locate');
  const result = document.getElementById('current_city');
  const url = 'https://places-dsn.algolia.net/1/places/reverse?aroundLatLng='
  const post_url = '&language=default'
  locate.addEventListener('click', (event) => {
    event.preventDefault();
    navigator.geolocation.getCurrentPosition((data) => {
      const longGeo = data.coords.longitude;
      const latGeo = data.coords.latitude;
      fetch(`${url}${latGeo},%20${longGeo}${post_url}`)
        .then(response => response.json())
        .then((data) => {
          result.value = data.hits[0].city;
        });
    });
  });
