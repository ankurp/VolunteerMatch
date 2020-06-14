import { Controller } from 'stimulus';

export default class PostController extends Controller {
  connect() {
    const mapkit = window.mapkit;
    mapkit.init({
      authorizationCallback: (done) => {
        fetch('/map-token')
          .then(res => res.text())
          .then(token => done(token))
          .catch(error => {});
      }
    });
    const coordinates = JSON.parse(this.element.dataset.coordinates)
    const coordinate = new mapkit.Coordinate(coordinates.lat, coordinates.lng);
    const span = new mapkit.CoordinateSpan(0.1, 0.1);
    const region = new mapkit.CoordinateRegion(coordinate, span);
    const map = new mapkit.Map('map', {
      region: region,
      showsUserLocationControl: true,
      showsScale: mapkit.FeatureVisibility.Visible
    });
    
    const annotation = new mapkit.MarkerAnnotation(coordinate);
    map.addAnnotation(annotation);
  }
}
