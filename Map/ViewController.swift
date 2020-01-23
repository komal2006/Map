//
//  ViewController.swift
//  Map
//
//  Created by komaldeep kaur on 2020-01-22.
//  Copyright © 2020 komaldeep kaur. All rights reserved.
//

import UIKit
import MapKit
class ViewController: UIViewController, UIGestureRecognizerDelegate, MKMapViewDelegate {
  
   var count: Int = 0
    @IBOutlet weak var label6: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    var points: [CLLocationCoordinate2D] = [CLLocationCoordinate2D]()
   var screenPoints: [CGPoint] = [CGPoint]()
   
   override func viewDidLoad() {
     super.viewDidLoad()
    let location: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 51.2538, longitude: -85.3232)
mapView.setCenter(location, animated: true)
     setMapview()
   }
func addPolyline()
{
     let point1: [CLLocationCoordinate2D] = [points[0], points[1]]
     let polyline1 = MKPolyline(coordinates: point1, count: point1.count)
     let point2: [CLLocationCoordinate2D] = [points[1], points[2]]
     let polyline2 = MKPolyline(coordinates: point2, count: point2.count)
     let point3: [CLLocationCoordinate2D] = [points[2], points[3]]
     let polyline3 = MKPolyline(coordinates: point3, count: point3.count)
     let point4: [CLLocationCoordinate2D] = [points[3], points[4]]
     let polyline4 = MKPolyline(coordinates: point4, count: point4.count)
    let point5: [CLLocationCoordinate2D] = [points[4], points[0]]
    let polyline5 = MKPolyline(coordinates: point5, count: point5.count)
    let point6: [CLLocationCoordinate2D] = [points[5], points[5]]
       let polyline6 = MKPolyline(coordinates: point6, count: point6.count)
     mapView?.addOverlay(polyline1)
     mapView?.addOverlay(polyline2)
     mapView?.addOverlay(polyline3)
    mapView?.addOverlay(polyline4)
    mapView?.addOverlay(polyline5)
     mapView?.addOverlay(polyline6)
   }
   
   func addPolygon() {
     let polygon = MKPolygon(coordinates: &points, count: points.count)
     mapView?.addOverlay(polygon)
     
     let location1: CLLocation = CLLocation(latitude: points[0].latitude, longitude: points[0].longitude)
     let location2: CLLocation = CLLocation(latitude: points[1].latitude, longitude: points[1].longitude)
     let location3: CLLocation = CLLocation(latitude: points[2].latitude, longitude: points[2].longitude)
    let location4: CLLocation = CLLocation(latitude: points[3].latitude, longitude: points[3].longitude)
    let location5: CLLocation = CLLocation(latitude: points[4].latitude, longitude: points[4].longitude)
    // let location6: CLLocation = CLLocation(latitude: points[5].latitude, longitude: points[5].longitude)
     
     let distance1 = location1.distance(from: location2)
     let distance2 = location2.distance(from: location3)
     let distance3 = location1.distance(from: location3)
     let distance4 = location1.distance(from: location4)
     let distance5 = location1.distance(from: location5)
    
     
     
     let label1: UILabel = UILabel(frame: CGRect(x: (screenPoints[0].x + screenPoints[1].x - 80) / 2, y: (screenPoints[0].y + screenPoints[1].y) / 2, width: 120, height: 30))
     label1.text = "\(Int(distance1/1000)) km"
     self.mapView.addSubview(label1)
     
     let label2: UILabel = UILabel(frame: CGRect(x: (screenPoints[1].x + screenPoints[2].x - 80) / 2, y: (screenPoints[1].y + screenPoints[2].y) / 2, width: 120, height: 30))
     label2.text = "\(Int(distance2/1000)) km"
     self.mapView.addSubview(label2)
     
     let label3: UILabel = UILabel(frame: CGRect(x: (screenPoints[2].x + screenPoints[3].x - 80) / 2, y: (screenPoints[2].y + screenPoints[3].y) / 2, width: 120, height: 30))
     label3.text = "\(Int(distance3/1000)) km"
     self.mapView.addSubview(label3)
    
    let label4: UILabel = UILabel(frame: CGRect(x: (screenPoints[3].x + screenPoints[4].x - 80) / 2, y: (screenPoints[3].y + screenPoints[4].y) / 2, width: 120, height: 30))
        label4.text = "\(Int(distance4/1000)) km"
        self.mapView.addSubview(label4)
    
    let label5: UILabel = UILabel(frame: CGRect(x: (screenPoints[4].x + screenPoints[0].x - 80) / 2, y: (screenPoints[4].y + screenPoints[0].y) / 2, width: 120, height: 30))
        label5.text = "\(Int(distance5/1000)) km"
        self.mapView.addSubview(label5)
    
  //  let label6: UILabel = UILabel(frame: CGRect(x: (screenPoints[5].x + screenPoints[0].x - 80) / 2, y: (screenPoints[5].y + screenPoints[0].y) / 2, width: 120, height: 30))
    
        label6.text = "\(Int(distance1+distance2+distance3+distance4+distance5)) km"
        print ("hayeefdsfdsfafkldkflsflsldkflkdslkfs \(label6)")
      // self.mapView.addSubview(label6)
    
     
   }
   
   func setMapview(){
     self.mapView.delegate = self
     let lpgr = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(gestureReconizer:)))
     lpgr.numberOfTapsRequired = 1
     lpgr.delegate = self
     self.mapView.addGestureRecognizer(lpgr)
   }
   
   func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
     return true
   }
   
   
   @objc func handleTap(gestureReconizer: UITapGestureRecognizer) {
     count = count + 1
     
     if (count < 6) {
       let touchLocation = gestureReconizer.location(in: mapView)
       screenPoints.append(touchLocation)
       let annotation: MKPointAnnotation = MKPointAnnotation()
       let locationCoordinate = mapView.convert(touchLocation,toCoordinateFrom: mapView)
       annotation.coordinate = locationCoordinate
       self.mapView.addAnnotation(annotation)
       points.append(locationCoordinate)
//       print("Tapped at lat: \(locationCoordinate.latitude) long: \(locationCoordinate.longitude)")
     }
     if (count <= 4) {
        
       addpolyline2()
        //addPolygon()
     } else if (count == 5){
       addPolygon()
       // addPolyline()
//     } else if (count <= 4) {
//        addPolyline()
    }
   }
   
   func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
     if overlay is MKCircle {
       let renderer = MKCircleRenderer(overlay: overlay)
       renderer.fillColor = UIColor.black.withAlphaComponent(0.5)
       renderer.strokeColor = UIColor.blue
       renderer.lineWidth = 2
       return renderer
       
     } else if overlay is MKPolyline {
       let renderer = MKPolylineRenderer(overlay: overlay)
       renderer.strokeColor = UIColor.green
       renderer.lineWidth = 5
       return renderer
       
     } else if overlay is MKPolygon {
       let renderer = MKPolygonRenderer(polygon: overlay as! MKPolygon)
       renderer.fillColor = UIColor.red.withAlphaComponent(0.5)
       return renderer
     }
     
     return MKOverlayRenderer()
   }
    public func addpolyline2() {
        mapView.delegate = self
        let polyline = MKPolyline (coordinates: &points, count: points.count)
        mapView.addOverlay(polyline)
    }
}

