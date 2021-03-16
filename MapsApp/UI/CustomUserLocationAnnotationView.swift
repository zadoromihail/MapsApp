//
//  CustomUserLocationAnnotationView.swift
//  MapTest
//
//  Created by Михаил Задорожный on 15.03.2021.
//

import Mapbox

class CustomUserLocationAnnotationView: MGLUserLocationAnnotationView {
    
    let size: CGFloat = 60
    var dot: CALayer!

    override func update() {

        if frame.isNull {
            frame = CGRect(x: 0, y: 0, width: size, height: size)
            return setNeedsLayout()
        }
        
        if CLLocationCoordinate2DIsValid(userLocation!.coordinate) {
            setupLayers()
            updateHeading()
        }
    }
    
    private func updateHeading() {
        
        if let heading = userLocation!.heading?.trueHeading {
           
            let rotation: CGFloat = -MGLRadiansFromDegrees(mapView!.direction - heading)
            if abs(rotation) > 0.01 {
                
                CATransaction.begin()
                CATransaction.setDisableActions(true)
                dot.setAffineTransform(CGAffineTransform.identity.rotated(by: rotation))
                CATransaction.commit()
            }
        }
    }
    
    private func setupLayers() {
   
        if dot == nil {
            dot = CALayer()
            dot.bounds = CGRect(x: 0, y: 0, width: size, height: size)
            dot.cornerRadius = size / 2
       
            let myImage = UIImage(named: "rotated_tracker")?.cgImage
            dot.contents = myImage
                
           layer.addSublayer(dot)
        }
    }
}
