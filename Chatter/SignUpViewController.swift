//
//  SignUpViewController.swift
//  Chatter
//
//  Created by Chavane Minto on 12/8/17.
//  Copyright © 2017 Chavane Minto. All rights reserved.
//

import UIKit
import Parse

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var confirmPasswordField: UITextField!
    
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var createButton: UIButton!
    
    var alertController: UIAlertController!
    var alertError: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameField.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSAttributedStringKey.foregroundColor : UIColor.white]);
        emailField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedStringKey.foregroundColor : UIColor.white]);
        passwordField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedStringKey.foregroundColor : UIColor.white]);
        confirmPasswordField.attributedPlaceholder = NSAttributedString(string: "Confirm Password", attributes: [NSAttributedStringKey.foregroundColor : UIColor.white]);
        
        cancelButton.layer.cornerRadius = 15;
        createButton.layer.cornerRadius = 15;
        usernameField.layer.cornerRadius = 15;
        emailField.layer.cornerRadius = 15;
        passwordField.layer.cornerRadius = 15;
        confirmPasswordField.layer.cornerRadius = 15;
        
        usernameField.layer.masksToBounds = true;
        emailField.layer.masksToBounds = true;
        passwordField.layer.masksToBounds = true;
        confirmPasswordField.layer.masksToBounds = true;
        cancelButton.layer.masksToBounds = true;
        createButton.layer.masksToBounds = true;
        
        
        usernameField.layer.borderColor = UIColor.white.cgColor;
        emailField.layer.borderColor = UIColor.white.cgColor;
        passwordField.layer.borderColor = UIColor.white.cgColor;
        confirmPasswordField.layer.borderColor = UIColor.white.cgColor;
        cancelButton.layer.borderColor = UIColor.white.cgColor;
        createButton.layer.borderColor = UIColor.white.cgColor;
        
        usernameField.layer.borderWidth = 3.0;
        emailField.layer.borderWidth = 3.0;
        passwordField.layer.borderWidth = 3.0;
        confirmPasswordField.layer.borderWidth = 3.0;
        cancelButton.layer.borderWidth = 3.0;
        createButton.layer.borderWidth = 3.0;
        
    }
    
    @IBAction func onScreenTap(_ sender: Any) {
        view.endEditing(true);
    }
    
    @IBAction func onCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onCreateUser(_ sender: Any) {
        if passwordField.text == confirmPasswordField.text {
            let newUser = PFUser()
            
            newUser.username = usernameField.text
            newUser.email = emailField.text
            newUser.password = passwordField.text
            
            newUser.signUpInBackground { (success: Bool, error: Error?) in
                if let error = error{
                    print("User log in failed: \(error.localizedDescription)")
                    self.alertError = error.localizedDescription
                    self.isSignedUp()
                } else {
                    print("User logged in successfully")
                    self.dismiss(animated: true, completion: nil)
                }
            }
        } else {
            self.alertController = UIAlertController(title: "Sign Up Error", message: "Passwords Don't Match", preferredStyle: .alert)
            
            let tryAgain = UIAlertAction(title: "Try Again", style: .cancel) { (action) in
                self.usernameField.text = ""
                self.passwordField.text = ""
                self.emailField.text = ""
            }
            alertController.addAction(tryAgain)
            present(alertController, animated: true, completion: nil)
        }
    }
    
    func isSignedUp() {
        self.alertController = UIAlertController(title: "Sign Up Error", message: alertError, preferredStyle: .alert)
        
        //try to connect again
        let tryAgain = UIAlertAction(title: "Try Again", style: .cancel) { (action) in
            self.usernameField.text = ""
            self.passwordField.text = ""
            self.emailField.text = ""
        }
        
        // add action to alertController
        alertController.addAction(tryAgain)
        present(alertController, animated: true, completion: nil)
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
