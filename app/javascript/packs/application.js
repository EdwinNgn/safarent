import "bootstrap";
import 'mapbox-gl/dist/mapbox-gl.css'; // <-- you need to uncomment the stylesheet_pack_tag in the layout!
import "../plugins/flatpickr"

import { initMapbox } from '../plugins/init_mapbox';
import { loadDynamicBannerText } from '../components/banner';
loadDynamicBannerText();
initMapbox();



import 'select2/dist/css/select2.css';
import { initSelect2 } from '../components/init_select2';

initSelect2();
