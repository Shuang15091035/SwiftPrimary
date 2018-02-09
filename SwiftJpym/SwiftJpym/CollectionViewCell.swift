//
//  CollectionViewCell.swift
//  SwiftJpym
//
//  Created by admin on 2017/9/18.
//  Copyright © 2017年 liushuang.library. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var myLabel: UILabel!
    public var modelData: String {
        set {
            myLabel.text = newValue
        }
        get {
            return myLabel.text!
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
