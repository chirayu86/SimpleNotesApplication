//
//  CustomNotesPresentationController.swift
//  SimpleNotesApplication
//
//  Created by chirayu-pt6280 on 02/01/23.
//

import UIKit

//class ScaleAnimator: NSObject,UIViewControllerAnimatedTransitioning {
//    
//    let duration = 0.8
//    
//    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
//      
//        return duration
//    }
//    
//    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
//        
//        let toView = transitionContext.view(forKey: .to)!
//        
//        transitionContext.containerView.addSubview(toView)
//        
//        toView.transform = CGAffineTransform(scaleX: 10.0, y: 10.0)
//        toView.transform = toView.transform.rotated(by: 180)
//        UIView.animate(
//          withDuration: duration ,
//          animations: {
//              toView.transform = CGAffineTransform(scaleX: 1, y: 1)
//          },
//          completion: { _ in
//            transitionContext.completeTransition(true)
//          }
//        )
//    }
//    
//    
//}
//
//
//
//class CustomNotesPresentationController: UIPresentationController {
//    
//    
//    
//    lazy var dismissButton = {
//        
//        let button = UIButton()
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.setImage(UIImage(systemName: "square.and.arrow.up.fill"), for: .normal)
//        button.contentMode = .center
//        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
//        button.widthAnchor.constraint(equalToConstant: 40).isActive = true
//        return button
//        
//    }()
//    
//
//    
//    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
//       
//        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
//    
//        self.presentedViewController.view.addSubview(dismissButton)
//        dismissButton.addTarget(self, action: #selector(dismissal), for: .touchUpInside)
//        
//        presentedViewController.view.layer.borderWidth = 2
//        presentedViewController.view.layer.borderColor = UIColor.black.cgColor
//        
//       
//        presentedViewController.view.bringSubviewToFront(dismissButton)
// 
//      
//    }
//    
//    
//
//    override func containerViewWillLayoutSubviews() {
//         presentedView?.frame = frameOfPresentedViewInContainerView
//    }
//    
//    
//    override var frameOfPresentedViewInContainerView: CGRect {
//        
//        return CGRect(x: UIScreen.main.bounds.midX - 150 , y:UIScreen.main.bounds.midY - 300 , width: 300, height: 600)
//         
//    }
//    
//    
//    
//    @objc func dismissal() {
//        print(#function)
//        self.presentedViewController.dismiss(animated: true)
//    }
//}
