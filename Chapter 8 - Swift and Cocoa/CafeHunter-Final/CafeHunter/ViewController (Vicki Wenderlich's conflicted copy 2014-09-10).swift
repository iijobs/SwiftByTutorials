//
//  ViewController.swift
//  CafeHunter
//
//  Created by Matt Galloway on 15/07/2014.
//  Copyright (c) 2014 Razeware. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
  
  /* TODO: class constant - not yet supported in compiler */
  let searchDistance: CLLocationDistance = 1000
  
  @IBOutlet var mapView: MKMapView!
  @IBOutlet var loginView: FBLoginView!
  
  private var locationManager: CLLocationManager!
  private var lastLocation: CLLocation?
  private var cafes: [Cafe] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.locationManager = CLLocationManager()
    self.locationManager.delegate = self
    
    self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Refresh, target: self, action: "refresh:")
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    self.checkLocationAuthorizationStatus()
  }
  
  private func checkLocationAuthorizationStatus() {
    if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
      self.mapView.showsUserLocation = true
    } else {
      self.locationManager.requestWhenInUseAuthorization()
    }
  }
  
  private func centerMapOnLocation(location: CLLocation) {
    let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, searchDistance, searchDistance)
    self.mapView.setRegion(coordinateRegion, animated: true)
  }
  
  private func fetchCafesAroundLocation(location: CLLocation) {
    if !FBSession.activeSession().isOpen {
      let alert = UIAlertController(title: "Error", message: "Login first!", preferredStyle: .Alert)
      alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
      self.presentViewController(alert, animated: true, completion: nil)
      return
    }
    
    let urlString = "https://graph.facebook.com/v2.0/search/?access_token=\(FBSession.activeSession().accessTokenData.accessToken)&type=place&q=cafe&center=\(location.coordinate.latitude),\(location.coordinate.longitude)&distance=\(Int(searchDistance))"
    let url = NSURL(string: urlString)
    println("Requesting from FB with URL: \(url)")
    let request = NSURLRequest(URL: url)
    NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {
      (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
      
      var error: NSError?
      let jsonObject: AnyObject! = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(0), error: &error)
      if let jsonObject = jsonObject as? [String:AnyObject] {
        if error == nil {
          println("Data returned from FB:\n\(jsonObject)")
          if let data = JSONValue.fromObject(jsonObject)?["data"]?.array {
            var cafes: [Cafe] = []
            for cafeJSON in data {
              if let cafeJSON = cafeJSON.object {
                if let cafe = Cafe.fromJSON(cafeJSON) {
                  cafes.append(cafe)
                }
              }
            }
            self.mapView.removeAnnotations(self.cafes)
            self.cafes = cafes
            self.mapView.addAnnotations(cafes)
          }
        }
      }
    }
  }
  
  func refresh(sender: UIBarButtonItem) {
    if let location = self.lastLocation {
      self.centerMapOnLocation(location)
      self.fetchCafesAroundLocation(location)
    } else {
      let alert = UIAlertController(title: "Error", message: "No location yet!", preferredStyle: .Alert)
      alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
      self.presentViewController(alert, animated: true, completion: nil)
    }
  }
  
}

extension ViewController: CLLocationManagerDelegate {
  
  func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
    self.checkLocationAuthorizationStatus()
  }
  
}

extension ViewController: MKMapViewDelegate {
  
  func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
    if let annotation = annotation as? Cafe {
      let identifier = "pin"
      var view: MKPinAnnotationView
      if let dequeuedView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier) as? MKPinAnnotationView {
        dequeuedView.annotation = annotation
        view = dequeuedView
      } else {
        view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        view.canShowCallout = true
        view.calloutOffset = CGPoint(x: -5, y: 5)
        view.rightCalloutAccessoryView = UIButton.buttonWithType(.DetailDisclosure) as UIView
      }
      return view
    }
    return nil
  }
  
  func mapView(mapView: MKMapView!, annotationView view: MKAnnotationView!, calloutAccessoryControlTapped control: UIControl!) {
    if let viewController = self.storyboard.instantiateViewControllerWithIdentifier("CafeView") as? CafeViewController {
      if let cafe = view.annotation as? Cafe {
        viewController.cafe = cafe
        viewController.delegate = self
        self.presentViewController(viewController, animated: true, completion: nil)
      }
    }
  }
  
  func mapView(mapView: MKMapView!, didUpdateUserLocation userLocation: MKUserLocation!) {
    let newLocation = userLocation.location
    let distance = self.lastLocation?.distanceFromLocation(newLocation)
    if distance == nil || distance! > searchDistance {
      self.lastLocation = newLocation
      self.centerMapOnLocation(newLocation)
      self.fetchCafesAroundLocation(newLocation)
    }
  }
  
  func mapView(mapView: MKMapView!, didFailToLocateUserWithError error: NSError!) {
    println(error)
    let alert = UIAlertController(title: "Error", message: "Failed to obtain location!", preferredStyle: .Alert)
    alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
    self.presentViewController(alert, animated: true, completion: nil)
  }
  
}

extension ViewController: CafeViewControllerDelegate {
  
  func cafeViewControllerDidFinish(viewController: CafeViewController) {
    self.dismissViewControllerAnimated(true, completion: nil)
  }
  
}
