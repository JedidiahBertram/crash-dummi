//
//  ViewControllerCar.swift
//  Crash Dummi
//
//  Created by Jedidiah Bertram on 7/8/17.
//  Copyright © 2017 Jedidiah Bertram. All rights reserved.
//

import UIKit
import Mapbox

class ViewControllerCar: UIViewController, MGLMapViewDelegate {
    @IBOutlet weak var mapView: MGLMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        mapView.delegate = self

        let point = MGLPointAnnotation()
        point.coordinate = CLLocationCoordinate2D(latitude: 32.7072, longitude: -117.1571)
        point.title = "Petco Park"
        point.subtitle = "Home of the San Diego Padres"
        
        mapView.addAnnotation(point)
        // Do any additional setup after loading the view.
    }
    
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        // Always try to show a callout when an annotation is tapped.
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


