//
//  ViewController.swift
//  EU
//
//  Created by John Linnehan on 9/27/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var addBarButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    var members = ["Austria",
                   "Belgium",
                   "Bulgaria",
                   "Croatia",
                   "Cyprus",
                   "Czechia",
                   "Denmark",
                   "Estonia",
                   "Finland",
                   "France",
                   "Germany",
                   "Greece",
                   "Hungary",
                   "Ireland",
                   "Italy",
                   "Latvia",
                   "Lithuania",
                   "Luxembourg",
                   "Malta",
                   "Netherlands",
                   "Poland",
                   "Portugal",
                   "Romania",
                   "Slovakia",
                   "Slovenia",
                   "Spain",
                   "Sweden",
                   "United Kingdom"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            let destination = segue.destination as! DetailViewTableViewController
            let selectedIndexPath = tableView.indexPathForSelectedRow!
            destination.member = members[selectedIndexPath.row]
        } else {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                tableView.deselectRow(at: selectedIndexPath, animated: true)
            }
        }
    }

    @IBAction func unwindFromDetail(segue: UIStoryboardSegue) {
        let source = segue.source as! DetailViewTableViewController
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            members[selectedIndexPath.row] = source.member
            tableView.reloadRows(at: [selectedIndexPath], with: .automatic)
        } else {
            let newIndexPath = IndexPath(row: members.count, section: 0)
            members.append(source.member)
            tableView.insertRows(at: [newIndexPath], with: .bottom)
            tableView.scrollToRow(at: newIndexPath, at: .bottom, animated: true)
        }

    }


    @IBAction func editButtonPressed(_ sender: UIBarButtonItem) {
        
       
            if tableView.isEditing {
                tableView.setEditing(false, animated: true)
                sender.title = "Edit"
                addBarButton.isEnabled = true
            } else {
                tableView.setEditing(true, animated: true)
                sender.title = "Done"
                addBarButton.isEnabled = false
            }
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = members[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            members.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let itemToMove = members[sourceIndexPath.row]
        members.remove(at: sourceIndexPath.row)
        members.insert(itemToMove, at: destinationIndexPath.row)
    }
    
}
