//
//  NSObject+SafeSubscripts.swift
//
//  Created by ToKoRo on 2014-07-13.
//

import Photos

// TODO: NSObject
extension PHFetchResult {

    func optionalValueAtIndex(index: Int) -> AnyObject! {
        return index < self.count ? self.objectAtIndexedSubscript(index) : nil
    }

}
