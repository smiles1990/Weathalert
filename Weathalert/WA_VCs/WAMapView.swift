//
//  ViewController.swift
//  Weathalert
//
//  Created by Scott Browne on 20/12/2017.
//  Copyright © 2017 Smiles Dev. All rights reserved.
//

import UIKit
import MapKit

protocol MapViewControllerDelegate {
    func reloadTable()
}

class WAMapView: UIViewController, MKMapViewDelegate, UISearchBarDelegate {
    
    var selectedLocation = CLLocationCoordinate2D()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var delegate: MapViewControllerDelegate!
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let searchRequest = MKLocalSearchRequest()
        searchRequest.naturalLanguageQuery = searchBar.text
        let activeSearch = MKLocalSearch(request: searchRequest)
        activeSearch.start { (response, error) in
            if response == nil {
                print("error")
            } else {
                let annotations = self.mapView.annotations
                self.mapView.removeAnnotations(annotations)
                
                let latitude = response?.boundingRegion.center.latitude
                let longitude = response?.boundingRegion.center.longitude
                
                let annotation = MKPointAnnotation()
                annotation.title = searchBar.text
                annotation.coordinate = CLLocationCoordinate2DMake(latitude!, longitude!)
                
                self.mapView.addAnnotation(annotation)
                
                let coordinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude!, longitude!)
                let span = MKCoordinateSpanMake(0.1, 0.1)
                let region = MKCoordinateRegionMake(coordinate, span)
                self.mapView.setRegion(region, animated: true)
                
                self.searchBar.resignFirstResponder()
            }
        }
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "Found") as? MKPinAnnotationView
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "Found")
        } else {
            annotationView?.annotation = annotation
        }
    
        annotationView?.pinTintColor = self.view.backgroundColor
        
        return annotationView
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addLocation(_ sender: Any) {
        
        if mapView.annotations.count == 1 {
            let annot = mapView.annotations[0]
            let annotCoords = annot.coordinate
            
            let newLoc = WALocation.init(locName: annot.title!!, locLong: annotCoords.longitude, locLat: annotCoords.latitude)
            
            newLoc.getForecast()
            
            appDelegate.profile.profileLocations.append(newLoc)

            delegate?.reloadTable()
            
            dismiss(animated: true, completion: nil)
        }
    
    }
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        
//        let coordView = segue.destination as! CoordVC
//        coordView.latitude = selectedLocation.latitude
//        coordView.longitude = selectedLocation.longitude
//        
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        mapView.showsScale = true
        mapView.showsPointsOfInterest = true
        mapView.showsUserLocation = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

