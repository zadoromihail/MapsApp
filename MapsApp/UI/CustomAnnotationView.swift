//
//  CustomAnnotationView.swift
//  MapTest
//
//  Created by Михаил Задорожный on 16.03.2021.
//

import Mapbox

class CustomAnnotationView: MGLAnnotationView {
    
    var imageName: String?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let image = ImageCreator.createMarkerImage(imageName: imageName ?? "face_c_1")
        let myImage = image.cgImage
        
        let myLayer = CALayer()
        
        myLayer.frame = CGRect(x: -20, y: 0, width: bounds.width * 2, height: bounds.height * 2)
        myLayer.contents = myImage
        layer.addSublayer(myLayer)
        layer.backgroundColor = UIColor.clear.cgColor
        layer.borderColor = UIColor.clear.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        let animation = CABasicAnimation(keyPath: "borderWidth")
        animation.duration = 0.1
        layer.borderWidth = selected ? bounds.width / 4 : 2
    }
}
