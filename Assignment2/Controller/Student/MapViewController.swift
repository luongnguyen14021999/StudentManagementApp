//
//  MapViewController.swift
//  Assignment2
//
//  Created by Nguyen Dinh Luong on 9/10/20.
//  Copyright © 2020 Nguyen Dinh Luong. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, UISearchBarDelegate {
    
    
    @IBOutlet weak var myMapView: MKMapView!
    
    
    var address: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.beginIgnoringInteractionEvents()
          let activityIndicator = UIActivityIndicatorView()
              
              activityIndicator.center = self.view.center
              activityIndicator.hidesWhenStopped = true
              activityIndicator.stopAnimating()
              
              self.view.addSubview(activityIndicator)

              
              dismiss(animated: true, completion: nil)
              
              let searchRequest = MKLocalSearch.Request()

              searchRequest.naturalLanguageQuery = address
              
              let activeSearch = MKLocalSearch(request: searchRequest)
              
              activeSearch.start {(respond, error) in
                  activityIndicator.stopAnimating()
                  UIApplication.shared.endIgnoringInteractionEvents()
                  
                  if(respond == nil) {
                      print("ERROR")
                  } else {
                      let annotations = self.myMapView.annotations
                      self.myMapView.removeAnnotations(annotations)
                      
                      let latitude =  respond?.boundingRegion.center.latitude
                      let longitude = respond?.boundingRegion.center.longitude
                      
                      let annotation = MKPointAnnotation()
                      annotation.title = self.address
                      annotation.coordinate = CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!)
                      self.myMapView.addAnnotation(annotation)
                      
                      let coordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude!, longitude!)
                      let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
                      let region = MKCoordinateRegion(center: coordinate,span: span)
                      self.myMapView.setRegion(region, animated: true)
                }
            }
    
    }
    

}
