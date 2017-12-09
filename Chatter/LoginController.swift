//
//  LoginController.swift
//  Chatter
//
//  Created by Chavane Minto on 12/8/17.
//  Copyright © 2017 Chavane Minto. All rights reserved.
//

import UIKit
import Parse

class LoginController: UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    var alertController: UIAlertController!
    var alertError: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameField.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSAttributedStringKey.foregroundColor : UIColor.white])
        passwordField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedStringKey.foregroundColor : UIColor.white])

        loginButton.layer.cornerRadius = 15;
        signUpButton.layer.cornerRadius = 15;
        usernameField.layer.cornerRadius = 15;
        passwordField.layer.cornerRadius = 15;
        
        usernameField.layer.masksToBounds = true;
        passwordField.layer.masksToBounds = true;
        loginButton.layer.masksToBounds = true;
        signUpButton.layer.masksToBounds = true;
        
        usernameField.layer.borderColor = UIColor.white.cgColor;
        passwordField.layer.borderColor = UIColor.white.cgColor;
        loginButton.layer.borderColor = UIColor.white.cgColor;
        signUpButton.layer.borderColor = UIColor.white.cgColor;
        
        usernameField.layer.borderWidth = 3.0;
        passwordField.layer.borderWidth = 3.0;
        loginButton.layer.borderWidth = 3.0;
        signUpButton.layer.borderWidth = 3.0;
        
    }
    
    @IBAction func onLogin(_ sender: Any) {
        let username = usernameField.text ?? ""
        let password = passwordField.text ?? ""
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
            if let error = error {
                print("User log in failed: \(error.localizedDescription)")
                self.alertError = error.localizedDescription
                self.isLoggedIn()
            } else {
                print("User logged in successfully")
                let vc = chatViewController();
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
    }
    
    func isLoggedIn() {
        self.alertController = UIAlertController(title: "Login Error", message: alertError, preferredStyle: .alert)
        
        //try to connect again
        let tryAgain = UIAlertAction(title: "Try Again", style: .cancel) { (action) in
            self.usernameField.text = ""
            self.passwordField.text = ""
        }
        
        // add action to alertController
        alertController.addAction(tryAgain)
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func onScreenTap(_ sender: Any) {
        view.endEditing(true);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
