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
    
    var nations: [Nation] = []
    var usesEuro = [true,
                    true,
                    false,
                    false,
                    true,
                    false,
                    false,
                    true,
                    true,
                    true,
                    true,
                    true,
                    false,
                    true,
                    true,
                    true,
                    true,
                    true,
                    true,
                    true,
                    false,
                    true,
                    false,
                    true,
                    true,
                    true,
                    false,
                    false
]
    var capitals = ["Vienna",
                    "Brussels",
                    "Sofia",
                    "Zagreb",
                    "Nicosia",
                    "Prague",
                    "Copenhagen",
                    "Tallinn",
                    "Helsinki",
                    "Paris",
                    "Berlin",
                    "Athens",
                    "Budapest",
                    "Dublin",
                    "Rome",
                    "Riga",
                    "Vilnius",
                    "Luxembourg (city)",
                    "Valetta",
                    "Amsterdam",
                    "Warsaw",
                    "Lisbon",
                    "Bucharest",
                    "Bratislava",
                    "Ljubljana",
                    "Madrid",
                    "Stockholm",
                    "London"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        for index in 0..<members.count {
            let newNation = Nation(country: members[index], capital: capitals[index], usesEuro: usesEuro[index])
            nations.append(newNation)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            let destination = segue.destination as! DetailViewTableViewController
            let selectedIndexPath = tableView.indexPathForSelectedRow!
            destination.nation = nations[selectedIndexPath.row]
        } else {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                tableView.deselectRow(at: selectedIndexPath, animated: true)
            }
        }
    }

    @IBAction func unwindFromDetail(segue: UIStoryboardSegue) {
        let source = segue.source as! DetailViewTableViewController
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            nations[selectedIndexPath.row] = source.nation
            tableView.reloadRows(at: [selectedIndexPath], with: .automatic)
        } else {
            let newIndexPath = IndexPath(row: members.count, section: 0)
            nations.append(source.nation)
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
        cell.textLabel?.text = nations[indexPath.row].country
        cell.detailTextLabel?.text = nations[indexPath.row].country
        cell.detailTextLabel?.text = "Capital: \(nations[indexPath.row].capital)"
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            members.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let itemToMove = nations[sourceIndexPath.row]
        nations.remove(at: sourceIndexPath.row)
        nations.insert(itemToMove, at: destinationIndexPath.row)
    }
    
    
}
