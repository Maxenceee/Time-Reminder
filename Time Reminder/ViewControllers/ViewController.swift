//
//  ViewController.swift
//  Time ReminderV2
//
//  Created by Maxence Gama on 30/01/2021.
//

import UIKit
import Lottie
import Foundation

class ViewController: UIViewController {

    var timeDiff = 0
    private var animationView1: AnimationView?
    private var animationView2: AnimationView?
    private var animationView3: AnimationView?
    private var animationView4: AnimationView?
    
    var notifications = [Notification]()
    
    var viewIsVisible = false
    
    var lanceur: Lanceur!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lanceur = Lanceur(layer: self)
        lanceur.setup(frame: view.frame)
        view.layer.addSublayer(lanceur)
        
        view.addSubview(mainText)
        view.addSubview(button)
        
        animationView1 = .init(name: "9825-loading-screen-loader-spinning-circle")
        animationView1!.translatesAutoresizingMaskIntoConstraints = false
        animationView1!.contentMode = .scaleAspectFit
        animationView1!.loopMode = .loop
        animationView1!.animationSpeed = 1
        animationView1!.backgroundBehavior = .pauseAndRestore
        view.addSubview(animationView1!)
        animationView2 = .init(name: "41267-loader")
        animationView2!.translatesAutoresizingMaskIntoConstraints = false
        animationView2!.contentMode = .scaleAspectFit
        animationView2!.loopMode = .loop
        animationView2!.animationSpeed = 0.5
        animationView2!.backgroundBehavior = .pauseAndRestore
        view.addSubview(animationView2!)
        animationView3 = .init(name: "9764-loader")
        animationView3!.translatesAutoresizingMaskIntoConstraints = false
        animationView3!.contentMode = .scaleAspectFit
        animationView3!.loopMode = .loop
        animationView3!.animationSpeed = 0.5
        animationView3!.backgroundBehavior = .pauseAndRestore
        view.addSubview(animationView3!)
        animationView4 = .init(name: "55510-atom-css-customisible")
        animationView4!.translatesAutoresizingMaskIntoConstraints = false
        animationView4!.contentMode = .scaleAspectFit
        animationView4!.loopMode = .loop
        animationView4!.animationSpeed = 1
        animationView4!.backgroundBehavior = .pauseAndRestore
        view.addSubview(animationView4!)
        
//        addObservers()
        setUp()
        
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [self] (t) in
            if !checkTime(TimeList: TimeList()).toCheckTime() {
                self.mainText.text = "Ce n'est pas encore l'heure revient dans \(getRtTime(TimeList: TimeList()).getDiffenceToList()) minutes"
            } else {
                self.mainText.text = "C'est l'heure de faire un vœu !"
            }
            lauchConfetti()
        }

        animationView1!.play()
        animationView2!.play()
        animationView3!.play()
        animationView4!.play()
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .sound, .alert]) {
                granted, error in
            if granted && error == nil{
                print("Permission granted: \(granted)")
            } else {
                print("Error: \(error!.localizedDescription)")
            }
        }
    }
    
    func lauchConfetti() {
        if !checkTime(TimeList: TimeList()).toCheckTime() {
            self.lanceur.emitterCells?.removeAll()
        } else {
            self.lanceur.lancerConfettis()
        }
    }
    
     public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewIsVisible = true
        print("viewIsVisible : \(viewIsVisible)")
        
        let title = "Hop hop hop regarde l'heure !"
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "slow-spring-board-longer-tail-571.m4r"))
        
        UNUserNotificationCenter.removeAllPendingNotificationRequests(UNUserNotificationCenter.current())()
        
//        sendNotifications0(title: title, content: content)
//
//        sendNotifications1(title: title, content: content)
//        sendNotifications2(title: title, content: content)
//        sendNotifications3(title: title, content: content)
//        sendNotifications4(title: title, content: content)
//        sendNotifications5(title: title, content: content)
//        sendNotifications6(title: title, content: content)
//        sendNotifications7(title: title, content: content)
//        sendNotifications8(title: title, content: content)
//        sendNotifications9(title: title, content: content)
//        sendNotifications10(title: title, content: content)
//        sendNotifications11(title: title, content: content)
//        sendNotifications12(title: title, content: content)
//        sendNotifications13(title: title, content: content)
//        sendNotifications14(title: title, content: content)
//        sendNotifications15(title: title, content: content)
//        sendNotifications16(title: title, content: content)
//        sendNotifications17(title: title, content: content)
//        sendNotifications18(title: title, content: content)
//        sendNotifications19(title: title, content: content)
//        sendNotifications20(title: title, content: content)
//        sendNotifications21(title: title, content: content)
//        sendNotifications22(title: title, content: content)
//        sendNotifications23(title: title, content: content)
//        sendNotifications24(title: title, content: content)
        
        setupAllNofications(title: title, content: content)
     }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewIsVisible = true
        print("viewIsVisible : \(viewIsVisible)")
        if checkTime(TimeList: TimeList()).toCheckTime() {
            self.lanceur.emitterCells?.removeAll()
        }
        print(viewIsVisible)
    }

    let mainText: UITextView = {
        let mainText = UITextView()
        
        mainText.text = "Ce n'est pas encore l'heure revient dans 0 minutes"
        mainText.textColor = .systemBlue
        mainText.backgroundColor = .clear
        mainText.font = .systemFont(ofSize: 15, weight: .light)
        mainText.textAlignment = .center
        mainText.isEditable = false
        mainText.isSelectable = false
        mainText.translatesAutoresizingMaskIntoConstraints = false
        
        return mainText
    }()
    
    let button: UIButton = {
        let button = UIButton()
        
        button.addTarget(self, action: #selector(buttonTouched), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .systemBlue
        button.contentMode = .scaleAspectFill
        
        return button
    }()
    
    func getUserStyle() -> UIColor {
        return UIColor { (traits) -> UIColor in

            return traits.userInterfaceStyle == .light ? .black : .white
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        let image = UIImage(systemName: "gearshape")?.tinted(with: getUserStyle()) as UIImage?
        button.setBackgroundImage(image, for: .normal)
    }
    
    private func setUp() {
        mainText.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mainText.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 250).isActive = true
        mainText.heightAnchor.constraint(equalToConstant: 50).isActive = true
        mainText.widthAnchor.constraint(equalToConstant: 400).isActive = true
        
        let image = UIImage(systemName: "gearshape")?.tinted(with: getUserStyle()) as UIImage?
        button.setBackgroundImage(image, for: .normal)
        
        button.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
        button.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        animationView1?.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        animationView1?.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        animationView1?.heightAnchor.constraint(equalToConstant: 450).isActive = true
        animationView1?.widthAnchor.constraint(equalToConstant: 450).isActive = true
        
        animationView2?.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        animationView2?.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        animationView2?.heightAnchor.constraint(equalToConstant: 230).isActive = true
        animationView2?.widthAnchor.constraint(equalToConstant: 230).isActive = true
        
        animationView3?.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        animationView3?.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        animationView3?.heightAnchor.constraint(equalToConstant: 180).isActive = true
        animationView3?.widthAnchor.constraint(equalToConstant: 180).isActive = true
        
        animationView4?.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        animationView4?.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        animationView4?.heightAnchor.constraint(equalToConstant: 100).isActive = true
        animationView4?.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
//    func addObservers() {
//        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidEnterBackground(noti:)), name: UIApplication.didEnterBackgroundNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(applicationWillEnterForeground(noti:)), name: UIApplication.didBecomeActiveNotification, object: nil)
//    }
    
//    @objc func applicationDidEnterBackground(noti: Notification) {
//        animationView1!.stop()
//        animationView2!.stop()
//        animationView3!.stop()
//        animationView4!.stop()
//        print("Enter background")
//    }
//    @objc func applicationWillEnterForeground(noti: Notification) {
//        animationView1!.play()
//        animationView2!.play()
//        animationView3!.play()
//        animationView4!.play()
//        print("Enter foreground")
//    }
    
    @objc func buttonTouched() {
        guard let infovc = storyboard?.instantiateViewController(identifier: "settings_vc") as? SettingsViewController else {
            return
        }       //wait view for info VC
        
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.prepare()
        generator.impactOccurred()
        
        performSegue(withIdentifier: "settings", sender: self)
//        self.present(infovc, animated: true)
    }
    
    func setupAllNofications(title: String, content: UNMutableNotificationContent) {
        if UserDefaults.standard.object(forKey: "activeScheduledNotificationsList") != nil {
            let activeScheduledNotificationsList = UserDefaults.standard.object(forKey: "activeScheduledNotificationsList") as! [Bool]
            for i in 0...23 {
                if activeScheduledNotificationsList[i] == true {
                    var dateComponents = DateComponents()
                    dateComponents.hour = i
                    dateComponents.minute = i
                    
                    if i == 0 {
                        content.body = "00:00 il est temps de faire un vœu."
                    } else {
                        content.body = "\(i < 10 ? "0" : "")\(i): \(i < 10 ? "0" : "")\(i) il est temps de faire un vœu."
                    }
                    
                    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
                    
                    let request = UNNotificationRequest(identifier: "notif\(i)", content: content, trigger: trigger)
                    
                    UNUserNotificationCenter.current().add(request) { (error: Error?) in
                        if let error = error {
                            print("Error: \(error.localizedDescription)")
                        }
                    }
                }
            }
        } else {
            for i in 0...23 {
                var dateComponents = DateComponents()
                dateComponents.hour = i
                dateComponents.minute = i
                
                if i == 0 {
                    content.body = "00:00 il est temps de faire un vœu."
                } else {
                    content.body = "\(i < 10 ? "0" : "")\(i):\(i < 10 ? "0" : "")\(i) il est temps de faire un vœu."
                }
                
                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
                
                let request = UNNotificationRequest(identifier: "notif\(i)", content: content, trigger: trigger)
                
                UNUserNotificationCenter.current().add(request) { (error: Error?) in
                    if let error = error {
                        print("Error: \(error.localizedDescription)")
                    }
                }
            }
        }
    }

    // MARK: -Notifications---------------------------------------------------------------------------------------------------------------------------

    //Notification Test
    func sendNotifications0(title: String, content: UNMutableNotificationContent) {
        var isActive = false
        
        if UserDefaults.standard.object(forKey: "activeScheduledNotificationsList") != nil {
            let activeScheduledNotificationsList = UserDefaults.standard.object(forKey: "activeScheduledNotificationsList") as! [Bool]
            isActive = activeScheduledNotificationsList[0]
        } else {
            isActive = true
        }
        
        if isActive {
            print("nitification activated")
            var dateComponents = DateComponents()
            dateComponents.hour = 1
            dateComponents.minute = 24
            
            content.body = "t:t il est temps de faire un vœu."
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            
            let request = UNNotificationRequest(identifier: "notifT", content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) { (error: Error?) in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                }
            }
        } else {
            print("is not")
        }
    }
    /*
    func sendNotifications1(title: String, content: UNMutableNotificationContent) {
        var isActive = false
        
        if UserDefaults.standard.object(forKey: "activeScheduledNotificationsList") != nil {
            let activeScheduledNotificationsList = UserDefaults.standard.object(forKey: "activeScheduledNotificationsList") as! [Bool]
            isActive = activeScheduledNotificationsList[0]
        } else {
            isActive = true
        }
        if isActive {
            var dateComponents = DateComponents()
            dateComponents.hour = 0
            dateComponents.minute = 0
            
            content.body = "00:00 il est temps de faire un vœu."
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            
            let request = UNNotificationRequest(identifier: "notif1", content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) { (error: Error?) in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                }
            }
        } else {
            print("is not")
        }
    }
    func sendNotifications2(title: String, content: UNMutableNotificationContent) {
        var isActive = false
        
        if UserDefaults.standard.object(forKey: "activeScheduledNotificationsList") != nil {
            let activeScheduledNotificationsList = UserDefaults.standard.object(forKey: "activeScheduledNotificationsList") as! [Bool]
            isActive = activeScheduledNotificationsList[1]
        } else {
            isActive = true
        }
        if isActive {
            var dateComponents = DateComponents()
            dateComponents.hour = 1
            dateComponents.minute = 1
            
            content.body = "01:01 il est temps de faire un vœu."
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            
            let request = UNNotificationRequest(identifier: "notif2", content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) { (error: Error?) in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                }
            }
        } else {
            print("is not")
        }
    }
    func sendNotifications3(title: String, content: UNMutableNotificationContent) {
        var isActive = false
        
        if UserDefaults.standard.object(forKey: "activeScheduledNotificationsList") != nil {
            let activeScheduledNotificationsList = UserDefaults.standard.object(forKey: "activeScheduledNotificationsList") as! [Bool]
            isActive = activeScheduledNotificationsList[2]
        } else {
            isActive = true
        }
        if isActive {
            var dateComponents = DateComponents()
            dateComponents.hour = 2
            dateComponents.minute = 2
            
            content.body = "02:02 il est temps de faire un vœu."
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            
            let request = UNNotificationRequest(identifier: "notif3", content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) { (error: Error?) in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                }
            }
        } else {
            print("is not")
        }
    }
    func sendNotifications4(title: String, content: UNMutableNotificationContent) {
        var isActive = false
        
        if UserDefaults.standard.object(forKey: "activeScheduledNotificationsList") != nil {
            let activeScheduledNotificationsList = UserDefaults.standard.object(forKey: "activeScheduledNotificationsList") as! [Bool]
            isActive = activeScheduledNotificationsList[3]
        } else {
            isActive = true
        }
        if isActive {
            var dateComponents = DateComponents()
            dateComponents.hour = 3
            dateComponents.minute = 3
            
            content.body = "03:03 il est temps de faire un vœu."
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            
            let request = UNNotificationRequest(identifier: "notif4", content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) { (error: Error?) in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                }
            }
        } else {
            print("is not")
        }
    }
    func sendNotifications5(title: String, content: UNMutableNotificationContent) {
        var isActive = false
        
        if UserDefaults.standard.object(forKey: "activeScheduledNotificationsList") != nil {
            let activeScheduledNotificationsList = UserDefaults.standard.object(forKey: "activeScheduledNotificationsList") as! [Bool]
            isActive = activeScheduledNotificationsList[4]
        } else {
            isActive = true
        }
        if isActive {
            var dateComponents = DateComponents()
            dateComponents.hour = 4
            dateComponents.minute = 4
            
            content.body = "04:04 il est temps de faire un vœu."
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            
            let request = UNNotificationRequest(identifier: "notif5", content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) { (error: Error?) in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                }
            }
        } else {
            print("is not")
        }
    }
    func sendNotifications6(title: String, content: UNMutableNotificationContent) {
        var isActive = false
        
        if UserDefaults.standard.object(forKey: "activeScheduledNotificationsList") != nil {
            let activeScheduledNotificationsList = UserDefaults.standard.object(forKey: "activeScheduledNotificationsList") as! [Bool]
            isActive = activeScheduledNotificationsList[5]
        } else {
            isActive = true
        }
        if isActive {
            var dateComponents = DateComponents()
            dateComponents.hour = 5
            dateComponents.minute = 5
            
            content.body = "05:05 il est temps de faire un vœu."
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            
            let request = UNNotificationRequest(identifier: "notif6", content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) { (error: Error?) in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                }
            }
        } else {
            print("is not")
        }
    }
    func sendNotifications7(title: String, content: UNMutableNotificationContent) {
        var isActive = false
        
        if UserDefaults.standard.object(forKey: "activeScheduledNotificationsList") != nil {
            let activeScheduledNotificationsList = UserDefaults.standard.object(forKey: "activeScheduledNotificationsList") as! [Bool]
            isActive = activeScheduledNotificationsList[6]
        } else {
            isActive = true
        }
        if isActive {
            var dateComponents = DateComponents()
            dateComponents.hour = 6
            dateComponents.minute = 6
            
            content.body = "06:06 il est temps de faire un vœu."
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            
            let request = UNNotificationRequest(identifier: "notif7", content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) { (error: Error?) in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                }
            }
        } else {
            print("is not")
        }
    }
    func sendNotifications8(title: String, content: UNMutableNotificationContent) {
        var isActive = false
        
        if UserDefaults.standard.object(forKey: "activeScheduledNotificationsList") != nil {
            let activeScheduledNotificationsList = UserDefaults.standard.object(forKey: "activeScheduledNotificationsList") as! [Bool]
            isActive = activeScheduledNotificationsList[7]
        } else {
            isActive = true
        }
        if isActive {
            var dateComponents = DateComponents()
            dateComponents.hour = 7
            dateComponents.minute = 7
            
            content.body = "07:07 il est temps de faire un vœu."
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            
            let request = UNNotificationRequest(identifier: "notif8", content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) { (error: Error?) in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                }
            }
        } else {
            print("is not")
        }
    }
    func sendNotifications9(title: String, content: UNMutableNotificationContent) {
        var isActive = false
        
        if UserDefaults.standard.object(forKey: "activeScheduledNotificationsList") != nil {
            let activeScheduledNotificationsList = UserDefaults.standard.object(forKey: "activeScheduledNotificationsList") as! [Bool]
            isActive = activeScheduledNotificationsList[8]
        } else {
            isActive = true
        }
        if isActive {
            var dateComponents = DateComponents()
            dateComponents.hour = 8
            dateComponents.minute = 8
            
            content.body = "08:08 il est temps de faire un vœu."
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            
            let request = UNNotificationRequest(identifier: "notif9", content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) { (error: Error?) in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                }
            }
        } else {
            print("is not")
        }
    }
    func sendNotifications10(title: String, content: UNMutableNotificationContent) {
        var isActive = false
        
        if UserDefaults.standard.object(forKey: "activeScheduledNotificationsList") != nil {
            let activeScheduledNotificationsList = UserDefaults.standard.object(forKey: "activeScheduledNotificationsList") as! [Bool]
            isActive = activeScheduledNotificationsList[9]
        } else {
            isActive = true
        }
        if isActive {
            var dateComponents = DateComponents()
            dateComponents.hour = 9
            dateComponents.minute = 9
            
            content.body = "09:09 il est temps de faire un vœu."
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            
            let request = UNNotificationRequest(identifier: "notif10", content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) { (error: Error?) in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                }
            }
        } else {
            print("is not")
        }
    }
    func sendNotifications11(title: String, content: UNMutableNotificationContent) {
        var isActive = false
        
        if UserDefaults.standard.object(forKey: "activeScheduledNotificationsList") != nil {
            let activeScheduledNotificationsList = UserDefaults.standard.object(forKey: "activeScheduledNotificationsList") as! [Bool]
            isActive = activeScheduledNotificationsList[10]
        } else {
            isActive = true
        }
        if isActive {
            var dateComponents = DateComponents()
            dateComponents.hour = 10
            dateComponents.minute = 10
            
            content.body = "10:10 il est temps de faire un vœu."
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            
            let request = UNNotificationRequest(identifier: "notif11", content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) { (error: Error?) in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                }
            }
        } else {
            print("is not")
        }
    }
    func sendNotifications12(title: String, content: UNMutableNotificationContent) {
        var isActive = false
        
        if UserDefaults.standard.object(forKey: "activeScheduledNotificationsList") != nil {
            let activeScheduledNotificationsList = UserDefaults.standard.object(forKey: "activeScheduledNotificationsList") as! [Bool]
            isActive = activeScheduledNotificationsList[11]
        } else {
            isActive = true
        }
        if isActive {
            var dateComponents = DateComponents()
            dateComponents.hour = 11
            dateComponents.minute = 11
            
            content.body = "11:11 il est temps de faire un vœu."
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            
            let request = UNNotificationRequest(identifier: "notif12", content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) { (error: Error?) in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                }
            }
        } else {
            print("is not")
        }
    }
    func sendNotifications13(title: String, content: UNMutableNotificationContent) {
        var isActive = false
        
        if UserDefaults.standard.object(forKey: "activeScheduledNotificationsList") != nil {
            let activeScheduledNotificationsList = UserDefaults.standard.object(forKey: "activeScheduledNotificationsList") as! [Bool]
            isActive = activeScheduledNotificationsList[12]
        } else {
            isActive = true
        }
        if isActive {
            var dateComponents = DateComponents()
            dateComponents.hour = 12
            dateComponents.minute = 12
            
            content.body = "12:12 il est temps de faire un vœu."
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            
            let request = UNNotificationRequest(identifier: "notif13", content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) { (error: Error?) in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                }
            }
        } else {
            print("is not")
        }
    }
    func sendNotifications14(title: String, content: UNMutableNotificationContent) {
        var isActive = false
        
        if UserDefaults.standard.object(forKey: "activeScheduledNotificationsList") != nil {
            let activeScheduledNotificationsList = UserDefaults.standard.object(forKey: "activeScheduledNotificationsList") as! [Bool]
            isActive = activeScheduledNotificationsList[13]
        } else {
            isActive = true
        }
        if isActive {
            var dateComponents = DateComponents()
            dateComponents.hour = 13
            dateComponents.minute = 13
            
            content.body = "13:13 il est temps de faire un vœu."
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            
            let request = UNNotificationRequest(identifier: "notif14", content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) { (error: Error?) in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                }
            }
        } else {
            print("is not")
        }
    }
    func sendNotifications15(title: String, content: UNMutableNotificationContent) {
        var isActive = false
        
        if UserDefaults.standard.object(forKey: "activeScheduledNotificationsList") != nil {
            let activeScheduledNotificationsList = UserDefaults.standard.object(forKey: "activeScheduledNotificationsList") as! [Bool]
            isActive = activeScheduledNotificationsList[14]
        } else {
            isActive = true
        }
        if isActive {
            var dateComponents = DateComponents()
            dateComponents.hour = 14
            dateComponents.minute = 14
            
            content.body = "14:14 il est temps de faire un vœu."
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            
            let request = UNNotificationRequest(identifier: "notif15", content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) { (error: Error?) in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                }
            }
        } else {
            print("is not")
        }
    }
    func sendNotifications16(title: String, content: UNMutableNotificationContent) {
        var isActive = false
        
        if UserDefaults.standard.object(forKey: "activeScheduledNotificationsList") != nil {
            let activeScheduledNotificationsList = UserDefaults.standard.object(forKey: "activeScheduledNotificationsList") as! [Bool]
            isActive = activeScheduledNotificationsList[15]
        } else {
            isActive = true
        }
        if isActive {
            var dateComponents = DateComponents()
            dateComponents.hour = 15
            dateComponents.minute = 15
            
            content.body = "15:15 il est temps de faire un vœu."
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            
            let request = UNNotificationRequest(identifier: "notif416", content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) { (error: Error?) in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                }
            }
        } else {
            print("is not")
        }
    }
    func sendNotifications17(title: String, content: UNMutableNotificationContent) {
        var isActive = false
        
        if UserDefaults.standard.object(forKey: "activeScheduledNotificationsList") != nil {
            let activeScheduledNotificationsList = UserDefaults.standard.object(forKey: "activeScheduledNotificationsList") as! [Bool]
            isActive = activeScheduledNotificationsList[16]
        } else {
            isActive = true
        }
        if isActive {
            var dateComponents = DateComponents()
            dateComponents.hour = 16
            dateComponents.minute = 16
            
            content.body = "16:16 il est temps de faire un vœu."
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            
            let request = UNNotificationRequest(identifier: "notif17", content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) { (error: Error?) in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                }
            }
        } else {
            print("is not")
        }
    }
    func sendNotifications18(title: String, content: UNMutableNotificationContent) {
        var isActive = false
        
        if UserDefaults.standard.object(forKey: "activeScheduledNotificationsList") != nil {
            let activeScheduledNotificationsList = UserDefaults.standard.object(forKey: "activeScheduledNotificationsList") as! [Bool]
            isActive = activeScheduledNotificationsList[17]
        } else {
            isActive = true
        }
        if isActive {
            var dateComponents = DateComponents()
            dateComponents.hour = 17
            dateComponents.minute = 17
            
            content.body = "17:17 il est temps de faire un vœu."
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            
            let request = UNNotificationRequest(identifier: "notif18", content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) { (error: Error?) in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                }
            }
        } else {
            print("is not")
        }
    }
    func sendNotifications19(title: String, content: UNMutableNotificationContent) {
        var isActive = false
        
        if UserDefaults.standard.object(forKey: "activeScheduledNotificationsList") != nil {
            let activeScheduledNotificationsList = UserDefaults.standard.object(forKey: "activeScheduledNotificationsList") as! [Bool]
            isActive = activeScheduledNotificationsList[18]
        } else {
            isActive = true
        }
        if isActive {
            var dateComponents = DateComponents()
            dateComponents.hour = 18
            dateComponents.minute = 18
            
            content.body = "18:18 il est temps de faire un vœu."
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            
            let request = UNNotificationRequest(identifier: "notif19", content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) { (error: Error?) in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                }
            }
        } else {
            print("is not")
        }
    }
    func sendNotifications20(title: String, content: UNMutableNotificationContent) {
        var isActive = false
        
        if UserDefaults.standard.object(forKey: "activeScheduledNotificationsList") != nil {
            let activeScheduledNotificationsList = UserDefaults.standard.object(forKey: "activeScheduledNotificationsList") as! [Bool]
            isActive = activeScheduledNotificationsList[19]
        } else {
            isActive = true
        }
        if isActive {
            var dateComponents = DateComponents()
            dateComponents.hour = 19
            dateComponents.minute = 19
            
            content.body = "19:19 il est temps de faire un vœu."
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            
            let request = UNNotificationRequest(identifier: "notif20", content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) { (error: Error?) in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                }
            }
        } else {
            print("is not")
        }
    }
    func sendNotifications21(title: String, content: UNMutableNotificationContent) {
        var isActive = false
        
        if UserDefaults.standard.object(forKey: "activeScheduledNotificationsList") != nil {
            let activeScheduledNotificationsList = UserDefaults.standard.object(forKey: "activeScheduledNotificationsList") as! [Bool]
            isActive = activeScheduledNotificationsList[20]
        } else {
            isActive = true
        }
        if isActive {
            var dateComponents = DateComponents()
            dateComponents.hour = 20
            dateComponents.minute = 20
            
            content.body = "20:20 il est temps de faire un vœu."
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            
            let request = UNNotificationRequest(identifier: "notif21", content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) { (error: Error?) in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                }
            }
        } else {
            print("is not")
        }
    }
    func sendNotifications22(title: String, content: UNMutableNotificationContent) {
        var isActive = false
        
        if UserDefaults.standard.object(forKey: "activeScheduledNotificationsList") != nil {
            let activeScheduledNotificationsList = UserDefaults.standard.object(forKey: "activeScheduledNotificationsList") as! [Bool]
            isActive = activeScheduledNotificationsList[21]
        } else {
            isActive = true
        }
        if isActive {
            var dateComponents = DateComponents()
            dateComponents.hour = 21
            dateComponents.minute = 21
            
            content.body = "21:21 il est temps de faire un vœu."
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            
            let request = UNNotificationRequest(identifier: "notif22", content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) { (error: Error?) in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                }
            }
        } else {
            print("is not")
        }
    }
    func sendNotifications23(title: String, content: UNMutableNotificationContent) {
        var isActive = false
        
        if UserDefaults.standard.object(forKey: "activeScheduledNotificationsList") != nil {
            let activeScheduledNotificationsList = UserDefaults.standard.object(forKey: "activeScheduledNotificationsList") as! [Bool]
            isActive = activeScheduledNotificationsList[22]
        } else {
            isActive = true
        }
        if isActive {
            var dateComponents = DateComponents()
            dateComponents.hour = 22
            dateComponents.minute = 22
            
            content.body = "22:22 il est temps de faire un vœu."
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            
            let request = UNNotificationRequest(identifier: "notif24", content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) { (error: Error?) in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                }
            }
        } else {
            print("is not")
        }
    }
    func sendNotifications24(title: String, content: UNMutableNotificationContent) {
        var isActive = false
        
        if UserDefaults.standard.object(forKey: "activeScheduledNotificationsList") != nil {
            let activeScheduledNotificationsList = UserDefaults.standard.object(forKey: "activeScheduledNotificationsList") as! [Bool]
            isActive = activeScheduledNotificationsList[23]
        } else {
            isActive = true
        }
        if isActive {
            var dateComponents = DateComponents()
            dateComponents.hour = 23
            dateComponents.minute = 23
            
            content.body = "23:23 il est temps de faire un vœu."
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            
            let request = UNNotificationRequest(identifier: "notif25", content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) { (error: Error?) in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                }
            }
        } else {
            print("is not")
        }
    }*/
}

extension UIImage {
    func tinted(with color: UIColor, isOpaque: Bool = false) -> UIImage? {
        let format = imageRendererFormat
        format.opaque = isOpaque
        return UIGraphicsImageRenderer(size: size, format: format).image { _ in
            color.set()
            withRenderingMode(.alwaysTemplate).draw(at: .zero)
        }
    }
}
