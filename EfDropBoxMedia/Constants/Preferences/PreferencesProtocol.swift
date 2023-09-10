//
//  PreferencesProtocol.swift
//  EfDropBoxMedia
//
//  Created by user on 05.09.2023.
//

import Foundation

protocol PreferencesProtocol {
    func clear()
    func saveAccessToken(_ accessToken: String)
    func getAccessToken() -> String?
    func saveRefreshToken(_ refreshToken: String)
    func getRefreshToken() -> String?
}
