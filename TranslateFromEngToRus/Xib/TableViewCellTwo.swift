//
//  TableViewCellTwo.swift
//  TranslateFromEngToRus
//
//  Created by Vlad Sys on 11/20/17.
//  Copyright © 2017 Vlad Sys. All rights reserved.
//

import UIKit

class TableViewCellTwo: UITableViewCell {

    @IBOutlet weak var viewTwo: UIView!
    @IBOutlet weak var viewOne: UIView!
    @IBOutlet weak var flagTwo: UIImageView!
    @IBOutlet weak var flagOne: UIImageView!
    @IBOutlet weak var textTwo: UILabel!
    @IBOutlet weak var textOne: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        viewOne.clipsToBounds = true
        viewOne.layer.cornerRadius = 10
        if #available(iOS 11.0, *) {
            viewOne.layer.maskedCorners = [.layerMinXMinYCorner]
        } else {
            // Fallback on earlier versions
        }
        viewTwo.clipsToBounds = true
        viewTwo.layer.cornerRadius = 10
        if #available(iOS 11.0, *) {
            viewTwo.layer.maskedCorners = [.layerMinXMaxYCorner]
        } else {
            // Fallback on earlier versions
        }
        
        flagTwo.layer.cornerRadius = 12
        flagTwo.layer.borderWidth = 2
        flagTwo.layer.borderColor = UIColor.white.cgColor
        flagTwo.clipsToBounds = true
        
        flagOne.layer.cornerRadius = 12
        flagOne.layer.borderWidth = 2
        flagOne.layer.borderColor = UIColor.white.cgColor
        flagOne.clipsToBounds = true
    }


    
}
