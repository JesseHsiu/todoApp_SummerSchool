//
//  CustomTableViewCell.swift
//  DOIT
//
//  Created by 修敏傑 on 8/10/15.
//  Copyright (c) 2015 NTU. All rights reserved.
//

import Foundation
import AIFlatSwitch

class CustomTableViewCell : UITableViewCell {
    var onDoneTapped : (() -> Void)? = nil
    
    @IBInspectable @IBOutlet var doneUI: AIFlatSwitch!
    
    func doneBtnPressed()
    {
        if let doneTap = onDoneTapped
        {
            doneTap()
        }
    }
    
}