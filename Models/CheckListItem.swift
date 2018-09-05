//
//  CheckListItem.swift
//  CheckList
//
//  Created by Rose Maina on 28/08/2018.
//  Copyright © 2018 Rose Maina. All rights reserved.
//

import Foundation

class CheckListItem {
    
    var text = ""
    var checked = false
    
    func toggleChecked() {
        checked = !checked
    }
}
