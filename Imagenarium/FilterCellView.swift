//
//  FilterCellView.swift
//  Imagenarium
//
//  Created by Алексей Удалов on 04/10/16.
//  Copyright © 2016 udalovas. All rights reserved.
//

import UIKit

open class FilterCellView: UICollectionViewCell {
    
    @IBOutlet open var imageView: UIImageView!
    @IBOutlet open var labelView: UILabel!
    
    override open var isSelected: Bool {
        didSet {
            self.backgroundColor = isSelected ? UIColor.gray.withAlphaComponent(0.5) : nil
        }
    }
}
