//
//  CenterViewController.swift
//  SlideOutNavigation
//
//  Created by James Frost on 03/08/2014.
//  Copyright (c) 2014 James Frost. All rights reserved.
//

import UIKit
import LBTAComponents

@objc
protocol CenterViewControllerDelegate {
  @objc optional func toggleLeftPanel()
  @objc optional func toggleRightPanel()
  @objc optional func collapseSidePanels()
}

class CenterViewController: UIViewController {
  
    var imageView: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "ID-10029135.jpg")
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    var titleLabel: UILabel = {
        var label = UILabel()
        label.text = "Jumping School"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    var creatorLabel: UILabel = {
        var label = UILabel()
        label.text = "Nick Perkins w/ help from Vlado"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .center
        label.textColor = .lightGray
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBarItems()
        
        //add to view
        self.view.addSubview(imageView)
        self.view.addSubview(titleLabel)
        self.view.addSubview(creatorLabel)
        
        //place in view
        imageView.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 20, leftConstant: 20, bottomConstant: 0, rightConstant: 20, widthConstant: 0, heightConstant: 300)
        titleLabel.anchor(imageView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 20, leftConstant: 12, bottomConstant: 0, rightConstant: 12, widthConstant: 0, heightConstant: 30)
        titleLabel.anchorCenterXToSuperview()
        creatorLabel.anchor(titleLabel.bottomAnchor, left: titleLabel.leftAnchor, bottom: nil, right: titleLabel.rightAnchor, topConstant: 12, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 16)
        creatorLabel.anchorCenterXToSuperview()
        
    }
  
  var delegate: CenterViewControllerDelegate?
  
  // MARK: Button actions
  
  func kittiesTapped() {
    delegate?.toggleLeftPanel?()
  }
  
  func puppiesTapped() {
    delegate?.toggleRightPanel?()
  }
  
}
