//
//  GithubButton.swift
//  OctoPodium
//
//  Created by Nuno Gonçalves on 13/03/16.
//  Copyright © 2016 Nuno Gonçalves. All rights reserved.
//

import UIKit

class GithubButton : UIView {
    
    @IBOutlet weak var topLevelSubView: UIView!
    @IBOutlet weak var leftView: UIView!
    @IBOutlet weak var rightView: UIView!
    @IBOutlet weak var rightViewLeft: UIView!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    @IBOutlet weak var loadingView: GithubLoadingView!
    
    private let borderColor = UIColor(rgbValue: 0xD5D5D5).CGColor
    private let gradientColors = [
        UIColor(rgbValue: 0xFCFCFC).CGColor,
        UIColor(rgbValue: 0xEEEEEE).CGColor
    ]

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        topLevelSubView.frame = frame
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
        topLevelSubView.frame = bounds
    }
    
    private func commonInit() {
        NSBundle.mainBundle().loadNibNamed("GithubButton", owner: self, options: nil)
        addSubview(topLevelSubView)
        setLayoutColors()
    }
    
    private func setLayoutColors() {
        setBorder()
        applyGradient()
    }
    
    private func setBorder() {
        for v in [leftView, rightView, rightViewLeft] { v.layer.borderColor = borderColor }
    }
    
    private func applyGradient() {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = topLevelSubView.bounds
        gradient.colors = gradientColors
        leftView.layer.insertSublayer(gradient, atIndex: 0)
    }
    
    func setName(name: String) {
        nameLabel.text = name
    }

    func setValue(value: String) {
        valueLabel.text = value
        loadingView.hide()
        loadingView.stop()
    }
    
    func setImage(image: UIImage) {
        imageView.image = image
    }
}