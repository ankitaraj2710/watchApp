//
//  ViewController.swift
//  ActivityOne
//
//  Created by Sruthi on 2019-10-28.
//  Copyright © 2019 Ankita. All rights reserved.
//

import UIKit

import WatchConnectivity
import Foundation
class ViewController: UIViewController {
    
    var session: WCSession?

    override func viewDidLoad() {
           super.viewDidLoad()
        self.configureWatchkitSession()
       }
    
    func configureWatchkitSession(){
        if (WCSession.isSupported()) {
            session = WCSession.default
            session?.delegate = self as! WCSessionDelegate
            session?.activate()
                        }
    }
    

    
    var watchName: String = ""
    
    var phoneCounter:Int = 0
    var messageCounter:Int = 0
    // Built-in methods for dealing with communication between Watch <> Phone
    // ------------------------------------------------
  
//    func session(_ session: WCSession, didReceiveMessage watchMessage: [String : Any]) {
////                  print("Phone: I received a message from watch: \(watchMessage)")
//
//        self.watchName = watchMessage["name"] as! String
////                print(watchName)
////                  let age = watchMessage["age"] as! String
////                  self.labelAge.text = "\(name)"
//    //              labelName.text = "\(age)"
//
//
//        }
    
    
    
    @IBOutlet weak var label: UILabel!
    
  
    
    //msg from phone to watch
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
    
    @IBOutlet weak var labelName: UILabel!
    
    @IBOutlet weak var labelAge: UILabel!
    //code for receive msg from watch
        
    
    
        
}
extension ViewController: WCSessionDelegate{



func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    if (WCSession.isSupported() == true) {
        let session = WCSession.default
        session.delegate = self as WCSessionDelegate
        session.activate()
    }
}

func sessionDidBecomeInactive(_ session: WCSession) {

}

func sessionDidDeactivate(_ session: WCSession) {

}
    
}


