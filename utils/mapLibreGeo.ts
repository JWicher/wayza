export type LatLngLike = { latitude: number; longitude: number };

export type MapLibreBounds = {
  ne: [number, number]; // [lon, lat]
  sw: [number, number]; // [lon, lat]
};

export function getMapLibreBounds<T extends LatLngLike>(coords: T[]): MapLibreBounds | null {
  if (!coords.length) return null;

  let minLat = coords[0].latitude;
  let maxLat = coords[0].latitude;
  let minLon = coords[0].longitude;
  let maxLon = coords[0].longitude;

  for (let i = 1; i < coords.length; i++) {
    const { latitude, longitude } = coords[i];
    if (latitude < minLat) minLat = latitude;
    if (latitude > maxLat) maxLat = latitude;
    if (longitude < minLon) minLon = longitude;
    if (longitude > maxLon) maxLon = longitude;
  }

  return {
    ne: [maxLon, maxLat],
    sw: [minLon, minLat],
  };
}

export function toLineStringFeature<T extends LatLngLike>(coords: T[]) {
  return {
    type: 'Feature' as const,
    geometry: {
      type: 'LineString' as const,
      coordinates: coords.map((c) => [c.longitude, c.latitude] as [number, number]),
    },
    properties: {},
  };
}





