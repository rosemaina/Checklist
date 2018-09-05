//
//  ChecklistViewController.swift
//  CheckList
//
//  Created by Rose Maina on 27/08/2018.
//  Copyright © 2018 Rose Maina. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController, ItemDetailViewDelegate {

    // MARK: Public Instance Properties
    
    var items: [CheckListItem]
    
    required init?(coder aDecoder: NSCoder) {
        
        items = [CheckListItem]()
        
        let row0Item = CheckListItem()
        row0Item.text = "Walk the dog"
        row0Item.checked = false
        items.append(row0Item)
        
        let row1Item = CheckListItem()
        row1Item.text = "Brush my teeth"
        row1Item.checked = false
        items.append(row1Item)
        
        let row2Item = CheckListItem()
        row2Item.text = "Learn iOS Development"
        row2Item.checked = false
        items.append(row2Item)
        
        let row3Item = CheckListItem()
        row3Item.text = "Soccer practice"
        row3Item.checked = false
        items.append(row3Item)
        
        let row4Item = CheckListItem()
        row4Item.text = "Eat ice cream"
        row4Item.checked = false
        items.append(row4Item)
        
        let row5Item = CheckListItem()
        row5Item.text = "Run a mile"
        row5Item.checked = false
        items.append(row5Item)
        
        let row6Item = CheckListItem()
        row6Item.text = "Set an alarm"
        row6Item.checked = false
        items.append(row6Item)
        
        let row7Item = CheckListItem()
        row7Item.text = "Finish my bucketlist"
        row7Item.checked = false
        items.append(row7Item)
        
        super.init(coder: aDecoder)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        items.remove(at: indexPath.row)
        
        //        tableView.reloadData()
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
    
    // MARK: - DataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
        
        let item = items[indexPath.row]
        
        configureText(for: cell, with: item)
        configureCheckMark(for: cell, with: item)
        
        return cell
    }
    
    // MARK: - Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            
            let item = items[indexPath.row]
            item.toggleChecked()
            
            configureCheckMark(for: cell, with: item)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addItem" {
            let controller = segue.destination as!  ItemDetailView
            controller.delegate = self
        } else if segue.identifier == "editItem" {
            let controller = segue.destination as! ItemDetailView
            controller.delegate = self
            
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
                
                controller.itemToEdit = items[indexPath.row]
            }
        }
    }
    
    // MARK: Instance Methods
    
    @objc func addTapped() {
        //        let newRowIndex = items.count
        //        let item = CheckListItem()
        //
        ////        item.text = " I am a new row"
        //        item.checked = true
        //
        //        var titles = ["Take one", "Take two", "Take three", "Take four", "Take five", "Take six"]
        //
        //        let randomNumber = arc4random_uniform(UInt32(titles.count))
        //        let title = titles[Int(randomNumber)]
        //
        //        item.text = title
        //        items.append(item)
        //
        //        let indexPath = IndexPath(row: newRowIndex, section: 0)
        //        let indexPaths = [indexPath]
        //
        //        tableView.insertRows(at: indexPaths, with: .automatic)
    }
    
    func itemDetailViewControllerDidCancel(_ controller: ItemDetailView) {
        navigationController?.popViewController(animated: true)
    }
    
    func itemDetailViewController(_ controller: ItemDetailView, didFinishEditing item: CheckListItem) {
        
        if let index = items.index(of: item) {
            let indexPath = IndexPath(row: index, section: 0)
            
            if let cell = tableView.cellForRow(at: indexPath) {
                configureText(for: cell, with: item)
            }
        }
        navigationController?.popViewController(animated: true)
    }
    
    func itemDetailViewController(_ controller: ItemDetailView, didFinishAdding item: CheckListItem) {
        
        let newIndexRow = items.count
        items.append(item)
        
        let indexPath = IndexPath(row: newIndexRow, section: 0)
        let indexPaths = [indexPath]
        
        tableView.insertRows(at: indexPaths, with: .automatic)
        navigationController?.popViewController(animated: true)
    }
    
    func configureCheckMark(for cell: UITableViewCell, with item: CheckListItem) {
        
        let label = cell.viewWithTag(1001) as! UILabel
        
        if item.checked {
            label.text = "√"
        } else {
            label.text = ""
        }
    }
    
    func configureText(for cell: UITableViewCell, with item: CheckListItem) {
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = item.text
    }
    
    
}

