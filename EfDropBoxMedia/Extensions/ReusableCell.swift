//
//  ReusableCell.swift
//  EfDropBoxMedia
//
//  Created by user on 04.09.2023.
//

import UIKit

protocol ReusableCell {
    static var nib: UINib { get }
}

extension ReusableCell {
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
}

