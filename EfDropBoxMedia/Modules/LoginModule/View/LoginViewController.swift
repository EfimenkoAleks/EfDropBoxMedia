//
//  LoginViewController.swift
//  EfDropBoxMedia
//
//  Created by user on 05.09.2023.
//

import UIKit
import SwiftyDropbox

class LoginViewController: UIViewController {
    
    // MARK: — properties
 
    @IBOutlet private weak var logiButton: UIButton!
    
    // MARK: — lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        logiButton.layer.cornerRadius = 5
        logiButton.layer.masksToBounds = true
    }
    
    @IBAction private func didTapLoginButton(_ sender: UIButton) {
        myButtonInControllerPressed()
    }

    private func myButtonInControllerPressed() {
       
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
