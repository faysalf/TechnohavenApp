//
//  Ext+UIViewController.swift
//  TechnohavenApp
//
//  Created by Faysal Ahmed on 11/2/26.
//

import UIKit

private var tapGestureReco: UITapGestureRecognizer?

// MARK: - Keyboard dismiss setup
extension UIViewController {
    
    func setupKeyboardDismissal() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc private func keyboardWillShow() {
        setupTapGesture()
    }
    
    func setupTapGesture() {
        tapGestureReco = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGestureReco?.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGestureReco!)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
        if let tapGesture = tapGestureReco {
            view.removeGestureRecognizer(tapGesture)
        }
        tapGestureReco = nil
    }
}

// MARK: - Bottom pop-up
var lastLabelPopUpShown: UILabel?
extension UIViewController {
    func showBottomPopup(isError: Bool = true, withMessage message: String) {
        let label = UILabel()
        lastLabelPopUpShown?.removeFromSuperview()
        lastLabelPopUpShown = label
        label.textColor = UIColor.textPrimary
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.backgroundColor = isError ? UIColor.appError : UIColor.appSuccess
        
        label.text = message
        label.sizeToFit()
        label.alpha = 0
        
        let w = min(view.bounds.width-60, label.bounds.width + 40)
        label.frame = CGRect(
            x: (view.bounds.width-w)/2,
            y: view.bounds.height-150,
            width: w,
            height: label.bounds.height + 20)
        
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        self.view.addSubview(label)
        
        UIView.animate(withDuration: 0.3) {
            label.alpha = 1.0
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now()+4.0) {
            UIView.animate(withDuration: 0.3) {
                label.alpha = 0
            }
            label.removeFromSuperview()
        }
        
    }
    
}
