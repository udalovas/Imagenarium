//
//  ViewController.swift
//  Filterer
//
//  Created by Алексей Удалов on 20/09/16.
//  Copyright © 2016 udalovas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var secondaryMenu: UIView!
    
    @IBOutlet var bottomMenu: UIView!
    @IBOutlet weak var filterButton: UIButton!
    
    private var rgbaOriginalImage: RGBAImage?
    private var originalImage: UIImage?

    @IBAction func onFilter(sender: UIButton) {
        if(!sender.selected) {
            showSubmenu()
        } else {
            secondaryMenu.removeFromSuperview()
        }
        sender.selected = !sender.selected
    }
    
    func showSubmenu() {
        
        view.addSubview(secondaryMenu)
        
        let bottomConstraint = secondaryMenu.bottomAnchor.constraintEqualToAnchor(bottomMenu.topAnchor)
        let leftConstraint = secondaryMenu.leftAnchor.constraintEqualToAnchor(bottomMenu.leftAnchor)
        let rightConstraint = secondaryMenu.rightAnchor.constraintEqualToAnchor(bottomMenu.rightAnchor)
        
        let heightConstraint = secondaryMenu.heightAnchor.constraintEqualToConstant(44)
        
        NSLayoutConstraint.activateConstraints([bottomConstraint, leftConstraint, rightConstraint, heightConstraint])
        
        view.layoutIfNeeded()
    }
    
    func onApplyFilterClick(sender: UIButton) {
        if(sender.selected) {
            imageView.image = originalImage
        } else {
            imageView.image = GrayScaleFilter.INSTANCE.apply(&rgbaOriginalImage!).toUIImage()
        }
        filterButton.selected = !sender.selected;
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        secondaryMenu.translatesAutoresizingMaskIntoConstraints = false
        secondaryMenu.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        
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

