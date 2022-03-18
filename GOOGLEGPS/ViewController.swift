//
//  ViewController.swift
//  GOOGLEGPS
//
//  Created by Greens-Apple on 16/03/22.
//  Copyright © 2022 greens. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation


class ViewController: UIViewController ,CLLocationManagerDelegate,GMSMapViewDelegate{
    
   
    @IBOutlet weak var map: GMSMapView!
    @IBOutlet weak var location: UITextField!
    @IBOutlet weak var destination: UITextField!
    var locationManager = CLLocationManager()
    var lat = 0.0
    var long = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()
        locationmanager()
        
    }
    func locationmanager(){
             locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        
              
        }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("didUpdateLocations",locations)
        let  userLocation:CLLocation = locations.last!
        let camera = GMSCameraPosition.camera(withLatitude:userLocation.coordinate.latitude, longitude:userLocation.coordinate.longitude, zoom: 6.0)
        self.map?.animate(to: camera)

        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude:userLocation.coordinate.latitude, longitude:userLocation.coordinate.longitude)
        marker.title = ""
        marker.snippet = ""
        marker.map = map
        marker.appearAnimation = .pop
        
        let geoCoder = CLGeocoder()
                  let location = CLLocation(latitude:userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
                       //selectedLat and selectedLon are double values set by the app in a previous process

                       geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in

                           var placeMark: CLPlacemark!
                           placeMark = placemarks?[0]
                          
                           if let locationName = placeMark.addressDictionary!["Name"] as? NSString {
                              marker.snippet = String(locationName)
                              print(locationName)
                           }

                           if let street = placeMark.addressDictionary!["Thoroughfare"] as? NSString {
                              marker.snippet = String(street)
                                print(street)
                           }
                           if let city = placeMark.addressDictionary!["City"] as? NSString {
                            marker.title = String(city)
                               print(city)
                           }

                           if let zip = placeMark.addressDictionary!["ZIP"] as? NSString {
                              marker.snippet = String(zip)
                              print(zip)
                           }

                           if let country = placeMark.addressDictionary!["Country"] as? NSString {
                              marker.snippet = String(country)
                              print(country)
                           }

                       })
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("didFailWithError",error)
    }
    @IBAction func Go(_ sender: Any) {
        self.performSegue(withIdentifier: "connect", sender: self)
    }
}

   
