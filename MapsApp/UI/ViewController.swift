//
//  ViewController.swift
//  MapTest
//
//  Created by Михаил Задорожный on 13.03.2021.
//

import Mapbox
import SnapKit

class ViewController: UIViewController {
    
    var mapView: MGLMapView!
    let navigationView = UIView()
    let stackView = UIStackView()
    let increaseZoom = UIButton()
    let decreaseZoom = UIButton()
    let myLocation = UIButton()
    let nextMarker = UIButton()
    
    var zoomLevel: Double = 8.0
    var currentCoordinate = 1
    var annotationCounter = 0
    
    var pointAnnotations = [MGLPointAnnotation]()
    let people = Person.createPeople()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        configureMarkers()
    }
    
    private func configureMarkers() {
        people.forEach { person in
            let point = MGLPointAnnotation()
            point.coordinate = person.coordinate
            point.title = "\(person.name), \(person.navigationSystem), \(person.time)"
            pointAnnotations.append(point)
        }
        mapView.addAnnotations(pointAnnotations)
    }
    
    private func setupUI() {
        
        title = "Локатор"
        
        setupMapView()
        setupNavigationView()
        setupStackView()
        setupButtons()
    }
    
    private func setupMapView() {
        
        mapView = MGLMapView(frame: view.bounds, styleURL: MGLStyle.outdoorsStyleURL)
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.showsUserHeadingIndicator = true
        mapView.userTrackingMode = .followWithHeading
        mapView.setCenter(people[0].coordinate, zoomLevel: 9, animated: false)
        
        view.addSubview(mapView)
        mapView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.left.right.equalToSuperview()
        }
    }
    
    private func setupNavigationView() {
        view.addSubview(navigationView)
        navigationView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(8)
            make.right.equalToSuperview().inset(8)
            make.width.equalTo(100)
            make.height.equalTo(350)
        }
    }
    
    private func setupStackView() {
        navigationView.addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalToSuperview()
        }
        
        stackView.addArrangedSubview(increaseZoom)
        stackView.addArrangedSubview(decreaseZoom)
        stackView.addArrangedSubview(myLocation)
        stackView.addArrangedSubview(nextMarker)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
    }
    
    private func setupButtons() {
        increaseZoom.setImage(UIImage(named: "ic_zoom_plus_55dp"), for: .normal)
        decreaseZoom.setImage(UIImage(named: "ic_zoom_minus_55dp"), for: .normal)
        myLocation.setImage(UIImage(named: "ic_mylocation_55dp"), for: .normal)
        nextMarker.setImage(UIImage(named: "ic_next_tracker_55dp"), for: .normal)
        increaseZoom.addTarget(self, action: #selector(incrZoom), for: .touchUpInside)
        decreaseZoom.addTarget(self, action: #selector(decrZoom), for: .touchUpInside)
        nextMarker.addTarget(self, action: #selector(nxtMarker), for: .touchUpInside)
        myLocation.addTarget(self, action: #selector(showMe), for: .touchUpInside)
    }
    

    @objc private func showMe() {
        
        (mapView.zoomLevel > 8) ? (zoomLevel = mapView.zoomLevel) : (zoomLevel = 12)
        
        guard let coordinate = mapView.userLocation?.coordinate else { return }
        
        mapView.setCenter(coordinate, zoomLevel: zoomLevel, animated: true)
    }
    
    @objc private func incrZoom() {
        mapView.zoomLevel =  mapView.zoomLevel + 1
    }
    
    @objc private func decrZoom() {
        mapView.zoomLevel =  mapView.zoomLevel - 1
    }
    
    @objc private func nxtMarker() {
        
        (currentCoordinate == pointAnnotations.count - 1) ? (currentCoordinate = 0) : (currentCoordinate = currentCoordinate + 1)
        
        (mapView.zoomLevel > 8) ? (zoomLevel = mapView.zoomLevel) : (zoomLevel = 12)
        
        mapView.setCenter(pointAnnotations[currentCoordinate].coordinate, zoomLevel: zoomLevel, animated: true)
    }
}

extension ViewController: MGLMapViewDelegate  {
    
    func mapView(_ mapView: MGLMapView, viewFor annotation: MGLAnnotation) -> MGLAnnotationView? {
        
        if annotation is MGLUserLocation && mapView.userLocation != nil {
            return CustomUserLocationAnnotationView()
        }
        
        guard annotation is MGLPointAnnotation else {
            return nil
        }

        let reuseIdentifier = "\(annotation.coordinate.longitude)"

        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)

        if annotationView == nil {
            let anView = CustomAnnotationView(reuseIdentifier: reuseIdentifier)
            anView.imageName = people[annotationCounter].imgName
            annotationView = anView
            
            annotationView!.bounds = CGRect(x: 0, y: 0, width: 40, height: 40)
            annotationCounter = annotationCounter + 1

            let hue = CGFloat(annotation.coordinate.longitude) / 100
            annotationView!.backgroundColor = UIColor(hue: hue, saturation: 0.5, brightness: 1, alpha: 1)
        }

        return annotationView
    }

    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        return true
    }

    func mapView(_ mapView: MGLMapView, calloutViewFor annotation: MGLAnnotation) -> MGLCalloutView? {
 
        return CustomCalloutView(representedObject: annotation)
    }

    func mapView(_ mapView: MGLMapView, tapOnCalloutFor annotation: MGLAnnotation) {
      
        mapView.deselectAnnotation(annotation, animated: true)
        
        guard annotation.title != "You Are Here" else {
            return
        }
        
        let detailVC = DetailViewController()
        
    
            people.forEach { person in
                
                let personTitle = "\(person.name), \(person.navigationSystem), \(person.time)"
                
                if personTitle == annotation.title {
                    detailVC.person = person
                    present(detailVC, animated: true, completion: nil)
                    return
                }
        }
        detailVC.person = people[0]
    }
    
    func mapView(_ mapView: MGLMapView, didFinishLoading style: MGLStyle) {
        style.localizeLabels(into: nil)
    }
}
    
    
    
    
    
    



    
//    func mapView(_ mapView: MGLMapView, viewFor annotation: MGLAnnotation) -> MGLAnnotationView? {
//        
//        if annotation is MGLUserLocation && mapView.userLocation != nil {
//            return CustomUserLocationAnnotationView()
//        }
//        return nil
//    }
    
//    func mapView(_ mapView: MGLMapView, didSelect annotation: MGLAnnotation) {
//        if mapView.userTrackingMode != .followWithHeading {
//            mapView.userTrackingMode = .followWithHeading
//        } else {
//            mapView.resetNorth()
//        }
//        
//        mapView.deselectAnnotation(annotation, animated: false)
//    }






//func mapView(_ mapView: MGLMapView, didFinishLoading style: MGLStyle) {
    
//        let coordinate1 = CLLocationCoordinate2D(latitude: 40.8464, longitude: -87.6835)
//        let coordinate2 = CLLocationCoordinate2D(latitude: 41.8464, longitude: -88.6835)
//        let coordinate3 = CLLocationCoordinate2D(latitude: 41.3464, longitude: -87.9835)
//        let coordinate4 = CLLocationCoordinate2D(latitude: 42.3464, longitude: -89.9835)


//        createMarker(
//            shapeLayerIdentifier: "sLI1",
//            shapeSourceIdentifier: "sSI1",
//            imageName: "face_c_1",
//            coordinate: coordinate1,
//            style: style
//        )
//
//        createMarker(
//            shapeLayerIdentifier: "sLI2",
//            shapeSourceIdentifier: "sSI2",
//            imageName: "face_c_2",
//            coordinate: coordinate2,
//            style: style
//        )
//
//        createMarker(
//            shapeLayerIdentifier: "sLI3",
//            shapeSourceIdentifier: "sSI3",
//            imageName: "face_c_3",
//            coordinate: coordinate3,
//            style: style
//        )
//
//        createMarker(
//            shapeLayerIdentifier: "sLI4",
//            shapeSourceIdentifier: "sSI4",
//            imageName: "face_c_4",
//            coordinate: coordinate4,
//            style: style
//        )
   
//}





//
//func createMarker(shapeLayerIdentifier: String,shapeSourceIdentifier: String, imageName: String, coordinate: CLLocationCoordinate2D, style: MGLStyle) {
//
//  //  coordinates.append(coordinate)
//    let point = MGLPointAnnotation()
//    point.title = "annotation" + imageName
//    point.coordinate = coordinate
//    mapView.addAnnotation(point)
//
//    let shapeSource = MGLShapeSource(identifier: shapeSourceIdentifier, shape: point, options: nil)
//
//    let shapeLayer = MGLSymbolStyleLayer(identifier: shapeLayerIdentifier, source: shapeSource)
//
//    let markerSize = CGSize(width: 113, height: 113)
//
//    UIGraphicsBeginImageContext(markerSize)
//
//    let areaSize = CGRect(x: 0, y: 0, width: markerSize.width, height: markerSize.height)
//    let faceSize = CGRect(x: 24, y: 12, width: markerSize.width - 48 , height: markerSize.height - 44)
//    let circleSize = CGRect(x: 16, y: 8, width: markerSize.width - 32 , height: markerSize.height - 34)
//
//    guard
//        let circle = UIImage(named: "white_circle"),
//        let markerImage = UIImage(named: "ic_tracker_75dp"),
//        let faceImage = UIImage(named: imageName)
//    else {
//        return
//    }
//
//    markerImage.draw(in: areaSize)
//    circle.draw(in: circleSize)
//    faceImage.draw(in: faceSize, blendMode: .normal, alpha: 1)
//
//    guard let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
//    else {
//        return
//    }
//
//    UIGraphicsEndImageContext()
//
//    style.setImage(newImage, forName: imageName)
//    shapeLayer.iconImageName = NSExpression(forConstantValue: imageName)
//    style.addSource(shapeSource)
//    style.addLayer(shapeLayer)
//}
