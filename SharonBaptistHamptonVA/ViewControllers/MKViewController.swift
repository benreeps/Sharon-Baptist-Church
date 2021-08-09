//
//  MKViewController.swift
//  SharonBaptistHamptonVA
//
//  Created by Benjamin Reeps on 8/2/21.
//

import UIKit
import MapKit

class MKViewController: UIViewController {
    
    private let locationManager = CLLocationManager()
    private var currentCoordinate: CLLocationCoordinate2D?
    
    private var destinations: [MKPointAnnotation] = []
    private var currentRoute: MKRoute?

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var navigateButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var navigationTimeLabel: UILabel!
    @IBOutlet weak var navigateView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        formatButons()
        mapView.delegate = self
        configureLocationServices()
        mapView.showsUserLocation = true
    }
    
    @IBAction func navigateButtonPressed(_ sender: Any) {
        
        launchAppleMapsWithCords()
        
    }
    @IBAction func backButtonPressed(_ sender: UIButton) {
    }
    
    func showUserLocation() {
        
        locationManager.startUpdatingLocation()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        mapView.showsUserLocation = true
        
    }
     func configureLocationServices() {
        
        locationManager.delegate = self
        
        if locationManager.authorizationStatus == .notDetermined {
            locationManager.requestAlwaysAuthorization()
        } else if locationManager.authorizationStatus == .authorizedAlways || locationManager.authorizationStatus == .authorizedWhenInUse {
            beginLocationUpdates(locationManager: locationManager)
            
        }
    }
    
    private func beginLocationUpdates(locationManager: CLLocationManager) {
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        mapView.showsUserLocation = true
        
    }
    
    private func zoomToLatestLocation(with coordinate: CLLocationCoordinate2D) {
        
        let zoomRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000000, longitudinalMeters: 1000000)
        mapView.setRegion(zoomRegion, animated: true)
    }
    
    private func addAnnotations() {
        
        let destinationAnnotation = MKPointAnnotation()
        let sourceAnnotation = MKPointAnnotation()
        
        sourceAnnotation.coordinate = mapView.userLocation.coordinate
        
    
        destinationAnnotation.title = "Sharon Baptist Church"
        destinationAnnotation.coordinate = CLLocationCoordinate2D(latitude: 37.06, longitude: -76.39)
        
        destinations.append(destinationAnnotation)
        mapView.addAnnotation(destinationAnnotation)
        mapView.addAnnotation(sourceAnnotation)
    }
    
    private func constructRoute(userLocation: CLLocationCoordinate2D) {
        
        let directionsRequest = MKDirections.Request()
        
        directionsRequest.source = MKMapItem( placemark: MKPlacemark(coordinate: userLocation))
        directionsRequest.destination = MKMapItem( placemark: MKPlacemark(coordinate: destinations[0].coordinate))
        directionsRequest.requestsAlternateRoutes = true
        directionsRequest.transportType = .automobile
        
        let directions = MKDirections(request: directionsRequest)
        
        directions.calculate { [weak self] (directionsResponse, error) in
        
            guard let strongSelf = self else {return}
        
            if let error = error {
                
                print(error.localizedDescription)
            } else if let response = directionsResponse, response.routes.count > 0 {
                
                let route = response.routes[0]
                let routeTimeSeconds = route.expectedTravelTime
                let routeTimeString = self!.transToHourMinSec(time: Float(routeTimeSeconds))
                
                self!.navigationTimeLabel.text = "\(String(describing: routeTimeString))"
                strongSelf.currentRoute = route
                strongSelf.mapView.addOverlay(response.routes[0].polyline)
                strongSelf.mapView.setVisibleMapRect(response.routes[0].polyline.boundingMapRect, animated: true)
            }
        }
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
    
    func transToHourMinSec(time: Float) -> String {
        
        let allTime: Int = Int(time)
        var hours = 0
        var minutes = 0
        var hoursText = ""
        var minutesText = ""
        var timeToDestinon = ""
        
        hours = allTime / 3600
        hoursText = hours > 9 ? "\(hours)" : "0\(hours)"
        
        minutes = allTime % 3600 / 60
        minutesText = minutes > 9 ? "\(minutes)" : "0\(minutes)"
        
        if hours > 0 {
            
        timeToDestinon = "\(hoursText)h \(minutesText)m drive"
        } else if hours == 0 {
            
        timeToDestinon = "\(minutesText)m drive"
        }
        
        return timeToDestinon 
    }
        
    func formatButons() {
        
        navigateView.backgroundColor = UIColor.systemBlue
        navigateView.layer.cornerRadius = 10
        
        navigateButton.backgroundColor = UIColor.clear
        
        navigationTimeLabel.text = " -- "
                
        backButton.backgroundColor = UIColor.clear
        backButton.tintColor = UIColor.systemBlue
    }
}

extension MKViewController: CLLocationManagerDelegate {
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Did get latest location.")
       
        guard let latestLocation = locations.first else { return }
        
        if currentCoordinate == nil {
            
            zoomToLatestLocation(with: latestLocation.coordinate)
            addAnnotations()
            constructRoute(userLocation: latestLocation.coordinate)
        }
        
        currentCoordinate = latestLocation.coordinate
    }
    
    public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        if locationManager.authorizationStatus == .authorizedAlways || locationManager.authorizationStatus == .authorizedWhenInUse {
            beginLocationUpdates(locationManager: manager)
        }
    }
}

extension MKViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        guard  let currentRoute = currentRoute else {
            
            return MKOverlayRenderer()
        }
        
        let polylineRenderer = MKPolylineRenderer(polyline: currentRoute.polyline)
        polylineRenderer.strokeColor = UIColor.systemBlue
        polylineRenderer.lineWidth = 5
        navigateButton.alpha = 1
        
        return polylineRenderer
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "AnnotationView")
        
        if annotationView == nil {
            
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "AnnotationView")
        }
        
        if let title = annotation.title, title == "Sharon Baptist Church" {
            
            annotationView?.image = UIImage(named: "Destination")
        } else if annotation === mapView.userLocation {
            
            
        }
        
        annotationView?.canShowCallout = true
        
        return annotationView
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
