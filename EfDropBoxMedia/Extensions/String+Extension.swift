//
//  String+Extension.swift
//  EfDropBoxMedia
//
//  Created by user on 05.09.2023.
//

import Foundation

extension String {
    func appendURLParams(_ params: [String: String]) -> String {
        guard !params.isEmpty else { return self }
        return URL(string: self)?.append(params: params) ?? ""
    }
}
