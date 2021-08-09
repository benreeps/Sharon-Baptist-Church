//
//  MapViewController.swift
//  SharonBaptistHamptonVA
//
//  Created by Benjamin Reeps on 7/22/21.
//
/*
import UIKit
import MapKit
import CoreLocation


class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var navigateButton: UIButton!
    
    
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 10000
    let address = "Sharon Baptist Church 2625 North Armistead Ave, Hampton, VA 23666"
    
    //private var currentPlace: CLPlacemark?
    let geoCoder = CLGeocoder()
    var directionsArray: [MKDirections] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formatNavigateButton()
        navigateButton.alpha = 1
        self.tabBarController?.tabBar.isHidden = true
        checkLocationServices()
        getDirections()
    }
    
    @IBAction func navigateButtonPressed(_ sender: UIButton) {
        //launchAppleMapsWithCords()
        //getDirections()
    }
   
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            // setup our location manager
            setupLocationManager()
            checkLocationAuthorization()
            
        }
    }
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
    }
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        
        case .authorizedWhenInUse:
            //mapView.showsUserLocation = true
           // updateLocation()
           //locationManager.startUpdatingLocation()
            startTackingUserLocation()
            break
            
        case .denied:
            break
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            
        case .authorizedAlways:
            break
            
        case .restricted:
            // show alert
            break
            
        @unknown default:
            break
            
        }
    }
    
    func startTackingUserLocation() {
            mapView.showsUserLocation = true
            centerViewOnUserLocation()
            locationManager.startUpdatingLocation()
            
        }
    /*
    func getCenterLocation(for mapView: MKMapView) -> CLLocation {
            let latitude = mapView.centerCoordinate.latitude
            let longitude = mapView.centerCoordinate.longitude
            
            return CLLocation(latitude: latitude, longitude: longitude)
        }
    */
    func centerViewOnUserLocation() {
            if let location = locationManager.location?.coordinate {
                let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
                mapView.setRegion(region, animated: true)
            }
        }
    
    func getDirections() {
        guard let location = locationManager.location?.coordinate else {
            return
        }
        
        let request = createDirectionsRequest(from: location)
        let directions = MKDirections(request: request)
        resetMapView(withNew: directions)
        
        directions.calculate { (response, error) in
            guard let response = response else {return}
            
            for route in response.routes {
              
                self.mapView.addOverlay(polyline)
                self.mapView.addOverlay(route.polyline)
                self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
            }
        }
    }
    
    func resetMapView(withNew directions: MKDirections) {
            mapView.removeOverlays(mapView.overlays)
            directionsArray.append(directions)
            let _ = directionsArray.map { $0.cancel() }
        }
    
    func createDirectionsRequest(from coordinate: CLLocationCoordinate2D) -> MKDirections.Request {
        let latitude: CLLocationDegrees = 37.06
        let longitude: CLLocationDegrees = -76.39
        
            let destinationCoordinate       = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            let startingLocation            = MKPlacemark(coordinate: coordinate)
            let destination                 = MKPlacemark(coordinate: destinationCoordinate)
            
            let request                     = MKDirections.Request()
            request.source                  = MKMapItem(placemark: startingLocation)
            request.destination             = MKMapItem(placemark: destination)
            request.transportType           = .automobile
            request.requestsAlternateRoutes = true
            
            return request
        }
    /*
    func updateLocation() {
        if let userLocation = locationManager.location?.coordinate {
            
            let latitude: CLLocationDegrees = 37.06
            let longitude: CLLocationDegrees = -76.39
            
            let destinationLocation = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            let destinationPin = customPin(pinTitle: "Sharon Baptist Church", pinSubTitle: "Hampton, VA", location: destinationLocation)
            let destinationPlacemark = MKPlacemark(coordinate: destinationLocation)
            
            let userLoactionPin = customPin(pinTitle: "Your Location", pinSubTitle: "", location: userLocation)
            let userPlaceMark = MKPlacemark(coordinate: userLocation)
            
            let directionRequest = MKDirections.Request()
            directionRequest.source = MKMapItem(placemark: userPlaceMark)
            directionRequest.destination = MKMapItem(placemark: destinationPlacemark)
            directionRequest.transportType = .automobile
            
            let directions = MKDirections(request: directionRequest)
            
                directions.calculate { (response, error) in
                guard let directionResponse = response else {
                    if let error = error {
                        print("error getting directiosn==\(error.localizedDescription)")
                    }
                    return
                }
                
                
              
                let route = directionResponse.routes[0]
                    for route in response.routes {
                        self.mapView.addOverlay(route.polyline)
                    }
                self.mapView.removeOverlays(self.mapView.overlays)
                self.mapView.addOverlay(route.polyline, level: .aboveRoads)
                
                let rect = route.polyline.boundingMapRect
                 self.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
                
            }
            
            
            self.mapView.delegate = self
            self.mapView.addAnnotation(userLoactionPin)
            self.mapView.addAnnotation(destinationPin)
           
        }
        
    }
    */
    func formatNavigateButton() {
        navigateButton.layer.cornerRadius = 10
        navigateButton.alpha = 0
        
    }
    
    func launchAppleMapsWithCords() {
        let latitude: CLLocationDegrees = 37.06
        let longitude: CLLocationDegrees = -76.39
        let regionDistance: CLLocationDistance = 1000
        let coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center), MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)]
        let placeMark = MKPlacemark(coordinate: coordinates)
        let mapItem = MKMapItem(placemark: placeMark)
        
        mapItem.name = "Sharon Baptist Church, Hampton, VA"
        mapItem.openInMaps(launchOptions: options)
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let routePolyline = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(polyline: routePolyline)
        renderer.strokeColor = .blue
        
        return renderer
        
        }
        return MKOverlayRenderer()
    }
}
/*
extension MapViewController {
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.lineWidth = 5
        renderer.strokeColor = .systemBlue
        navigateButton.alpha = 1
        
        return renderer
    }
    
    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
        if let annotationView = views.first {
            if let annotation = annotationView.annotation {
                if annotation is MKUserLocation {
                    
                    let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
                    mapView.setRegion(region, animated: true)
                    
                }
            }
        }
    }
    
}

class customPin: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(pinTitle: String, pinSubTitle: String, location: CLLocationCoordinate2D) {
        self.title = pinTitle
        self.subtitle = pinSubTitle
        self.coordinate = location
    }
}
*/
*/
