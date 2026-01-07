/**
 * MapLibre map styles
 *
 * Note: MapLibre uses Mapbox/MapLibre Style JSON (styleURL), not Google "customMapStyle" JSON.
 * 
 * Using OpenStreetMap-based styles without API keys (free public tiles).
 */

// OpenStreetMap Carto style (public, no keys)
export const MAPLIBRE_STYLE_URL_LIGHT = 'https://tiles.openfreemap.org/styles/liberty';

// For now we keep dark == light (basic setup, no external keys).
// You can later add a proper dark style from MapTiler/Stadia/etc.
export const MAPLIBRE_STYLE_URL_DARK = MAPLIBRE_STYLE_URL_LIGHT;

