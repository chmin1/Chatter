//
//  chatViewController.swift
//  Chatter
//
//  Created by Chavane Minto on 12/8/17.
//  Copyright © 2017 Chavane Minto. All rights reserved.
//

import UIKit
import Parse

class chatViewController: UIViewController {
    
    @IBOutlet weak var chatField: UITextField!
    
    @IBOutlet weak var sendButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        chatField.attributedPlaceholder = NSAttributedString(string: "Compose A Message...", attributes: [NSAttributedStringKey.foregroundColor : UIColor.white]);
        
        chatField.layer.cornerRadius = 15;
        sendButton.layer.cornerRadius = 15;
        
        chatField.layer.masksToBounds = true;
        sendButton.layer.masksToBounds = true;
        
        chatField.layer.borderColor = UIColor.white.cgColor;
        sendButton.layer.borderColor = UIColor.white.cgColor;
        
        chatField.layer.borderWidth = 3.0;
        sendButton.layer.borderWidth = 3.0;
        
    }
    
    @IBAction func onSend(_ sender: Any) {
        if chatField.text != "" {
            let chatMessage = PFObject(className: "Message");
            chatMessage["Text"] = chatField.text
            
            chatMessage.saveInBackground(block: { (success, error) in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    print("The message was saved!");
                    self.chatField.text = "";
                }
            })
        }
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
