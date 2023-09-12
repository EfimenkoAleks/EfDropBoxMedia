//
//  Preferences.swift
//  EfDropBoxMedia
//
//  Created by user on 05.09.2023.
//

import Foundation

class Preferences: PreferencesProtocol {
    func clear() {
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
    }
    
    func saveAccessToken(_ accessToken: String) {
        UserDefaults.standard.set(accessToken, forKey: ConstantUserDefaultsKeys.accessToken)
    }
    
    func getAccessToken() -> String? {
        UserDefaults.standard.string(forKey: ConstantUserDefaultsKeys.accessToken)
    }
    
    func saveRefreshToken(_ refreshToken: String) {
        UserDefaults.standard.set(refreshToken, forKey: ConstantUserDefaultsKeys.refreshToken)
    }
    
    func getRefreshToken() -> String? {
        UserDefaults.standard.string(forKey: ConstantUserDefaultsKeys.refreshToken)
    }
    
    func savePhotoModel(_ dict: [[String: Any]]) {
        UserDefaults.standard.set(dict, forKey: ConstantUserDefaultsKeys.dict)
    }
    
    func getPhotoModel() -> [[String: Any]]? {
        UserDefaults.standard.value(forKey: ConstantUserDefaultsKeys.dict) as? [[String : Any]]
    }
}
