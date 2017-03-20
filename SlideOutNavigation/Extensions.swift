//
//  Extensions.swift
//  SlideOutNavigation
//
//  Created by Nick Perkins on 3/19/17.
//  Copyright © 2017 James Frost. All rights reserved.
//

import UIKit
import QuartzCore

// MARK: CenterViewController delegate
extension ContainerViewController: CenterViewControllerDelegate {
    
    func toggleLeftPanel() {
        let notAlreadyExpanded = (currentState != .leftPanelExpanded)
        
        if notAlreadyExpanded {
            addLeftPanelViewController()
        }
        
        animateLeftPanel(shouldExpand: notAlreadyExpanded)
    }
    
    func toggleRightPanel() {
        let notAlreadyExpanded = (currentState != .rightPanelExpanded)
        
        if notAlreadyExpanded {
            addRightPanelViewController()
        }
        
        animateRightPanel(shouldExpand: notAlreadyExpanded)
        
        func collapseSidePanels() {
            switch (currentState) {
            case .rightPanelExpanded:
                toggleRightPanel()
            case .leftPanelExpanded:
                toggleLeftPanel()
            default:
                break
            }
        }
    }
    
    func addLeftPanelViewController() {
        if (leftViewController == nil) {
            leftViewController = SidePanelViewController()
            leftViewController?.animals = Animal.allCats()
            
            addChildSidePanelController(sidePanelController: leftViewController!)
        }
    }
    
    func addChildSidePanelController(sidePanelController: SidePanelViewController) {
        view.insertSubview(sidePanelController.view, at: 0)
        addChildViewController(sidePanelController)
        sidePanelController.didMove(toParentViewController: self)
    }
    
    func addRightPanelViewController() {
        if (rightViewController == nil) {
            rightViewController = SidePanelViewController()
            rightViewController?.animals = Animal.allDogs()
            
            addChildSidePanelController(sidePanelController: rightViewController!)
        }
    }
    
    func animateLeftPanel(shouldExpand: Bool) {
        if (shouldExpand) {
            currentState = .leftPanelExpanded
            
            animateCenterPanelXPosition(targetPosition: centerNavigationController.view.frame.width - centerPanelExpandedOffset)
        } else {
            animateCenterPanelXPosition(targetPosition: 0) { finished in
                self.currentState = .bothCollapsed
                
                self.leftViewController!.view.removeFromSuperview()
                self.leftViewController = nil
            }
        }
    }
    
    func animateCenterPanelXPosition(targetPosition: CGFloat, completion: ((Bool) -> Void)! = nil) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.centerNavigationController.view.frame.origin.x = targetPosition
        }, completion: completion)
    }
    
    func animateRightPanel(shouldExpand: Bool) {
        if (shouldExpand) {
            currentState = .rightPanelExpanded
            
            animateCenterPanelXPosition(targetPosition: -centerNavigationController.view.frame.width + centerPanelExpandedOffset)
        } else {
            animateCenterPanelXPosition(targetPosition: 0) { finished in
                self.currentState = .bothCollapsed
                
                self.rightViewController!.view.removeFromSuperview()
                self.rightViewController = nil
            }
        }
    }
    
}

extension CenterViewController {
    
    func setupNavigationBarItems() {
        setupNavigationBarStyle()
        setupLeftNavItem()
        setupRightNavItem()
    }
    
    private func setupNavigationBarStyle() {
        //Title style
        navigationItem.titleView?.tintColor = .black
        
        //Navigation Bar Style
        navigationController?.navigationBar.centerViewNavigationBarStyle()
        
        //Status bar status
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
    }
    
    private func setupLeftNavItem() {
        let kittiesButton = UIButton(type: .system)
        kittiesButton.setTitle("Kitties", for: .normal)
        kittiesButton.setTitleColor(.white, for: .normal)
        kittiesButton.addTarget(self, action: #selector(kittiesTapped), for: .touchUpInside)
        kittiesButton.frame = CGRect(x: 0, y: 0, width: 60, height: 24)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: kittiesButton)
    }
    
    private func setupRightNavItem() {
        let puppiesButton = UIButton(type: .system)
        puppiesButton.setTitle("Puppies", for: .normal)
        puppiesButton.setTitleColor(.white, for: .normal)
        puppiesButton.addTarget(self, action: #selector(puppiesTapped), for: .touchUpInside)
        puppiesButton.frame = CGRect(x: 0, y: 0, width: 60, height: 24)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: puppiesButton)
    }
}

extension UINavigationBar {
    
    func centerViewNavigationBarStyle() {
        self.barTintColor = UIColor(r: 89, g: 178, b: 103)
        self.tintColor = .lightGray
        self.isTranslucent = false
        self.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    }
}

extension CenterViewController: SidePanelViewControllerDelegate {
    func animalSelected(_ animal: Animal) {
        imageView.image = animal.image
        titleLabel.text = animal.title
        creatorLabel.text = animal.creator
        
        delegate?.collapseSidePanels?()
    }
}

