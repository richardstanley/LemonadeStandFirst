//
//  ViewController.swift
//  LemonadeStand
//
//  Created by Richard Stanley on 11/12/14.
//  Copyright (c) 2014 Kicking Monkey. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var firstContainer: UIView!
    var secondContainer: UIView!
    var thirdContainer: UIView!
    var fourthContainer: UIView!
    
    //Labels for first container
    var youHaveLabel: UILabel!
    var cashAvailableLabel: UILabel!
    var lemonsAvailableLabel: UILabel!
    var iceCubesAvailableLabel: UILabel!
    
    //Labels for second container
    var step1Label: UILabel!
    var lemonsForLabel: UILabel!
    var iceCubesForLabel: UILabel!
    var purchasedLemonsLabel: UILabel!
    var purchasedIceCubesLabel: UILabel!
    
    //Labels for third container
    var step2Label: UILabel!
    var lemonsMixLabel: UILabel!
    var iceCubesMixLabel: UILabel!
    var mixedLemonsLabel: UILabel!
    var mixedIceCubesLabel: UILabel!
    
    //Labels for fourth container
    var step3Label: UILabel!
    var dayStatusLabel: UILabel!
    
    //Buttons in second container
    var purchaseLemonButton: UIButton!
    var purchaseIceCubeButtton: UIButton!
    var sellLemonButton: UIButton!
    var sellIceCubeButton: UIButton!
    
    //Buttons in third container
    var mixLemonButton: UIButton!
    var mixIceCubeButton: UIButton!
    var unmixLemonButton: UIButton!
    var unmixIceCubeButton: UIButton!
    
    //Buttons in fourth container
    var startDayButton: UIButton!
    
    var cashAvailable = 10
    var lemonsAvailable = 1
    var iceCubesAvailable = 1
    
    var purchasedLemons = 0
    var purchasedIceCubes = 0
    var mixedLemons = 0
    var mixedIceCubes = 0
    var soldLemonades = 0
    var weatherOfDay = 0
    
    let kMarginForView: CGFloat = 10.0
    
    let kThird: CGFloat = 1.0/3.0
    let kFourth: CGFloat = 1.0/4.0
    
    @IBOutlet var weatherImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setupContainerViews()
        setupFirstContainer(self.firstContainer)
        setupSecondContainer(self.secondContainer)
        setupThirdContainer(self.thirdContainer)
        setupFourthContainer(self.fourthContainer)
 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //IBActions
    
    func purchaseLemonButtonPressed (button: UIButton) {
        if cashAvailable >= 2 {
            cashAvailable -= 2
            purchasedLemons++
            lemonsAvailable++
        }
    
        updateMainView()
    }
    
    func purchaseIceCubeButtonPressed (button: UIButton) {
        if cashAvailable >= 1 {
            cashAvailable -= 1
            purchasedIceCubes++
            iceCubesAvailable++
        }
        
        updateMainView()
    }
    
    func sellLemonButtonPressed (button: UIButton) {
        if purchasedLemons >= 1 && lemonsAvailable > 0 {
            cashAvailable += 2
            purchasedLemons--
            lemonsAvailable--
        }
        
        updateMainView()
    }
    
    func sellIceCubeButtonPressed (button: UIButton) {
        if purchasedIceCubes >= 1 && iceCubesAvailable > 0 {
            cashAvailable += 1
            purchasedIceCubes--
            iceCubesAvailable--
        }
        
        updateMainView()
    }
    
    func mixLemonButtonPressed (button: UIButton) {
        if lemonsAvailable > 0 {
            lemonsAvailable--
            mixedLemons++
        }
        
        updateMainView()
    }
    
    func mixIceCubeButtonPressed (button: UIButton) {
        if iceCubesAvailable > 0 {
            iceCubesAvailable--
            mixedIceCubes++
        }
        
        updateMainView()
    }
    
    func unmixLemonButtonPressed (button: UIButton) {
        if mixedLemons > 0 {
            mixedLemons--
            lemonsAvailable++
        }
        
        updateMainView()
    }
    
    func unmixIceCubeButtonPressed (button: UIButton) {
        if mixedIceCubes > 0 {
            mixedIceCubes--
            iceCubesAvailable++
        }
        
        updateMainView()
    }
    
    func startDayButtonPressed (button: UIButton) {
        var lemonadeRatio: Double
        var numberOfCustomers = Int(arc4random_uniform(UInt32(10)))
        var randomValue: Int
        var customerPref: Double
        
        soldLemonades = 0
            
        if mixedLemons > 0 && mixedIceCubes > 0{
            lemonadeRatio = Double(mixedLemons) / Double(mixedIceCubes)
            
            if weatherOfDay == 1{
                numberOfCustomers += 4
            }
            
            if weatherOfDay == 2{
                numberOfCustomers -= 3
            }
        
        for var customer = 0; customer < numberOfCustomers; customer++ {
            randomValue = Int(arc4random_uniform(UInt32(10)))
            customerPref = Double(randomValue) * 0.1
            
            if customerPref < 0.4 && lemonadeRatio > 1 {
                soldLemonades++
                println("Sold Acidic Lemonade")
            }
            else if customerPref >= 0.4 && customerPref <= 0.7 &&  lemonadeRatio == 1 {
                soldLemonades++
                println("Sold Average Lemonade")
            }
            else if customerPref > 0.7 && lemonadeRatio < 1 {
                soldLemonades++
                println("Sold Dilute Lemonade")
            }
            else {
                println("No Sale")
            }
            }
            
        }
        
        cashAvailable += soldLemonades
        purchasedLemons = 0
        purchasedIceCubes = 0
        mixedLemons = 0
        mixedIceCubes = 0
        weatherOfDay = Int(arc4random_uniform(UInt32(3)))
        
        updateMainView()
    }
    

    func updateMainView() {
        self.cashAvailableLabel.text = "$\(cashAvailable)"
        self.lemonsAvailableLabel.text = "\(lemonsAvailable) Lemons"
        self.iceCubesAvailableLabel.text = "\(iceCubesAvailable) Ice Cubes"
        self.purchasedLemonsLabel.text = "\(purchasedLemons)"
        self.purchasedIceCubesLabel.text = "\(purchasedIceCubes)"
        self.mixedLemonsLabel.text = "\(mixedLemons)"
        self.mixedIceCubesLabel.text = "\(mixedIceCubes)"
        self.dayStatusLabel.text = "You sold \(soldLemonades) lemonades yesterday."

    }
    
    func setupContainerViews() {
    
        self.firstContainer = UIView(frame: CGRect(x: self.view.bounds.origin.x + kMarginForView, y: self.view.bounds.origin.y, width: self.view.bounds.width - 2 * kMarginForView, height: self.view.bounds.height * kFourth))
        self.firstContainer.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(self.firstContainer)
        
        self.secondContainer = UIView(frame: CGRect(x: self.view.bounds.origin.x + kMarginForView, y: firstContainer.frame.height, width: self.view.bounds.width - 2 * kMarginForView, height: self.view.bounds.height * kFourth))
        self.secondContainer.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(self.secondContainer)
       
        self.thirdContainer = UIView(frame: CGRect(x: self.view.bounds.origin.x + kMarginForView, y: firstContainer.frame.height + secondContainer.frame.height, width: self.view.bounds.width - 2 * kMarginForView, height: self.view.bounds.height * kFourth))
        self.thirdContainer.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(self.thirdContainer)
       
        self.fourthContainer = UIView(frame: CGRect(x: self.view.bounds.origin.x + kMarginForView, y: firstContainer.frame.height + secondContainer.frame.height + thirdContainer.frame.height, width: self.view.bounds.width - 2 * kMarginForView, height: self.view.bounds.height * kFourth))
        self.fourthContainer.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(self.fourthContainer)
        
        
    }
    
    func setupFirstContainer(containerView: UIView) {
        
        //Labels
        self.youHaveLabel = UILabel()
        self.youHaveLabel.text = "You Have:"
        self.youHaveLabel.textColor = UIColor.redColor()
        self.youHaveLabel.font = UIFont(name: "Menlo-Bold", size: 18)
        self.youHaveLabel.sizeToFit()
        self.youHaveLabel.center = CGPoint(x: containerView.frame.width * kFourth, y: containerView.frame.height * kFourth)
        self.youHaveLabel.textAlignment = NSTextAlignment.Left
        containerView.addSubview(self.youHaveLabel)
        
        self.cashAvailableLabel = UILabel()
        self.cashAvailableLabel.text = "$\(cashAvailable)"
        self.cashAvailableLabel.textColor = UIColor.greenColor()
        self.cashAvailableLabel.font = UIFont(name: "Menlo-Bold", size: 18)
        self.cashAvailableLabel.sizeToFit()
        self.cashAvailableLabel.center = CGPoint(x: containerView.frame.width * kFourth * 3, y: containerView.frame.height * kFourth)
        self.cashAvailableLabel.textAlignment = NSTextAlignment.Right
        containerView.addSubview(self.cashAvailableLabel)
        
        self.lemonsAvailableLabel = UILabel()
        self.lemonsAvailableLabel.text = "\(lemonsAvailable) Lemons"
        self.lemonsAvailableLabel.textColor = UIColor.blackColor()
        self.lemonsAvailableLabel.font = UIFont(name: "Menlo-Bold", size: 18)
        self.lemonsAvailableLabel.sizeToFit()
        self.lemonsAvailableLabel.center = CGPoint(x: containerView.frame.width * kFourth * 3, y: containerView.frame.height * kFourth * 2)
        self.lemonsAvailableLabel.textAlignment = NSTextAlignment.Right
        containerView.addSubview(self.lemonsAvailableLabel)
        
        self.iceCubesAvailableLabel = UILabel()
        self.iceCubesAvailableLabel.text = "\(iceCubesAvailable) Ice Cubes"
        self.iceCubesAvailableLabel.textColor = UIColor.blackColor()
        self.iceCubesAvailableLabel.font = UIFont(name: "Menlo-Bold", size: 18)
        self.iceCubesAvailableLabel.sizeToFit()
        self.iceCubesAvailableLabel.center = CGPoint(x: containerView.frame.width * kFourth * 3, y: containerView.frame.height * kFourth * 3)
        self.iceCubesAvailableLabel.textAlignment = NSTextAlignment.Right
        containerView.addSubview(self.iceCubesAvailableLabel)
        
    }

func setupSecondContainer(containerView: UIView) {
    
    //Labels
    self.step1Label = UILabel()
    self.step1Label.text = "Step 1: Purchase your supplies"
    self.step1Label.textColor = UIColor.blueColor()
    self.step1Label.font = UIFont(name: "Menlo-Bold", size: 16)
    self.step1Label.sizeToFit()
    self.step1Label.center = CGPoint(x: containerView.frame.width * kFourth * 2, y: containerView.frame.height * kFourth * kThird * 2)
    self.step1Label.textAlignment = NSTextAlignment.Left
    containerView.addSubview(self.step1Label)
    
    self.lemonsForLabel = UILabel()
    self.lemonsForLabel.text = "Lemons for $2:"
    self.lemonsForLabel.textColor = UIColor.blackColor()
    self.lemonsForLabel.font = UIFont(name: "Menlo-Bold", size: 18)
    self.lemonsForLabel.sizeToFit()
    self.lemonsForLabel.center = CGPoint(x: containerView.frame.width * kFourth, y: containerView.frame.height * kFourth * 2)
    self.lemonsForLabel.textAlignment = NSTextAlignment.Right
    containerView.addSubview(self.lemonsForLabel)
    
    self.iceCubesForLabel = UILabel()
    self.iceCubesForLabel.text = "Ice Cubes for $1:"
    self.iceCubesForLabel.textColor = UIColor.blackColor()
    self.iceCubesForLabel.font = UIFont(name: "Menlo-Bold", size: 18)
    self.iceCubesForLabel.sizeToFit()
    self.iceCubesForLabel.center = CGPoint(x: containerView.frame.width * kFourth, y: containerView.frame.height * kFourth * 3)
    self.iceCubesForLabel.textAlignment = NSTextAlignment.Right
    containerView.addSubview(self.iceCubesForLabel)
    
    self.purchasedLemonsLabel = UILabel()
    self.purchasedLemonsLabel.text = "\(purchasedLemons)"
    self.purchasedLemonsLabel.textColor = UIColor.blackColor()
    self.purchasedLemonsLabel.font = UIFont(name: "Menlo-Bold", size: 18)
    self.purchasedLemonsLabel.sizeToFit()
    self.purchasedLemonsLabel.center = CGPoint(x: containerView.frame.width * kFourth * 3, y: containerView.frame.height * kFourth * 2)
    self.purchasedLemonsLabel.textAlignment = NSTextAlignment.Center
    containerView.addSubview(self.purchasedLemonsLabel)
    
    self.purchasedIceCubesLabel = UILabel()
    self.purchasedIceCubesLabel.text = "\(purchasedIceCubes)"
    self.purchasedIceCubesLabel.textColor = UIColor.blackColor()
    self.purchasedIceCubesLabel.font = UIFont(name: "Menlo-Bold", size: 18)
    self.purchasedIceCubesLabel.sizeToFit()
    self.purchasedIceCubesLabel.center = CGPoint(x: containerView.frame.width * kFourth * 3, y: containerView.frame.height * kFourth * 3)
    self.purchasedIceCubesLabel.textAlignment = NSTextAlignment.Center
    containerView.addSubview(self.purchasedIceCubesLabel)
    
    //Buttons
    
    self.purchaseLemonButton = UIButton()
    self.purchaseLemonButton.setTitle("+", forState: UIControlState.Normal)
    self.purchaseLemonButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
    self.purchaseLemonButton.titleLabel?.font = UIFont(name: "Menlo-Bold", size: 18)
    self.purchaseLemonButton.backgroundColor = UIColor.whiteColor()
    self.purchaseLemonButton.sizeToFit()
    self.purchaseLemonButton.center = CGPoint(x: containerView.frame.width * kFourth * kThird * 8, y: containerView.frame.height * kFourth * 2)
    self.purchaseLemonButton.addTarget(self, action: "purchaseLemonButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
    containerView.addSubview(self.purchaseLemonButton)
    
    self.purchaseIceCubeButtton = UIButton()
    self.purchaseIceCubeButtton.setTitle("+", forState: UIControlState.Normal)
    self.purchaseIceCubeButtton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
    self.purchaseIceCubeButtton.titleLabel?.font = UIFont(name: "Menlo-Bold", size: 18)
    self.purchaseIceCubeButtton.backgroundColor = UIColor.whiteColor()
    self.purchaseIceCubeButtton.sizeToFit()
    self.purchaseIceCubeButtton.center = CGPoint(x: containerView.frame.width * kFourth * kThird * 8, y: containerView.frame.height * kFourth * 3)
    self.purchaseIceCubeButtton.addTarget(self, action: "purchaseIceCubeButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
    containerView.addSubview(self.purchaseIceCubeButtton)

    self.sellLemonButton = UIButton()
    self.sellLemonButton.setTitle("-", forState: UIControlState.Normal)
    self.sellLemonButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
    self.sellLemonButton.titleLabel?.font = UIFont(name: "Menlo-Bold", size: 18)
    self.sellLemonButton.backgroundColor = UIColor.whiteColor()
    self.sellLemonButton.sizeToFit()
    self.sellLemonButton.center = CGPoint(x: containerView.frame.width * kFourth * kThird * 10, y: containerView.frame.height * kFourth * 2)
    self.sellLemonButton.addTarget(self, action: "sellLemonButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
    containerView.addSubview(self.sellLemonButton)
    
    self.sellIceCubeButton = UIButton()
    self.sellIceCubeButton.setTitle("-", forState: UIControlState.Normal)
    self.sellIceCubeButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
    self.sellIceCubeButton.titleLabel?.font = UIFont(name: "Menlo-Bold", size: 18)
    self.sellIceCubeButton.backgroundColor = UIColor.whiteColor()
    self.sellIceCubeButton.sizeToFit()
    self.sellIceCubeButton.center = CGPoint(x: containerView.frame.width * kFourth * kThird * 10, y: containerView.frame.height * kFourth * 3)
    self.sellIceCubeButton.addTarget(self, action: "sellIceCubeButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
    containerView.addSubview(self.sellIceCubeButton)
    
    }

func setupThirdContainer(containerView: UIView) {
    
    //Labels
    self.step2Label = UILabel()
    self.step2Label.text = "Step 2: Mix your lemonade"
    self.step2Label.textColor = UIColor.blueColor()
    self.step2Label.font = UIFont(name: "Menlo-Bold", size: 16)
    self.step2Label.sizeToFit()
    self.step2Label.center = CGPoint(x: containerView.frame.width * kFourth * 2, y: containerView.frame.height * kFourth * kThird * 2)
    self.step2Label.textAlignment = NSTextAlignment.Left
    containerView.addSubview(self.step2Label)

    self.lemonsMixLabel = UILabel()
    self.lemonsMixLabel.text = "Lemons"
    self.lemonsMixLabel.textColor = UIColor.blackColor()
    self.lemonsMixLabel.font = UIFont(name: "Menlo-Bold", size: 18)
    self.lemonsMixLabel.sizeToFit()
    self.lemonsMixLabel.center = CGPoint(x: containerView.frame.width * kFourth, y: containerView.frame.height * kFourth * 2)
    self.lemonsMixLabel.textAlignment = NSTextAlignment.Right
    containerView.addSubview(self.lemonsMixLabel)
    
    self.iceCubesMixLabel = UILabel()
    self.iceCubesMixLabel.text = "Ice Cubes"
    self.iceCubesMixLabel.textColor = UIColor.blackColor()
    self.iceCubesMixLabel.font = UIFont(name: "Menlo-Bold", size: 18)
    self.iceCubesMixLabel.sizeToFit()
    self.iceCubesMixLabel.center = CGPoint(x: containerView.frame.width * kFourth, y: containerView.frame.height * kFourth * 3)
    self.iceCubesMixLabel.textAlignment = NSTextAlignment.Right
    containerView.addSubview(self.iceCubesMixLabel)
    
    self.mixedLemonsLabel = UILabel()
    self.mixedLemonsLabel.text = "\(mixedLemons)"
    self.mixedLemonsLabel.textColor = UIColor.blackColor()
    self.mixedLemonsLabel.font = UIFont(name: "Menlo-Bold", size: 18)
    self.mixedLemonsLabel.sizeToFit()
    self.mixedLemonsLabel.center = CGPoint(x: containerView.frame.width * kFourth * 3, y: containerView.frame.height * kFourth * 2)
    self.mixedLemonsLabel.textAlignment = NSTextAlignment.Right
    containerView.addSubview(self.mixedLemonsLabel)

    self.mixedIceCubesLabel = UILabel()
    self.mixedIceCubesLabel.text = "\(mixedIceCubes)"
    self.mixedIceCubesLabel.textColor = UIColor.blackColor()
    self.mixedIceCubesLabel.font = UIFont(name: "Menlo-Bold", size: 18)
    self.mixedIceCubesLabel.sizeToFit()
    self.mixedIceCubesLabel.center = CGPoint(x: containerView.frame.width * kFourth * 3, y: containerView.frame.height * kFourth * 3)
    self.mixedIceCubesLabel.textAlignment = NSTextAlignment.Right
    containerView.addSubview(self.mixedIceCubesLabel)
    
    //Buttons
    
    self.mixLemonButton = UIButton()
    self.mixLemonButton.setTitle("+", forState: UIControlState.Normal)
    self.mixLemonButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
    self.mixLemonButton.titleLabel?.font = UIFont(name: "Menlo-Bold", size: 18)
    self.mixLemonButton.backgroundColor = UIColor.whiteColor()
    self.mixLemonButton.sizeToFit()
    self.mixLemonButton.center = CGPoint(x: containerView.frame.width * kFourth * kThird * 8, y: containerView.frame.height * kFourth * 2)
    self.mixLemonButton.addTarget(self, action: "mixLemonButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
    containerView.addSubview(self.mixLemonButton)
    
    self.mixIceCubeButton = UIButton()
    self.mixIceCubeButton.setTitle("+", forState: UIControlState.Normal)
    self.mixIceCubeButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
    self.mixIceCubeButton.titleLabel?.font = UIFont(name: "Menlo-Bold", size: 18)
    self.mixIceCubeButton.backgroundColor = UIColor.whiteColor()
    self.mixIceCubeButton.sizeToFit()
    self.mixIceCubeButton.center = CGPoint(x: containerView.frame.width * kFourth * kThird * 8, y: containerView.frame.height * kFourth * 3)
    self.mixIceCubeButton.addTarget(self, action: "mixIceCubeButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
    containerView.addSubview(self.mixIceCubeButton)
    
    self.unmixLemonButton = UIButton()
    self.unmixLemonButton.setTitle("-", forState: UIControlState.Normal)
    self.unmixLemonButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
    self.unmixLemonButton.titleLabel?.font = UIFont(name: "Menlo-Bold", size: 18)
    self.unmixLemonButton.backgroundColor = UIColor.whiteColor()
    self.unmixLemonButton.sizeToFit()
    self.unmixLemonButton.center = CGPoint(x: containerView.frame.width * kFourth * kThird * 10, y: containerView.frame.height * kFourth * 2)
    self.unmixLemonButton.addTarget(self, action: "unmixLemonButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
    containerView.addSubview(self.unmixLemonButton)
    
    self.unmixIceCubeButton = UIButton()
    self.unmixIceCubeButton.setTitle("-", forState: UIControlState.Normal)
    self.unmixIceCubeButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
    self.unmixIceCubeButton.titleLabel?.font = UIFont(name: "Menlo-Bold", size: 18)
    self.unmixIceCubeButton.backgroundColor = UIColor.whiteColor()
    self.unmixIceCubeButton.sizeToFit()
    self.unmixIceCubeButton.center = CGPoint(x: containerView.frame.width * kFourth * kThird * 10, y: containerView.frame.height * kFourth * 3)
    self.unmixIceCubeButton.addTarget(self, action: "unmixIceCubeButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
    containerView.addSubview(self.unmixIceCubeButton)
    
    }

func setupFourthContainer(containerView: UIView) {
    //Labels
    self.step3Label = UILabel()
    self.step3Label.text = "Step 3: Start selling your brew"
    self.step3Label.textColor = UIColor.blueColor()
    self.step3Label.font = UIFont(name: "Menlo-Bold", size: 16)
    self.step3Label.sizeToFit()
    self.step3Label.center = CGPoint(x: containerView.frame.width * kFourth * 2, y: containerView.frame.height * kFourth * kThird * 2)
    self.step3Label.textAlignment = NSTextAlignment.Left
    containerView.addSubview(self.step3Label)
    
    self.dayStatusLabel = UILabel()
    self.dayStatusLabel.text = "You sold \(soldLemonades) lemonades yesterday."
    self.dayStatusLabel.textColor = UIColor.blackColor()
    self.dayStatusLabel.font = UIFont(name: "Menlo-Bold", size: 18)
    self.dayStatusLabel.sizeToFit()
    self.dayStatusLabel.center = CGPoint(x: containerView.frame.width * kFourth * 2, y: containerView.frame.height * kFourth * 2)
    self.dayStatusLabel.textAlignment = NSTextAlignment.Right
    containerView.addSubview(self.dayStatusLabel)
    
    //Buttons
    self.startDayButton = UIButton()
    self.startDayButton.setTitle("Start Day", forState: UIControlState.Normal)
    self.startDayButton.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
    self.startDayButton.titleLabel?.font = UIFont(name: "Menlo-Bold", size: 20)
    self.startDayButton.backgroundColor = UIColor.yellowColor()
    self.startDayButton.sizeToFit()
    self.startDayButton.center = CGPoint(x: containerView.frame.width * kFourth * 2, y: containerView.frame.height * kFourth * 3)
    self.startDayButton.addTarget(self, action: "startDayButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
    containerView.addSubview(self.startDayButton)
}

}

