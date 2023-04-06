//
//  DetailViewController.swift
//  SampleApp
//
//  Created by jc.kim on 3/27/23.
//

import Foundation
import UIKit
import MapKit
import MessageUI
//import CommonUI

final class DetailViewController: UIViewController {
  
  private let infoLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.preferredFont(forTextStyle: .body)
    label.textColor = .label
    label.numberOfLines = 0
    return label
  }()
  
  private let addressLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.preferredFont(forTextStyle: .body)
    label.textColor = .label
    label.numberOfLines = 0
    return label
  }()
  
  private let companyLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.preferredFont(forTextStyle: .body)
    label.textColor = .label
    label.numberOfLines = 0
    return label
  }()
  
  private lazy var websiteButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.tintColor = .darkGray
    button.setImage(
      UIImage(
        systemName: "house",
        withConfiguration: UIImage.SymbolConfiguration(pointSize: 44, weight: .regular)
      ), for: .normal
    )
    button.addTarget(self, action: #selector(open), for: .touchUpInside)
    return button
  }()
  
  private lazy var emailButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.tintColor = .darkGray
    button.setImage(
      UIImage(
        systemName: "envelope.badge",
        withConfiguration: UIImage.SymbolConfiguration(pointSize: 44, weight: .regular)
      ), for: .normal
    )
    button.addTarget(self, action: #selector(send), for: .touchUpInside)
    return button
  }()
  
  private lazy var phoneButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.tintColor = .darkGray
    button.setImage(
      UIImage(
        systemName: "phone",
        withConfiguration: UIImage.SymbolConfiguration(pointSize: 44, weight: .regular)
      ), for: .normal
    )
    button.addTarget(self, action: #selector(phoneCall), for: .touchUpInside)
    return button
  }()
  
  private lazy var mapView: MKMapView = {
    let mapView = MKMapView()
    mapView.translatesAutoresizingMaskIntoConstraints = false
    //    mapView.delegate = self
    mapView.mapType = .standard
    mapView.isZoomEnabled = true
    mapView.isScrollEnabled = true
    mapView.layer.cornerRadius = 12
    return mapView
  }()
  
  private let hStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .horizontal
    stackView.distribution = .fillEqually
    stackView.alignment = .center
    return stackView
  }()
  
  private let vStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.distribution = .fill
    stackView.alignment = .fill
    stackView.spacing = 30
    return stackView
  }()
  
  private let contentView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  private let scrollView: UIScrollView = {
    let scrollView = UIScrollView()
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    return scrollView
  }()
  
  private let user: User
  
  let locationManager: CLLocationManager = {
    let locationManager = CLLocationManager()
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.requestWhenInUseAuthorization()
    locationManager.startUpdatingLocation()
    return locationManager
  }()
  
  
  init(user: User) {
    self.user = user
    super.init(nibName: nil, bundle: nil)
    
    setupView()
    fetchMap()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupView() {
    title = "Detail Info"
    view.backgroundColor = .white
    navigationItem.largeTitleDisplayMode = .never
    vStackView.addArrangedSubview(infoLabel)
    vStackView.addArrangedSubview(addressLabel)
    vStackView.addArrangedSubview(companyLabel)
    hStackView.addArrangedSubview(websiteButton)
    hStackView.addArrangedSubview(emailButton)
    hStackView.addArrangedSubview(phoneButton)
    vStackView.addArrangedSubview(hStackView)
    vStackView.addArrangedSubview(mapView)
    scrollView.addSubview(contentView)
    scrollView.addSubview(vStackView)
    view.addSubview(scrollView)
    
    infoLabel.text =
    """
    < INFO >
    NAME : \(user.name)
    USER NAME : \(user.username)
    EMAIL :\(user.email)
    PHONE :\(user.phone)
    WEBSITE :\(user.website)
    """
    
    addressLabel.text =
    """
    < ADDRESS >
    STREET : \(user.address.street)
    SUITE : \(user.address.suite)
    CITY : \(user.address.city)
    ZIPCODE : \(user.address.zipcode)
    LATITUDE : \(user.address.geo.lat)
    LONGITUDE : \(user.address.geo.lng)
    """
    
    companyLabel.text =
    """
    < COMPANY >
    NAME : \(user.company.name)
    CATCH PHRASE : \(user.company.catchPhrase)
    BUSINESS SERVICE : \(user.company.bs)
    """
    
    NSLayoutConstraint.activate([
      scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
      scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
      scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      
      contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
      contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
      contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
      contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
      contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
      
      vStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
      vStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
      vStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
      vStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      
      mapView.heightAnchor.constraint(equalToConstant: 400),
    ])
  }
  
}


// MARK: - Website

extension DetailViewController {
  
  @objc
  private func open() {
    guard let url = URL(string: "http://\(user.website)") else {
      self.alert(message: "URL 객체 생성에 실패하였습니다. \(user.website)이 유효한 값인지 확인해주세요.")
      return
    }
    
    let urlOpener = URLOpener()
    
    urlOpener.open(url: url) { isValid in
      if isValid == false {
        self.alert(message: "웹사이트를 열 수 없습니다. \(url) 또는 기기를 확인해주세요.")
      }
    }
  }
  
}

// MARK: - Mail

extension DetailViewController: MFMailComposeViewControllerDelegate {
  
  @objc
  private func send() {
    guard MFMailComposeViewController.canSendMail() else {
      self.alert(message: "메일 앱을 열 수 없습니다. 기기를 확인해주세요.")
      return
    }
    
    let composer = MFMailComposeViewController()
    composer.mailComposeDelegate = self
    composer.setToRecipients([user.email])
    present(composer, animated: true)
  }
  
  func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
    if let error = error {
      self.alert(message: error.localizedDescription)
      controller.dismiss(animated: true)
    }
    controller.dismiss(animated: true)
  }
  
}

// MARK: - Phone

extension DetailViewController {
  
  @objc
  private func phoneCall() {
    
    guard let url = URL(string: "tel://\(user.phone)") else {
      self.alert(message: "URL 객체 생성에 실패하였습니다. \(user.phone)이 유효한 값인지 확인해주세요.")
      return
    }
    
    let urlOpener = URLOpener()
    
    urlOpener.open(url: url) { isValid in
      if isValid == false {
        self.alert(message: "전화 앱을 열 수 없습니다. \(url) 또는 기기를 확인해주세요.")
      }
    }
    
  }
  
}


// MARK: - Map

extension DetailViewController {
  
  func makeCoordinateRegion(_ geo: Geo) -> MKCoordinateRegion {
    let latitude = Double(geo.lat) ?? 0.0
    let longitude = Double(geo.lng) ?? 0.0
    let delta = 0.01
    let coordinateLocation = CLLocationCoordinate2DMake(latitude, longitude)
    let spanValue = MKCoordinateSpan(latitudeDelta: delta, longitudeDelta: delta)
    return MKCoordinateRegion(center: coordinateLocation, span: spanValue)
  }
  
  func makeAnnotation(_ user: User) -> MKPointAnnotation {
    let annotation = MKPointAnnotation()
    annotation.title = user.address.city
    annotation.subtitle = "\(user.address.street)\n\(user.address.suite)\n\(user.address.zipcode)"
    return annotation
  }
  
  func fetchMap() {
    let region = makeCoordinateRegion(user.address.geo)
    let annotation = makeAnnotation(user)
    annotation.coordinate = region.center
    
    mapView.setRegion(region, animated: true)
    mapView.addAnnotation(annotation)
  }
  
}

//extension DetailViewController: MKMapViewDelegate {
//
//  func addAnnotation(){
//    guard let latitude = Double(user.address.geo.lat),
//          let longitude = Double(user.address.geo.lng) else { return }
//    print(latitude, longitude, "l;;")
//    let annotation = MKPointAnnotation()
//
//    annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
//    annotation.title = "Some Title"
//    annotation.subtitle = "Some Subtitle"
//    self.mapView.addAnnotation(annotation)
//  }
//
//  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//    guard annotation is MKPointAnnotation else { print("no mkpointannotaions"); return nil }
//
//    let reuseId = "pin"
//    var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
//
//    if pinView == nil {
//      pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
//      pinView!.canShowCallout = true
//      pinView!.rightCalloutAccessoryView = UIButton(type: .infoDark)
//      pinView!.pinTintColor = UIColor.black
//    }
//    else {
//      pinView!.annotation = annotation
//    }
//    return pinView
//  }
//
//  func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
//    print("tapped on pin ")
//  }
//
//  //https://nashorn.tistory.com/entry/Apple-MapKit-%EC%82%AC%EC%9A%A9%ED%95%98%EA%B8%B0
//  func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
//    if control == view.rightCalloutAccessoryView {
//      if (view.annotation?.title!) != nil {
//        print("do something")
//      }
//    }
//  }
//}
















//protocol MFMailOpenerProtocol {
//  static func canSendMail() -> Bool
//  var mailComposeDelegate: MFMailComposeViewControllerDelegate? { get set }
//  func setToRecipients(_ toRecipients: [String]?)
//  //  func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?)
//}
//
//extension MFMailComposeViewController: MFMailOpenerProtocol { }
//
//
//class MFMailOpenerProvider: NSObject {
//
//  private let controller: MFMailOpenerProtocol
//
//  init(
//    controller: MFMailOpenerProtocol,
//    recipients: [String]
//  ) {
//    self.controller = controller
//    super.init()
//    self.controller.mailComposeDelegate = self
//    self.controller.setToRecipients(recipients)
//  }
//
//  func open(on viewController: UIViewController, completion: ((Bool) -> Swift.Void)?) {
//    if MFMailComposeViewController.canSendMail() {
//      viewController.present(self.controller, animated: true)
//    } else {
//      completion?(false)
//    }
//  }
//
//}
//
//extension MFMailOpenerProvider: MFMailComposeViewControllerDelegate {
//  func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
//    if let error = error {
//      print(error.localizedDescription)
//      controller.dismiss(animated: true)
//    }
//
//    switch result {
//    case .cancelled: print("cancelled")
//    case .failed: print("failed")
//    case .saved: print("saved")
//    case .sent: print("sent")
//    @unknown default: break
//    }
//
//    controller.dismiss(animated: true)
//  }
//}



