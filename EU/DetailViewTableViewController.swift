//
//  DetailViewTableViewController.swift
//  EU
//
//  Created by John Linnehan on 9/27/21.
//

import UIKit

class DetailViewTableViewController: UITableViewController {

    @IBOutlet weak var saveBarButton: UIBarButtonItem!
    
    @IBOutlet weak var countryField: UITextField!
    
    @IBOutlet weak var capitalField: UITextField!
    
    var member: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if member == nil {
            member = ""
        }

        countryField.text = member
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        member = countryField.text
    }

    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
}
