//
//  UIViewControllerExtension.swift
//  TAYSEER
//
//  Created by HTS Macbook Air on 07/04/23.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlert(title: String = "", message: String = "") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let errorAction = UIAlertAction(title: "OK", style: .default) { OK in
            alert.dismiss(animated: true)
        }
        alert.addAction(errorAction)
        self.present(alert, animated: true)
    }
}

extension UITextField {
    func addDoneCancelToolbar(onDone: (target: Any, action: Selector)? = nil, onCancel: (target: Any, action: Selector)? = nil) {
        let onCancel = onCancel ?? (target: self, action: #selector(cancelButtonTapped))
        let onDone = onDone ?? (target: self, action: #selector(doneButtonTapped))

        let toolbar: UIToolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.items = [
            UIBarButtonItem(title: "Cancel", style: .plain, target: onCancel.target, action: onCancel.action),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Done", style: .done, target: onDone.target, action: onDone.action)
        ]
        toolbar.sizeToFit()

        self.inputAccessoryView = toolbar
    }

    // Default actions:
    @objc func doneButtonTapped() { self.resignFirstResponder() }
    @objc func cancelButtonTapped() { self.resignFirstResponder() }
}

class ActivityIndicatorView
{
    var view: UIView!

var activityIndicator: UIActivityIndicatorView!

var title: String!

init(title: String, center: CGPoint, width: CGFloat = 200.0, height: CGFloat = 50.0)
{
    self.title = title

    let x = center.x - width/2.0
    let y = center.y - height/2.0

    self.view = UIView(frame: CGRect(x: x, y: y, width: width, height: height))
    self.view.backgroundColor = UIColor(red: 255.0/255.0, green: 204.0/255.0, blue: 51.0/255.0, alpha: 0.5)
    self.view.layer.cornerRadius = 10

    self.activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    self.activityIndicator.color = UIColor.black
    self.activityIndicator.hidesWhenStopped = false

    let titleLabel = UILabel(frame: CGRect(x: 60, y: 0, width: 200, height: 50))
    titleLabel.text = title
    titleLabel.textColor = UIColor.black

    self.view.addSubview(self.activityIndicator)
    self.view.addSubview(titleLabel)
}

func getViewActivityIndicator() -> UIView
{
    return self.view
}

func startAnimating()
{
    self.activityIndicator.startAnimating()
    UIApplication.shared.beginIgnoringInteractionEvents()
}

func stopAnimating()
{
    self.activityIndicator.stopAnimating()
    UIApplication.shared.endIgnoringInteractionEvents()

    self.view.removeFromSuperview()
}
//end
}
