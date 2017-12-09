//
//  chatViewController.swift
//  Chatter
//
//  Created by Chavane Minto on 12/8/17.
//  Copyright © 2017 Chavane Minto. All rights reserved.
//

import UIKit
import Parse

class chatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var chatField: UITextField!
    
    @IBOutlet weak var sendButton: UIButton!
    
    @IBOutlet weak var chatTableView: UITableView!
    
    var Messages: [PFObject]!
    
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
        
        chatTableView.delegate = self;
        chatTableView.dataSource = self;
        
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.refresh), userInfo: nil, repeats: true)

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Messages?.count ?? 0;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = chatTableView.dequeueReusableCell(withIdentifier: "chatCell", for: indexPath) as! chatCell
        
        let Message = Messages[indexPath.row];
        
        if let text = Message["text"] as? String {
            cell.messageLabel.text = text
        } else {
            cell.messageLabel.text = "N/A";
        }
        
        return cell;
    }
    
    @IBAction func onSend(_ sender: Any) {
        if chatField.text != "" {
            let chatMessage = PFObject(className: "Message");
            chatMessage["text"] = chatField.text
            
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
    
    @objc func refresh() {
        let query = PFQuery(className: "Message");
        query.order(byAscending: "createdAt");
        query.findObjectsInBackground { (Messages: [PFObject]?, error: Error?) in
            if let Messages = Messages {
                self.Messages = Messages;
                self.chatTableView.reloadData();
            } else {
                print(error?.localizedDescription ?? "OOPS")
            }
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
