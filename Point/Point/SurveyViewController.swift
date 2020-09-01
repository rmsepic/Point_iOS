//
//  SurveyViewController.swift
//  Point
//
//  Created by Ryland Sepic on 7/15/20.
//  Copyright © 2020 Ryland Sepic. All rights reserved.
//

import CoreLocation
import MessageUI
import UIKit

class SurveyViewController: UIViewController, MFMailComposeViewControllerDelegate {
    let location_manager = CLLocationManager()  // NEEDS to be declared globally so the permissions notification shows properly
    
    /// Personal information given at the beginning
    var current_entry = ""  // Keeps track of the current entry
    var user:String = ""
    var project: String = ""
    var project_file = ""
    
    @IBOutlet weak var lat_label: UILabel!
    @IBOutlet weak var long_label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.project_file = user + "-" + project + ".csv"   // Title of file
        createFile() // Crate the csv file which will be used
        
        var curr_location: CLLocation!
        self.location_manager.requestWhenInUseAuthorization()
        
        if(CLLocationManager.authorizationStatus() == .authorizedAlways || CLLocationManager.authorizationStatus() == .authorizedWhenInUse) {
            curr_location = self.location_manager.location
    
          //  print("Lat \(curr_location.coordinate.latitude)")
          // print("Long \(curr_location.coordinate.longitude)")
        } else {
            print("Did not receive user permission for location")
        }
        
        //displayLocation()
    }
    
    @IBAction func add_lithic(_ sender: Any) {
        writeToFile(text: "lithic")
    }
    
    @IBAction func add_bone(_ sender: Any) {
        writeToFile(text: "bone")
    }
    
    @IBAction func add_metal(_ sender: Any) {
        writeToFile(text: "metal")
    }
    
    @IBAction func add_groundstone(_ sender: Any) {
        writeToFile(text: "groundstone")
    }
    
    @IBAction func add_FAR(_ sender: Any) {
        writeToFile(text: "FAR")
    }
    
    @IBAction func add_feature(_ sender: Any) {
        writeToFile(text: "feature")
    }
    
    @IBAction func add_other(_ sender: Any) {
        writeToFile(text: "other")
    }
    
    @IBAction func add_note(_ sender: Any) {
            
     /*
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let file_url = dir.appendingPathComponent(file)
            
            do {
                try line.write(to: file_url, atomically: false, encoding: String.Encoding.utf8)
            } catch {
                print("ERROR when trying to write to file")
            }
        }
    */
    }
    
    @IBAction func edit_entries(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let editVC = storyboard.instantiateViewController(identifier: "editVC") as! EditTableViewController
        editVC.file = project_file
        self.navigationController?.pushViewController(editVC, animated: true)
    }
    
    @IBAction func delete_last_entry(_ sender: Any) {
    
    }
    
    /// Export the information from the CSV file
    @IBAction func export(_ sender: Any) {
        let file = getFilePath()
        let activityViewController : UIActivityViewController = UIActivityViewController(activityItems: [file], applicationActivities: nil)

        activityViewController.excludedActivityTypes = [
            UIActivity.ActivityType.assignToContact,
            UIActivity.ActivityType.saveToCameraRoll,
            UIActivity.ActivityType.addToReadingList,
            UIActivity.ActivityType.postToFlickr,
            UIActivity.ActivityType.postToVimeo,
        ]

        self.present(activityViewController, animated: true, completion: nil)
    }
    
    func createFile() {
        let file = self.user + "-" + self.project + ".csv"
        let text = "User,Project,Device,Artifact,Note,Latitude,Longitude,Error"
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let file_url = dir.appendingPathComponent(file)
            
            do {
                try text.write(to: file_url, atomically: false, encoding: String.Encoding.utf8)
            } catch {
                print("ERROR when trying to write to file")
            }
        }
    }
    
    func displayLocation() {
        let location_queue = DispatchQueue(label: "location_queue")
        
        location_queue.async {
            while true {
                let curr_location:CLLocation! = self.location_manager.location
                self.lat_label.text = String(curr_location.coordinate.latitude)
                self.long_label.text = String(curr_location.coordinate.longitude)
            }
        }
    }
    
    func writeToFile(text: String) {
        let file = self.user + "-" + self.project + ".csv"
        
        let curr_location:CLLocation! = self.location_manager.location
        let lat = String(curr_location.coordinate.latitude)
        let long = String(curr_location.coordinate.longitude)
        
        let line:String = self.user + "," + self.project + "," + text + ",no note," + lat + "," + long + ",error" + "\n"
        self.current_entry = line
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let file_url = dir.appendingPathComponent(file)
            let file_handle: FileHandle? = FileHandle(forUpdatingAtPath: file_url.path)

            file_handle?.seekToEndOfFile()
            file_handle?.write(line.data(using: .utf8)!)
            
     //       do {
     //           try line.write(to: file_url, atomically: false, encoding: String.Encoding.utf8)
     //       } catch {
     //           print("ERROR when trying to write to file")
     //       }
        }
    }
    
    /// Function returns the file path for the stored CSV file
    func getFilePath() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
