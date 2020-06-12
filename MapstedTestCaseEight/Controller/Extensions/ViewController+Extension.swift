//
//  ViewController+Extension.swift
//  MapstedTestCaseEight
//
//  Created by Rafael Cunha de Oliveira on 2020-06-12.
//  Copyright © 2020 Rafael Cunha de Oliveira. All rights reserved.
//

import UIKit

extension UIViewController {
    func showLoading() { // loading for the whole app, in case it gets bigger
        let transparentView = UIView(frame: self.view.frame)
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        transparentView.tag = 500
        let loadingView = UIView(frame: CGRect(x: self.view.frame.maxX / 4,
                                               y: self.view.frame.maxY / 4,
                                               width: self.view.frame.height / 6,
                                               height: self.view.frame.height / 6))
        loadingView.center = self.view.center
        loadingView.layer.cornerRadius = 10
        loadingView.backgroundColor = .white
        loadingView.tag = 501
        let loading = UIActivityIndicatorView(frame: CGRect(x: self.view.frame.maxX / 4,
                                                            y: self.view.frame.maxY / 4,
                                                            width: self.view.frame.height / 6,
                                                            height: self.view.frame.height / 6))
        loading.style = .large
        loading.tag = 502
        loading.center = self.view.center
        view.addSubview(transparentView)
        view.addSubview(loadingView)
        view.addSubview(loading)
        loading.startAnimating()
    }

    func hideLoading() {
        self.view.viewWithTag(500)?.removeFromSuperview()
        self.view.viewWithTag(501)?.removeFromSuperview()
        self.view.viewWithTag(502)?.removeFromSuperview()
    }

    func showError(_ msg: String) { // generic error message for the whole app
        let alert = UIAlertController(title: "Ops", message: msg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}
