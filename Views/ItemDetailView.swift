//
//  ItemDetailView.swift
//  CheckList
//
//  Created by Rose Maina on 04/09/2018.
//  Copyright © 2018 Rose Maina. All rights reserved.
//

import UIKit

protocol ItemDetailViewDelegate: class {
    
    func itemDetailViewControllerDidCancel(_ controller: ItemDetailView)
    func itemDetailViewController(_ controller: ItemDetailView, didFinishAdding item: CheckListItem)
    func itemDetailViewController(_ controller: ItemDetailView, didFinishEditing item: CheckListItem)
}

class ItemDetailView: UITableViewController, UITextFieldDelegate {

    // MARK: - Private Instance Properties
    
    @IBOutlet weak var cancelBarButton: UIBarButtonItem!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    @IBOutlet private weak var textField: UITextField!
    
    
    weak var delegate: ItemDetailViewDelegate?
    var itemToEdit: CheckListItem?
    
    // MARK: - Private Instance Methods
    
    @IBAction func cancel() {
        navigationController?.popViewController(animated: true)
        delegate?.itemDetailViewControllerDidCancel(self)
    }
    
    @IBAction func done() {
//        navigationController?.popViewController(animated: true)
        if let itemToEdit = itemToEdit {
            itemToEdit.text = textField.text!
            delegate?.itemDetailViewController(self, didFinishEditing: itemToEdit)
        }  else {
            let item = CheckListItem()
            item.text = textField.text!
            item.checked = false
            delegate?.itemDetailViewController(self, didFinishAdding: item)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let item = itemToEdit {
            title = "Edit Item"
            textField.text = item.text
            doneBarButton.isEnabled = true
        }
        
        navigationItem.largeTitleDisplayMode = .never
        textField.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        textField.becomeFirstResponder()
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
