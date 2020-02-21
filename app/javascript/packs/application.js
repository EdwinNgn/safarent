import "bootstrap";
import 'mapbox-gl/dist/mapbox-gl.css'; // <-- you need to uncomment the stylesheet_pack_tag in the layout!
import "../plugins/flatpickr"
import { loadDynamicBannerText } from '../components/banner';
import "../components/price_filter"
import "../components/price"

import { initMapbox } from '../plugins/init_mapbox';

initMapbox();
loadDynamicBannerText();
initMapbox();

// For tabs in index bookings
$('#myTab a').on('click', function (e) {

  $(this).tab('show')
})

