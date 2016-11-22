//
//  ViewController.swift
//  demo
//
//  Created by Robert-Hein Hooijmans on 06/11/16.
//  Copyright © 2016 Robert-Hein Hooijmans. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var customView: View? { return view as? View }
    var viewModel: ViewModel!
    
    convenience init(with viewModel: ViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    override public func loadView() {
        view = View(elements: viewModel.elements)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
}
