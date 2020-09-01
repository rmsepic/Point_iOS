//
//  EditTableViewController.swift
//  Point
//
//  Created by Ryland Sepic on 9/1/20.
//  Copyright © 2020 Ryland Sepic. All rights reserved.
//

import UIKit

class EditTableViewController: UITableViewController {
    var rows:[String] = []
    var file = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")

        // Read csv file
        
        var data = readFile(fileName: self.file)
        let csvRows = read_csv(data: data)
        
        /*if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
             let filePath = dir.appendingPathComponent(self.file)
             
             do {
                 let text = try String(contentsOf: filePath, encoding: .utf8)
                rows.append(text)
             }
             catch {
                 /* error handling here */
             }
         } */
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return rows.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        cell.textLabel?.text = rows[indexPath.row]

        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func read_csv(data: String) {
        let result: [String] = []
        
        let rows = data.components(separatedBy: "\n")
        
        self.rows = rows
    }
    
    func readFile(fileName:String)-> String {
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let filepath = dir.appendingPathComponent(file)
            
            do {
                let contents = try String(contentsOfFile: filepath.path, encoding: .utf8) // Read the contents
                return contents
            } catch {
                print("File Read Error for file \(filepath)")
                return ""
            }
        }
    
        return "ERROR"
    }


}
