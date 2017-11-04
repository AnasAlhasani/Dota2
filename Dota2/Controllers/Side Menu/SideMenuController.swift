//
//  SideMenuController.swift
//  Dota2
//
//  Created by Anas Alhasani on 11/4/17.
//  Copyright © 2017 Anas Alhasani. All rights reserved.
//

import UIKit

class SideMenuController: UIViewController, UIGestureRecognizerDelegate{
    
    //MARK: Properites
    private var sideViewController: UIViewController!
    private var centerViewController: UIViewController!
    private var sidePanelView: UIView!
    private var statusBarUnderlay: UIView!
    private var centerPanelView: UIView!
    private var isSidePanelViewVisible = false
    private var centerPanelSnasphotView: UIView?
    
    // MARK: View lifeCycle
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpViewHierarchy()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setUpViewHierarchy()
    }
    
    func setUpViewHierarchy() {
        view = UIView(frame: UIScreen.main.bounds)
        configureViews()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isSidePanelViewVisible {
            toggle()
        }
    }
    
    //MARK: Public Methods
    @objc public func toggle() {
        if !isSidePanelViewVisible {
            self.centerViewController.view.endEditing(true)
            prepare(sidePanelViewForDisplay: true)
        }
        animate(toReveal: !isSidePanelViewVisible)
    }
    
    func embed(sideViewController controller: UIViewController) {
        if sideViewController == nil {
            
            sideViewController = controller
            sideViewController.view.frame = sidePanelView.bounds
            
            sidePanelView.addSubview(sideViewController.view)
            
            addChildViewController(sideViewController)
            sideViewController.didMove(toParentViewController: self)
            
            sidePanelView.isHidden = true
        }
    }
    
    func embed(centerViewController controller: UIViewController) {
        
        guard controller !== centerViewController else {
            if isSidePanelViewVisible {
                animate(toReveal: false)
            }
            
            return
        }
        
        addChildViewController(controller)
        if let controller = controller as? UINavigationController {
            prepare(centerControllerForContainment: controller)
        }
        centerPanelView.addSubview(controller.view)
        
        if centerViewController == nil {
            centerViewController = controller
            centerViewController.didMove(toParentViewController: self)
        } else {
            centerViewController.willMove(toParentViewController: nil)
            
            let completion: () -> () = {
                self.centerViewController.view.removeFromSuperview()
                self.centerViewController.removeFromParentViewController()
                controller.didMove(toParentViewController: self)
                self.centerViewController = controller
            }
            
            performTransition(forView: controller.view, completion: completion)
            
            if isSidePanelViewVisible {
                animate(toReveal: false)
            }
        }
    }
    
}

//MARK: - Configurations
private extension SideMenuController {
    
    func configureViews() {
        centerPanelView = UIView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height))
        view.addSubview(centerPanelView)
        
        statusBarUnderlay = UIView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 20))
        view.addSubview(statusBarUnderlay)
        statusBarUnderlay.alpha = 0
        
        sidePanelView = UIView(frame: sidePanelViewFrame)
        view.addSubview(sidePanelView)
        sidePanelView.clipsToBounds = true
        view.sendSubview(toBack: sidePanelView)
        
        configureGestureRecognizers()
        view.bringSubview(toFront: statusBarUnderlay)
    }
    
    func configureGestureRecognizers() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tapRecognizer.delegate = self
        centerPanelView.addGestureRecognizer(tapRecognizer)
    }
    
    func set(statusBarHidden hidden: Bool) {
        
        statusBarWindow?.alpha = hidden ? 0 : 1
        
        if !hidden {
            centerPanelSnasphotView?.removeFromSuperview()
            centerPanelSnasphotView = nil
        } else if centerPanelSnasphotView == nil {
            centerPanelSnasphotView = UIScreen.main.snapshotView(afterScreenUpdates: false)
            centerPanelView.addSubview(centerPanelSnasphotView!)
        }
    }
    
    func setSideShadow(hidden: Bool) {
        centerPanelView.layer.shadowOpacity = hidden ? 0.0: 0.8
    }
}

// MARK:- Containment
private extension SideMenuController {
    func prepare(centerControllerForContainment controller: UINavigationController) {
        controller.addSideMenuButton()
        controller.view.frame = centerPanelView.bounds
    }
    
    func prepare(sidePanelViewForDisplay display: Bool) {
        sidePanelView.isHidden = !display
        setSideShadow(hidden: !display)
    }
}


// MARK: - Interaction
private extension SideMenuController {
    
    @objc func handleTap() {
        animate(toReveal: false)
    }
    
    func animate(toReveal reveal: Bool){
        
        isSidePanelViewVisible = reveal
        
        if reveal {
            set(statusBarHidden: reveal)
        }
        setUndersidePanelView(hidden: !reveal) { updated in
            
            if !reveal {
                self.prepare(sidePanelViewForDisplay: false)
                self.set(statusBarHidden: reveal)
            }
            
            self.centerViewController.view.isUserInteractionEnabled = !reveal
        }
    }
    
    func setUndersidePanelView(hidden: Bool, completion: ((Bool) -> ())? = nil) {
        
        var centerPanelViewFrame = centerPanelView.frame
        
        if !hidden {
            centerPanelViewFrame.origin.x = sidePanelView.frame.maxX
        } else {
            centerPanelViewFrame.origin = CGPoint.zero
        }
        
        let duration = hidden ? Constant.hideDuration : Constant.reavealDuration
        
        let updated = centerPanelView.frame != centerPanelViewFrame
        
        UIView.panelAnimation( duration, animations: {
            self.centerPanelView.frame = centerPanelViewFrame
        }) {
            if hidden {
                self.setSideShadow(hidden: hidden)
            }
            completion?(updated)
        }
    }
    
}

//MARK: - Transition Animation
private extension SideMenuController {
    func performTransition(forView view: UIView, completion: @escaping () -> Void) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        let fadeAnimation = CABasicAnimation(keyPath: "opacity")
        fadeAnimation.duration = 0.35
        fadeAnimation.fromValue = 0
        fadeAnimation.toValue = 1
        fadeAnimation.fillMode = kCAFillModeForwards
        fadeAnimation.isRemovedOnCompletion = true
        view.layer.add(fadeAnimation, forKey: "fade")
        CATransaction.commit()
    }
}

// MARK: - Computed variables
private extension SideMenuController {
    
    var screenSize: CGSize {
        return view.frame.size
    }
    
    var sidePanelViewFrame: CGRect {
        let panelWidth: CGFloat = view.frame.width / 1.35
        return CGRect(x: 0, y: 0, width: panelWidth, height: screenSize.height)
    }
    
    var statusBarWindow: UIWindow? {
        return UIApplication.shared.value(forKey: "statusBarWindow") as? UIWindow
    }
}

//MARK: - Constants
private extension SideMenuController {
    
    struct Constant {
        static let reavealDuration = 0.3
        static let hideDuration = 0.2
    }
}

