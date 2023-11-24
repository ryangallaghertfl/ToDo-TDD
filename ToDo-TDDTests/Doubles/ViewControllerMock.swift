//
//  ViewControllerMock.swift
//  ToDo-TDDTests
//
//  Created by Ryan Gallagher on 24/11/2023.
//

import UIKit

class ViewControllerMock: UIViewController {
    var lastPresented: UIViewController?
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        lastPresented = viewControllerToPresent
        super.present(viewControllerToPresent, animated: flag, completion: completion)
    }
}
