//
//  AddItemViewController.swift
//  CheckList
//
//  Created by Rose Maina on 04/09/2018.
//  Copyright © 2018 Rose Maina. All rights reserved.
//

import UIKit

class AddItemViewController: UITableViewController, UITextFieldDelegate {

    @IBOutlet private weak var textField: UITextField!
    @IBOutlet weak var cancelBarButton: UIBarButtonItem!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
        textField.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        textField.becomeFirstResponder()
    }
    

    
    @IBAction func cancel() {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func done() {
        navigationController?.popViewController(animated: true)
        
        print("Contents of textField: \(textField.text!)")
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
    // Copy and paste and update the textfield
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // getting old text from the textfield, checking the range of the text that has changed and replacing it with new text.
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)
        let newText = oldText.replacingCharacters(in: stringRange!, with: string)
        
        if newText.isEmpty {
            doneBarButton.isEnabled = false
        } else {
            doneBarButton.isEnabled = true
        }
        return true
    }
}
