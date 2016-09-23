//
//  ViewController.swift
//  Filterer
//
//  Created by Алексей Удалов on 20/09/16.
//  Copyright © 2016 udalovas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var filterButton: UIButton!
    
    private var rgbaOriginalImage: RGBAImage?
    private var originalImage: UIImage?

    @IBAction func onApplyFilterClick(sender: UIButton) {
        if(sender.selected) {
            imageView.image = originalImage
        } else {
            imageView.image = GrayScaleFilter.INSTANCE.apply(&rgbaOriginalImage!).toUIImage()
        }
        filterButton.selected = !sender.selected;
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        originalImage = UIImage(named: "london")
        rgbaOriginalImage = RGBAImage(image: originalImage!)
        
        imageView.image = originalImage
        filterButton.setTitle("Original", forState: .Selected)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

