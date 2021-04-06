//
//  ViewController.swift
//  LabTest2
//
//  Created by Gokul Murugan on 2021-04-06.
//

import UIKit
import MapKit
import CoreLocation
import CoreData

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    // MARK: Outlets
    @IBOutlet weak var Lat: UILabel!
    @IBOutlet weak var Lon: UILabel!
    
    // MARK: Variable
    let locationManager = CLLocationManager()
    var Latitude:Double = 0
    var Longitude:Double = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled(){
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            self.locationManager.startUpdatingLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        Latitude = locValue.latitude
        Longitude = locValue.longitude
        print("locations = \(Latitude) \(Longitude)")
        Lat.text = "\(Latitude)"
        Lon.text = "\(Longitude)"
    }
    
    
    @IBAction func SaveLocation(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let entity = NSEntityDescription.insertNewObject(forEntityName: "Location", into: context)
        entity.setValue(Lat.text, forKey: "lat")
        entity.setValue(Lon.text, forKey: "lon")
        entity.setValue(Date(), forKey: "time")
        print("Trying to store")
        do{
            try context.save()
            let alert = UIAlertController(title: "Data Saved", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        catch{
            print(error)
            print("Unable to store Data")
        }
    }
    
    

}

