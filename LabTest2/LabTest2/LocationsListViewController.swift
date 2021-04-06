//
//  LocationsListViewController.swift
//  LabTest2
//
//  Created by Gokul Murugan on 2021-04-06.
//

import UIKit
import CoreData

class LocationsListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    

    @IBOutlet weak var LocationsTableView: UITableView!
    var locArray:[loc] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell") as! CustomTableViewCell
        cell.Latitude.text = "Latitude: \(locArray[indexPath.row].lat)"
        cell.Longitude.text = "Longitude: \(locArray[indexPath.row].lon)"
        let date = locArray[indexPath.row].date
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date!)
        let minutes = calendar.component(.minute, from: date!)
        let Day = calendar.component(.day, from: date!)
        let month = calendar.component(.month, from: date!)
        let year = calendar.component(.year, from: date!)
        cell.Date.text = "Date: \(Day)-\(month)-\(year)"
        cell.Time.text = "Time: \(hour):\(minutes)"
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        let alert = UIAlertController(title: "Delete?", message: "Are you sure you want to delete this entry?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.destructive, handler: { _ in
            self.deleteData(index: indexPath.row)
        }))
        self.present(alert, animated: true, completion: nil)
        
     
    }
    
    
    func loadData()
    {
        locArray = []
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Location")
                request.returnsObjectsAsFaults = false
                do {
                    let result = try context.fetch(request)
                    for data in result as! [NSManagedObject] {
                        let lat = data.value(forKey: "lat") as! String
                        let lon = data.value(forKey: "lon") as! String
                        let time = data.value(forKey: "time") as! Date
                        let newLoc:loc = LabTest2.loc(lat:lat, lon:lon, date: time)
                        locArray.append(newLoc)
                        print(locArray.count)
                    }
                    LocationsTableView.reloadData()
                } catch {
                    print("Fetching data Failed")
                }
    }

    func deleteData(index:Int) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Location")
            request.returnsObjectsAsFaults = false
        do{
            let result = try context.fetch(request)
            
            if (index <= locArray.count)
            {
            context.delete(result[index] as! NSManagedObject)
            try context.save()
            print("Item deleted")
            loadData()
            }
        }catch{
            print("error")
        }
    }
    
    
    
    
}


struct loc {
    
    var lat:String = ""
    var lon:String = ""
    var date:Date? = nil
    
    init(lat:String, lon:String, date:Date) {
        self.lat = lat
        self.lon = lon
        self.date = date
    }
    
}
