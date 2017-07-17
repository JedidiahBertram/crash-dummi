//
//  ViewControllerCar.swift
//  Crash Dummi
//
//  Created by Jedidiah Bertram on 7/8/17.
//  Copyright © 2017 Jedidiah Bertram. All rights reserved.
//

import UIKit
import CoreLocation
import Mapbox
import Firebase
import FirebaseDatabase
import UserNotifications

class ViewControllerCar: UIViewController, CLLocationManagerDelegate, MGLMapViewDelegate {
    @IBOutlet weak var mapView: MGLMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CDLocationManager.shared.startLocationUpdates()
        
        //print(userId)
        
        mapView.delegate = self
        
        let ref = Database.database().reference()
        
                ref.keepSynced(true)
        
                ref.observeSingleEvent(of: .childAdded, with: { (DataSnapshot) in
                    if  let userDict = DataSnapshot.value as? [String:Any] {
        
                        for (key, _) in userDict {
                            
                            if key != ("\(userId)") {
                              let cyclistId = key
                                
                                let rootRef = Database.database().reference().child("users").child("\(cyclistId)")
                                
                                rootRef.observe(DataEventType.value, with: { (DataSnapshot) in
                                    let cyclistDict = DataSnapshot.value as? [String : AnyObject] ?? [:]
                                    
                                    //print(userDict)
                                    let cyclistLat = cyclistDict["latitude"]
                                    let cyclistLon = cyclistDict["longitude"]
//                         --->!!!THIS IS A ANNOTATION REMOVAL METHOD THAT DOES NOT WORK!!!<---
                                    
//                                    var annotationCount = 0
//                                    
                                    let point = MGLPointAnnotation()
//
//                                    annotationCount += 1
//                                    
//                                    if annotationCount > 0 {
//                                        self.mapView.removeAnnotations([point])
//                                        annotationCount -= 1
//                                    }
                                    
                                    point.coordinate = CLLocationCoordinate2D(latitude: cyclistLat! as! CLLocationDegrees, longitude: cyclistLon! as! CLLocationDegrees)
                                    self.mapView.addAnnotation(point)
                                    
                                    
                                })
                            }
                        }
                        //for value in userDict.values {
        
        
        
                    }
                    
        
                })

    }
    
    
    
        
    
//
        // Do any additional setup after loading the view.
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        CDLocationManager.shared.stopLocationUpdates()
    }
    
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        // Always try to show a callout when an annotation is tapped.
        return true
    }
    
    func mapViewDidFinishLoadingMap(_ mapView: MGLMapView) {
        mapView.setCenter((mapView.userLocation?.coordinate)!, animated: false)
        mapView.userTrackingMode = .follow
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


