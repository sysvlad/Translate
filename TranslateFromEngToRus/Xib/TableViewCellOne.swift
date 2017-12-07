//
//  TableViewCellOne.swift
//  TranslateFromEngToRus
//
//  Created by Vlad Sys on 11/20/17.
//  Copyright © 2017 Vlad Sys. All rights reserved.
//

import UIKit

class TableViewCellOne: UITableViewCell {

    
    @IBOutlet weak var viewTwo: UIView!
    @IBOutlet weak var viewOne: UIView!
    @IBOutlet weak var flagTow: UIImageView!
    @IBOutlet weak var textTwo: UILabel!
    @IBOutlet weak var flagOne: UIImageView!
    @IBOutlet weak var textOne: UILabel!
 
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewOne.clipsToBounds = true
        viewOne.layer.cornerRadius = 10
        if #available(iOS 11.0, *) {
            viewOne.layer.maskedCorners = [.layerMaxXMinYCorner]
        } else {
            // Fallback on earlier versions
        }
        viewTwo.clipsToBounds = true
        viewTwo.layer.cornerRadius = 10
        if #available(iOS 11.0, *) {
            viewTwo.layer.maskedCorners = [.layerMaxXMaxYCorner]
        } else {
            // Fallback on earlier versions
        }
        flagTow.layer.cornerRadius = 12
        flagTow.layer.borderWidth = 2
        flagTow.layer.borderColor = UIColor.white.cgColor
        flagTow.clipsToBounds = true
        
        flagOne.layer.cornerRadius = 12
        flagOne.layer.borderWidth = 2
        flagOne.layer.borderColor = UIColor.white.cgColor
        flagOne.clipsToBounds = true
    }
    


    
    
    
    
    
}
