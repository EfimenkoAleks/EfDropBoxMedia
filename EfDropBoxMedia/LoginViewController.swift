//
//  LoginViewController.swift
//  EfDropBoxMedia
//
//  Created by user on 05.09.2023.
//

import UIKit
import SwiftyDropbox

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    @IBAction func didTapLoginButton(_ sender: UIButton) {
        myButtonInControllerPressed()
    }

    func myButtonInControllerPressed() {
        // OAuth 2 code flow with PKCE that grants a short-lived token with scopes, and performs refreshes of the token automatically.
        let scopeRequest = ScopeRequest(scopeType: .user, scopes: ["account_info.read", "file_requests.read", "files.metadata.read", "files.content.read"], includeGrantedScopes: false)
        DropboxClientsManager.authorizeFromControllerV2(
            UIApplication.shared,
            controller: self,
            loadingStatusDelegate: nil,
            openURL: { (url: URL) -> Void in UIApplication.shared.open(url, options: [:], completionHandler: nil) },
            scopeRequest: scopeRequest
        )
    }
}
