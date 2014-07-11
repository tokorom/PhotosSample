//
//  BaseViewController.swift
//
//  Created by ToKoRo on 2014-07-11.
//

import UIKit

class BaseViewController: UIViewController {

    @lazy var KVOController: FBKVOController = FBKVOController(observer: self)

    func observe(subject: AnyObject, keyPath: String, block: () -> ()) {
        let options: NSKeyValueObservingOptions = .Initial | .New
        self.KVOController.observe(subject, keyPath: keyPath, options: options) {
            observer, subject, change in

            block()
        }
    }
    
}
