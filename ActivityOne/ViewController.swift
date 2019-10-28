//
//  ViewController.swift
//  ActivityOne
//
//  Created by Sruthi on 2019-10-28.
//  Copyright © 2019 Ankita. All rights reserved.
//

import UIKit

import WatchConnectivity
class ViewController: UIViewController,WCSessionDelegate{
    
    var phoneCounter:Int = 0
    var messageCounter:Int = 0
    // Built-in methods for dealing with communication between Watch <> Phone
    // ------------------------------------------------
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    
    @IBOutlet weak var labelAge: UILabel!
    @IBOutlet weak var labelName: UILabel!
    
    @IBOutlet weak var label: UILabel!
    
    @IBAction func btnSend(_ sender: Any) {        
        
        print("Sending message to watch")
               // ------ SEND MESSAGE TO WATCH CODE GOES HERE
               if (WCSession.default.isReachable == true) {
                   // Here is the message you want to send to the watch
                   // All messages get sent as dictionaries
                   let message = ["name":"Banana",
                                  "color":"yellow"] as [String : Any]
                   
                   // Send the message
                   WCSession.default.sendMessage(message, replyHandler:nil)
                   messageCounter = messageCounter + 1
                   //labelname.text = "Message Sent \(messageCounter)"
               }
               else {
                   messageCounter = messageCounter + 1
                   //labelname.text = "Cannot reach watch! \(messageCounter)"
               }
    }
        func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
           // Output message to terminal
           print("WATCH: I received a message: \(message)")
           
           // Get the "name" key out of the dictionary
           // and show it in the label
           let name = message["name"] as! String
           let age = message["age"] as! String
         
         labelName.text = name
         labelName.text = age
               
               
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if (WCSession.isSupported() == true) {
                   label.text = "WC is supported!"
                   
                   // create a communication session with the watch
                   let session = WCSession.default
                   session.delegate = self
                   session.activate()
               }
               else {
                   label.text = "WC NOT supported!"
               }
    }

   
        
}


