//
//  SecondViewController.swift
//  TabbingTest
//
//  Created by Taalib Minhas on 28/09/2017.
//  Copyright © 2017 Taalib Minhas. All rights reserved.
//

import UIKit
import UserNotifications
import FirebaseDatabase

var total = 0
let totalstring = "\(total)"
var timerStarted = true

// Firebase database reference
var ref:DatabaseReference?
var databaseHandle:DatabaseHandle?
var birdData = [String]()

//MARK: Circular animation based global variables and properties
let screenSize = UIScreen.main.bounds
var circleWidth = screenSize.width * 0.6
var circleHeight = circleWidth
let screenWidth = screenSize.width
let screenHeight = screenSize.height

class SecondViewController: UIViewController {
    
    //MARK: SETTING MY TIMER VARIABLES
    
    var timer = Timer()
    var seconds = 1500
    var dailyTotal = 0
    let userDefaults = UserDefaults.standard
    
    // Create a new CircleView
    let circleView = Circle(frame: CGRect(x: ((screenWidth/2) - (circleWidth/2)), y: ((screenHeight/2) - (circleHeight/2)), width: circleWidth, height: circleHeight))
    
    //MARK: Firebase variables
   
    var ref:DatabaseReference?
    var databaseHandle:DatabaseHandle?
//    var birdData = [String]()
    
    //MARK: TIMER OUTLETS
    
    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var startStop: UIButton!
    @IBOutlet var magpie2: UIImageView!
    @IBOutlet var magpie3: UIImageView!
    
    
    //MARK: FUNCTION TO DECREASE TIME
    
    @objc func decreaseTimer () {
        if seconds > 0 {
            seconds -= 1
            timerLabel.text = timeString(time: TimeInterval(seconds))
        } else {
            timer.invalidate()
        }
        if seconds == 1495 {
            
            // Fact modal
            
            performSegue(withIdentifier: "fact", sender: nil)
            
            // Firebase retrieval
            
            print ("retrieve")
            
            // Set the firebase reference
            ref = Database.database().reference()
            
            databaseHandle = ref?.child("birdFacts\(total)").observe(.value, with: { (snapshot) in
                
                let post = snapshot.value as? String
                
                if let actualPost = post {
                    
                      birdData.append(actualPost)
//                    self.myTableView.reloadData()
//                    self.currentFact.append(actualPost)
                    
                }
                
            })
            
            // Timer and total update
            total += 1
            dailyTotal += 1
            timer.invalidate()
            print ("timer reset")
            seconds = 1500
            timerLabel.text = timeString(time: TimeInterval(seconds))
            timerStarted = true
            startStop.setImage(#imageLiteral(resourceName: "Play"), for: .normal)
            
            if dailyTotal == 1 {
                magpie2.alpha = 1
            }
            
            if dailyTotal == 2 {
                magpie3.alpha = 1
            }
            
            UserDefaults.standard.set(total, forKey: "myTotal")
            
            UserDefaults.standard.set(dailyTotal, forKey: "dailyTotal")
            
        }
    }

    func timeout() {
        while timerStarted == true {
            print("Hi there")
            if seconds == 1495 {
                //timesup.alpha = 1
            }
        }
    }
    
    //MARK: CIRCLE VIEW FUNCTIONS
    func startAnimateCircle() {
        circleView.animateCircle(duration: 100.0)
    }
    
    func pauseAnimateCircle() -> Bool {
        if circleLayer.speed == 1.0 {
            let pausedTime = circleLayer.convertTime(CACurrentMediaTime(), from: nil)
            circleLayer.speed = 0.0
            circleLayer.timeOffset = pausedTime
            print (pausedTime)
            return true
        } else {
            return false
        }
    }
    
    func resume() {
        let pausedTime: CFTimeInterval = circleLayer.timeOffset
        circleLayer.speed = 1.0
        circleLayer.timeOffset = 0.0
        circleLayer.beginTime = 0.0
        let timeSincePause: CFTimeInterval = circleLayer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        circleLayer.beginTime = timeSincePause
        print (pausedTime)
    }
    
    func reset() {
        circleLayer.removeAllAnimations()
        circleLayer.transform = CATransform3DIdentity
        circleView.resetCircle(duration: 1.0)
    }
    
    //MARK: Bring in animal fact
    
    func animalFact() {
        
    }
    
    //MARK: TIMER ACTIONS
    
    @IBAction func Play(_ sender: Any) {
       
        if timerStarted == true {
            print (birdData)
            startAnimateCircle()
            print ("timer started")
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(SecondViewController.decreaseTimer), userInfo: nil, repeats: true)
            timerStarted = false
            startStop.setImage(#imageLiteral(resourceName: "Pause"), for: .normal)
            
            let notification = UNMutableNotificationContent()
            notification.title = "Magpie"
            notification.subtitle = "Times up!"
            notification.body = "Good job. say hi to your new Magpie"
            let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            let request = UNNotificationRequest(identifier: "notification1", content: notification, trigger: notificationTrigger)
            
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
            
        } else {
            pauseAnimateCircle()
            timer.invalidate()
            timerStarted = true
            startStop.setImage(#imageLiteral(resourceName: "Play"), for: .normal)
            
        }
    }
    
    
    @IBAction func Clear(_ sender: Any) {
        print("Shoo you magpies")
        dailyTotal = 0
        UserDefaults.standard.set(dailyTotal, forKey: "dailyTotal")
        UIView.animate(withDuration: 0.3, animations: {
            
            self.magpie3.transform = CGAffineTransform(translationX: 350, y: 500)
            
        })
    }
    
    @IBAction func restart(_ sender: Any) {
        
        reset()
        timer.invalidate()
        print ("timer reset")
        seconds = 1500
        timerLabel.text = timeString(time: TimeInterval(seconds))
        timerStarted = true
        startStop.setImage(#imageLiteral(resourceName: "Play"), for: .normal)
        
    }
    
    //MARK: TIME FORMAT SETTINGS

    func timeString (time:TimeInterval) -> String {
        
        //let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i", minutes, seconds)
        
    }
    
    //MARK: USERNOTIFICATIONS
    
    override func viewDidAppear(_ animated: Bool) {
        
        if let x = UserDefaults.standard.object(forKey: "myTotal") as? Int {
            total = x
        }
        
        if let y = UserDefaults.standard.object(forKey: "dailyTotal") as? Int {
            dailyTotal = y
        }
        
        if dailyTotal == 1 {
            magpie2.alpha = 1
        }
        
        if dailyTotal == 2 {
            magpie3.alpha = 1
            magpie2.alpha = 1
        }
        
        view.addSubview(circleView)
        
        circleView.loadCircle(duration: 1.0)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    //MARK: SET UP USER NOTIFICATIONS
    
    func initNotificationSetupCheck() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert])
        { (success, error) in
            if success {
                print("Permission Granted")
            } else {
                print("There was a problem!")
            }
        }
    }
    
    //MARK: NOTIFICATION MESSAGE
    
    func initnotification() {
        
        print ("I hear you")
        let notification = UNMutableNotificationContent()
        notification.title = "Magpie"
        notification.subtitle = "Times up"
        notification.body = "Good job! Say hi to your new Magpie"
        
        let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: "notification1", content: notification, trigger: notificationTrigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        timeout()
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.view.backgroundColor = UIColor.init(red:0.20, green:0.83, blue:0.63, alpha:1.0)
        // INITIATE NOTIFICATION SETUP FUNC
        initNotificationSetupCheck()
    }
}
