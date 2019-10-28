//
//  InterfaceController.swift
//  ActivityOne WatchKit Extension
//
//  Created by Sruthi on 2019-10-28.
//  Copyright © 2019 Ankita. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

  var phoneCounter:Int = 0
   var messageCounter:Int = 0



  class InterfaceController: WKInterfaceController,WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
        
    
    // Built-in methods for dealing with communication between Watch <> Phone
     // ------------------------------------------------
     func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
         
     }
     
     func sessionDidBecomeInactive(_ session: WCSession) {
         
     }
     
     func sessionDidDeactivate(_ session: WCSession) {
         
        }
        
    }
    
    @IBOutlet weak var nameLabel: WKInterfaceLabel!
    @IBOutlet weak var colorLabel: WKInterfaceLabel!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
          // Output message to terminal
          print("WATCH: I received a message: \(message)")
          
          // Get the "name" key out of the dictionary
          // and show it in the label
          let name = message["name"] as! String
          let color = message["color"] as! String
        
        nameLabel.setText(name)
        colorLabel.setText(color)
        
    }
    

    // connection check 
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        print("---WATCH APP LOADED")
        
        if (WCSession.isSupported() == true) {
           nameLabel.setText("WC is supported!")
            
            // create a communication session with the phone
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
        else {
            nameLabel.setText("WC NOT supported!")
        }
        
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
 
 

    @IBAction func SendToPhone() {
    
        print("Sending message to phone")
               // ------ SEND MESSAGE TO PHONE CODE GOES HERE
               if (WCSession.default.isReachable == true) {
                   // Here is the message you want to send to the watch
                   // All messages get sent as dictionaries
                   let message = ["name":"pritish",
                                  "age":"35"] as [String : Any]
                   
                   // Send the message
                   WCSession.default.sendMessage(message, replyHandler:nil)
                   messageCounter = messageCounter + 1
                   //labelname.text = "Message Sent \(messageCounter)"
               }
               else {
                   messageCounter = messageCounter + 1
                  // labelname.text = "Cannot reach watch! \(messageCounter)"
               }
               
    }
    
    

}
