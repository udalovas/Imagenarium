//
//  FilterCellView.swift
//  Imagenarium
//
//  Created by Алексей Удалов on 04/10/16.
//  Copyright © 2016 udalovas. All rights reserved.
//

import UIKit

public class FilterCellView: UICollectionViewCell {
    
    @IBOutlet public var imageView: UIImageView!
    @IBOutlet public var labelView: UILabel!
    
    override public var selected: Bool {
        didSet {
            self.backgroundColor = selected ? UIColor.grayColor().colorWithAlphaComponent(0.5) : nil
        }
    }
}