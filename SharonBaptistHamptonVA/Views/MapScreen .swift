//
//  MapScreen .swift
//  SharonBaptistHamptonVA
//
//  Created by Benjamin Reeps on 6/3/21.
//

import Foundation
import UIKit
import MapKit



class MapScreen: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var getDirectionsButton: UIButton!
    
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 10000
    let address = "Sharon Baptist Church 2625 North Armistead Ave, Hampton, VA 23666"
    
    private var currentPlace: CLPlacemark?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkLocationServices()
        self.tabBarController?.tabBar.isHidden = true
        formatGetDirectionsButton()
       // getDirectionsButton.alpha = 0
    }
    @IBAction func getDirectionsButtonPressed(_ sender: UIButton) {
       // getAddress()
        //getDirections()
        
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
    
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapView.setRegion(region, animated: true)
        }
        getDirectionsButton.alpha = 1
    }
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            // setup our location manager
            setupLocationManager()
            checkLocationAuthorization()
        } else {
            // show alert letting the user know they have to turn this on.
        }
    }
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            centerViewOnUserLocation()
            locationManager.startUpdatingLocation()
            
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
    
    func getAddress() {
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(address) { (placemarks, error) in
            guard let placemarks = placemarks, let location = placemarks.first?.location else {
                print("No location found")
                return
            }
            print(location)
        }
    }
    
    func formatGetDirectionsButton() {
        getDirectionsButton.layer.cornerRadius = 10
        
    }
}

extension MapScreen: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let firstLocation = locations.first else {return}
        //let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        // let region = MKCoordinateRegion.init(center: center, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
        //mapView.setRegion(region, animated: true)
        
        CLGeocoder().reverseGeocodeLocation(firstLocation) { places, _ in
            
            guard
                let firstPlace = places?.first
            else {
                return
            }
            
            self.currentPlace = firstPlace
            
        }
        
        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            checkLocationAuthorization()
        }
        
    }
}

