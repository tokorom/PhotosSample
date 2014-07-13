//
//  Array+Safe.swift
//
//  Created by ToKoRo on 2014-07-13.
//

extension Array {

    func optionalValueAtIndex(index: Int) -> Any! {
        return index < self.count ? self[index] : nil
    }

}
