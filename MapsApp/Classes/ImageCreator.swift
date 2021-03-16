//
//  ImageCreator.swift
//  MapTest
//
//  Created by Михаил Задорожный on 16.03.2021.
//

import Mapbox

class ImageCreator {
    
   static func createMarkerImage(imageName: String) -> UIImage {
        
        let markerSize = CGSize(width: 113, height: 113)
        
        UIGraphicsBeginImageContext(markerSize)
        
        let areaSize = CGRect(x: 0, y: 0, width: markerSize.width, height: markerSize.height)
        let faceSize = CGRect(x: 24, y: 12, width: markerSize.width - 48 , height: markerSize.height - 44)
        let circleSize = CGRect(x: 16, y: 8, width: markerSize.width - 32 , height: markerSize.height - 34)
        
        guard
            let circle = UIImage(named: "white_circle"),
            let markerImage = UIImage(named: "ic_tracker_75dp"),
            let faceImage = UIImage(named: imageName)
        else {
            return UIImage()
        }
        
        markerImage.draw(in: areaSize)
        circle.draw(in: circleSize)
        faceImage.draw(in: faceSize, blendMode: .normal, alpha: 1)
        
        guard let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        else {
            return UIImage()
        }
        
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    static func createIconImage(imageName: String) -> UIImage {
        
        let imageSize = CGSize(width: 113, height: 113)
        
        UIGraphicsBeginImageContext(imageSize)
       
        let areaSize = CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height)
        let faceSize = CGRect(x: 16, y: 8, width: imageSize.width - 32 , height: imageSize.height - 20)
        
        guard
            let circle = UIImage(named: "white_circle"),
            let faceImage = UIImage(named: imageName)
        else {
            return UIImage()
        }
        
        circle.draw(in: areaSize)
        faceImage.draw(in: faceSize, blendMode: .normal, alpha: 1)
        
        guard let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        else {
            return UIImage()
        }
        
        UIGraphicsEndImageContext()
        
        return newImage
    }
}
