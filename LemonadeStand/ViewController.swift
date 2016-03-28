//
//  ViewController.swift
//  LemonadeStand
//
//  Created by Neil Houselander on 14/03/2016.
//  Copyright © 2016 Neil Houselander. All rights reserved.
//


// NEIL DO NEXT
// implement way of changing sell price

import UIKit

class ViewController: UIViewController {
    
    
    //MARK: Properties: Outlets
    //conatiner Two Outlets
    @IBOutlet weak var containerTwoView: UIView!
    @IBOutlet weak var moneyLeftLabel: UILabel!
    @IBOutlet weak var lemonsLeftLabel: UILabel!
    @IBOutlet weak var cubesLeftLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var weatherDesciptionLabel: UILabel!
    @IBOutlet weak var moneyLeftImageView: UIImageView!
    @IBOutlet weak var lemonsLeftImageView: UIImageView!
    @IBOutlet weak var cubesLeftImageView: UIImageView!
    
    
    //Container Three Outlets
    
    @IBOutlet weak var numberLemonsPurchasedLabel: UILabel!
    @IBOutlet weak var numberCubesPurchasedLabel: UILabel!
    @IBOutlet weak var unPurchaseLemonButtonOutlet: UIButton!
    @IBOutlet weak var purchaseLemonButtonOutlet: UIButton!
    @IBOutlet weak var unPurchaseCubesButtonOutlet: UIButton!
    @IBOutlet weak var purchaseCubesButtonOutlet: UIButton!
    @IBOutlet weak var purchaseLemonImageView: UIImageView!
    @IBOutlet weak var purchaseCubeImageView: UIImageView!
    
    //container four outlets
    @IBOutlet weak var removeLemonsFromMixButtonOutlet: UIButton!
    @IBOutlet weak var addLemonsToMixButtonOutlet: UIButton!
    @IBOutlet weak var numberLemonsInMixLabel: UILabel!
    @IBOutlet weak var removeCubesFromMixButtonOutlet: UIButton!
    @IBOutlet weak var addCubesToMixButtonOutlet: UIButton!
    @IBOutlet weak var numberCubesInMixLabel: UILabel!
    @IBOutlet weak var mixLemonImageView: UIImageView!
    @IBOutlet weak var mixCubeLemonView: UIImageView!
    @IBOutlet weak var containerFourView: UIView!
    
    //container five outlets
    
    @IBOutlet weak var startDayButtonOutlet: UIButton!
    
    //summary views
    var endOfGameSummaryView: UIView!
    var endOfGameSummaryViewInner: UIView!
    
    var endOfDaySummaryView: UIView!
    var endOfDaySummaryViewInner: UIView!
    
    //Game over summary properties
    var gameOverTitle: UILabel!
    var youLastedLabel: UILabel!
    var youHadCustomersLabel: UILabel!
    var youSoldGlassesLabel: UILabel!
    var youMadeProfitLabel: UILabel!
    
    //End of day summary labels
    var dailyReportTitle: UILabel!
    var weatherTodayLabel: UILabel!
    var numberOfCustomersTodayLabel: UILabel!
    var numberGlassesSoldLabel: UILabel!
    var typeLemonadeMadeTodayLabel: UILabel!
    var numberCustomerLikedStrongTodayLabel: UILabel!
    var numberCustomersLikedBalancedTodayLabel: UILabel!
    var numberCustomersLikedWeakTodayLabel: UILabel!
    var totalProfitLabel: UILabel!
    
    
    
    //MARK: constants
    let kMaxNumberOfCustomers = 10
    let kMainBlueColour = UIColor(red: 127/255, green: 179/255, blue: 171/255, alpha: 1.0)
    let kMainYellowColour = UIColor(red: 249/255, green: 239/255, blue: 151/255, alpha: 1)
    let kMainOrangeColour = UIColor(red: 255/255, green: 156/255, blue: 83/255, alpha: 1.0)
    let kSummaryViewFont = UIFont(name: "ChalkboardSE-Regular", size: 20)
    let kEighth = CGFloat(1.0/8.0)
    let kHalf = CGFloat(1.0/2.0)
    let kFourteenth = CGFloat(1.0/14.0)
    let kSixteenth = CGFloat(1.0/16.0)
    let salePrice = 2
    let kNineteenth = CGFloat(1.0/19.0)
    
    //MARK: Properties: initial values
    
    var supplies = Supplies(aMoney: 10, aLemons: 0, aIceCubes: 0)
    let price = Price()
    
    var lemonsToPurchase = 0
    var iceCubesToPurchase = 0
    
    var lemonsToMix = 0
    var iceCubesToMix = 0
    
    var weatherArray: [[Int]] = [[5, 3, 4, 1], [14, 12, 10, 15], [22, 25, 27, 23]]
    var todaysWeather: [Int] = [0, 0, 0, 0]
    
    
    //end of day stats
    var customers: Int = 0
    var numberOfCustomersWeak = 0
    var numberOfCustomersStrong = 0
    var numberOfCustomersMid = 0
    var todaysProfit = 0
    var todaysMix = ""
    var glassesSoldToday = 0
    var todaysSpend = 0
    var theWeatherToday = ""
    
    //total stats
    var totalProfit = 0
    var dayNumber = 0
    var totalCustomers = 0
    var totalCustomersWeak = 0
    var totalCustomersStrong = 0
    var totalCustomersMid = 0
    var totalGlassesSold = 0
    
    //other controls
    var gameOverAlertController: UIAlertController?
    
    //MARK: Main functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.roundTheCorners()
        self.simulateWeatherToday()
        self.updateMainView()
        
    }
    
    //hide status bar
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //MARK: IBActions
    
    //Supplies Buttons
    @IBAction func unPurchaseLemonsButtonPressed(sender: UIButton) {
        print("un-purchase lemon pressed")
        if self.lemonsToPurchase > 0 {
            self.lemonsToPurchase -= 1
            self.supplies.money += self.price.lemon
            self.supplies.lemons -= 1
            self.todaysSpend -= self.price.lemon
            self.updateMainView()
        }
        else {
            showAlertWithText("Hold up", message: "You don't have any lemons to return")
        }
        
    }

    @IBAction func purchaseLemonsButtonPressed(sender: UIButton) {
        print("purchase lemon pressed")

        if self.supplies.money >= self.price.lemon {
            self.lemonsToPurchase += 1
            self.supplies.money -= self.price.lemon
            self.supplies.lemons += 1
            self.todaysSpend += self.price.lemon
            self.updateMainView()
        }
        else if (self.checkForGameOver()) {
            print("Game over")
            self.gameOverAlertView()
            
        }
        else {
            self.showAlertWithText("Its all about the money...", message: "You don't have enough money to buy that lemon!")
        }
        
    }
    
    @IBAction func unPurchaseCubesButtonPressed(sender: UIButton) {
        print("un purchase ice cubes pressed")
        if self.iceCubesToPurchase > 0 {
            self.iceCubesToPurchase -= 1
            self.supplies.money += self.price.iceCube
            self.supplies.iceCubes -= 1
            self.todaysSpend -= self.price.iceCube
            self.updateMainView()
        }
        else {
            showAlertWithText("Hold on..", message: "You don't have anyice cubes to return")
        }
        
    }
    
    @IBAction func purchaseCubesButtonPressed(sender: UIButton) {
        print("purchase ice cubes pressed")
        
        if self.supplies.money >= self.price.iceCube {
            self.iceCubesToPurchase += 1
            self.supplies.money -= self.price.iceCube
            self.supplies.iceCubes += 1
            self.todaysSpend += self.price.iceCube
            self.updateMainView()
        }
        else if (self.checkForGameOver()) {
           print ("Game Over")
            self.gameOverAlertView()
            
        }
        else {
            self.showAlertWithText("Ice, ice baby", message: "You don't have enough money to buy that ice cube!")
        }
        
    }
    
    //Mix Buttons
    @IBAction func removeLemonsFromMixButtonPressed(sender: UIButton) {
        print("remove lemons form mix pressed")
        if self.lemonsToMix > 0 {
            self.lemonsToPurchase = 0
            self.lemonsToMix -= 1
            self.supplies.lemons += 1
            self.updateMainView()
        }
        else {
            showAlertWithText(message: "No lemons to take out")
        }
     }
    
    @IBAction func addLemonsToMixButtonPressed(sender: UIButton) {
        print("add lemon to mix pressed")
        if self.supplies.lemons > 0 {
            self.lemonsToMix += 1
            self.lemonsToPurchase = 0
            self.supplies.lemons -= 1
            self.updateMainView()
        }
        else {
            self.showAlertWithText("Hey Lemon", message: "You need to buy more lemons")
        }
        
    }
    
    @IBAction func removeCubesFromMixButtonPressed(sender: UIButton) {
        print("remove cube from mix pressed")
        if self.iceCubesToMix > 0 {
            self.iceCubesToPurchase = 0
            self.iceCubesToMix -= 1
            self.supplies.iceCubes += 1
            self.updateMainView()
        }
        else {
            self.showAlertWithText(message: "No cubes to take out")
        }
        
    }
    
    @IBAction func addCubesToMixButtonPressed(sender: UIButton) {
        print("add cube to mix pressed")
        if self.supplies.iceCubes > 0 {
            self.iceCubesToPurchase = 0
            self.supplies.iceCubes -= 1
            self.iceCubesToMix += 1
            self.updateMainView()
        }
        else {
            showAlertWithText("No ice left", message: "You need to purchase more ice")
        }
        
    }
    
    //Start Day
    @IBAction func startDayButtonPressed(sender: UIButton) {
        print("Start day")
        
        //get ready for the day
        
        self.numberOfCustomersWeak = 0
        self.numberOfCustomersMid = 0
        self.numberOfCustomersStrong = 0
        self.todaysProfit = 0
        self.glassesSoldToday = 0
        
        //clear the views from memory if shown already
        if self.endOfGameSummaryView != nil {
            self.endOfGameSummaryView.removeFromSuperview()
        }
        
        if self.endOfDaySummaryView != nil {
            self.endOfDaySummaryView.removeFromSuperview()
        }
        
        //determine number of customers based on weather class (cold = lower number, hot = higher number)
        let numberOfCustomers = self.findAverage(self.todaysWeather)
        print("total number customers to pick from is \(numberOfCustomers)")
        
        self.customers = Int(arc4random_uniform(UInt32(abs(numberOfCustomers))) + 1)// +1 so can never have zero customers (breaks the loop below as I don't want zero customers)
        print("random number picked from pool of customers is \(self.customers)")
        
        if self.lemonsToMix == 0 || self.iceCubesToMix == 0 {
            self.showAlertWithText(message: "You need to add at least 1 lemon and 1 ice cube")
        }
        
        else {
            self.checkTasteVersusMix()
            
            //update UI to zero
            self.lemonsToPurchase = 0
            self.iceCubesToPurchase = 0
            self.lemonsToMix = 0
            self.iceCubesToMix = 0
            
            //add todays stats to total stats
            self.dayNumber += 1
            self.todaysProfit = (self.glassesSoldToday * self.salePrice) - self.todaysSpend
            self.totalProfit += self.todaysProfit
            self.totalCustomers += self.customers
            self.totalCustomersWeak += self.numberOfCustomersWeak
            self.totalCustomersMid += self.numberOfCustomersMid
            self.totalCustomersStrong += self.numberOfCustomersStrong
            self.totalGlassesSold += self.glassesSoldToday
            
            //update console view
            print("")
            print("number customers who preferred weak mix: \(self.numberOfCustomersWeak)")
            print("number customers who preferred strong mix: \(self.numberOfCustomersStrong)")
            print("number customers who preferred mid mix: \(self.numberOfCustomersMid)")
            print("")
            print("total profit today: \(self.todaysProfit)")
            print("Day Number: \(self.dayNumber)")
            
            //show the end of day view
            self.endOfDaySummary()
            
        }
        
    }
    
    //MARK: Helper Functions
    
    func updateMainView () {
        self.moneyLeftLabel.text = "\(supplies.money)"
        self.lemonsLeftLabel.text = "\(supplies.lemons)"
        self.cubesLeftLabel.text = "\(supplies.iceCubes)"
        
        self.numberLemonsPurchasedLabel.text = "\(lemonsToPurchase)"
        self.numberCubesPurchasedLabel.text = "\(iceCubesToPurchase)"
        
        self.numberLemonsInMixLabel.text = "\(lemonsToMix)"
        self.numberCubesInMixLabel.text = "\(iceCubesToMix)"
        
    }
    
    func showAlertWithText (header: String = "Warning", message: String) {
        
        let alert = UIAlertController(title: header, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil ))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    //Brain - mix versus customer taste
    func checkTasteVersusMix () {
        
        let lemonadeRatio = Double(lemonsToMix) / Double(iceCubesToMix)
        
        //get todays mix label ready
        if lemonadeRatio > 1 {
            self.todaysMix = "Strong"
        }
        else if lemonadeRatio == 1 {
            self.todaysMix = "Balanced"
        }
        else {
            self.todaysMix = "Weak"
        }
        
        for _ in 1...customers  {
            
            let customerTaste = Double(arc4random_uniform(UInt32(101))) / 100
            
            //count up who likes what for summary update
            if customerTaste < 0.4 {
                self.numberOfCustomersStrong += 1
            }
            else if customerTaste > 0.6 {
                self.numberOfCustomersWeak += 1
            }
            else {
                self.numberOfCustomersMid += 1
            }
            
            //compare to see if paid or not paid
            if customerTaste < 0.4 && lemonadeRatio > 1 {
                supplies.money += self.salePrice
                self.todaysProfit += 1
                self.glassesSoldToday += 1
                print("Customer preferred strong, mix was strong : PAID!")
            }
            else if customerTaste > 0.6 && lemonadeRatio < 1 {
                supplies.money += self.salePrice
                self.todaysProfit += 1
                self.glassesSoldToday += 1
                print("Customer preferred weak, mix was weak: PAID!")
            }
            else if customerTaste <= 0.6 && customerTaste >= 0.4 && lemonadeRatio == 1 {
                supplies.money += self.salePrice
                self.todaysProfit += 1
                self.glassesSoldToday += 1
                print("Customer preferred equal mix, mix was equal: PAID!")
            }
            else if customerTaste < 0.4 && lemonadeRatio < 1 {
                print("customer preferred strong but you made weak - no sell")
            }
            else if customerTaste > 0.6 && lemonadeRatio > 1 {
                print("customer preferred weak but you made strong - no sell")
            }
            else if customerTaste < 0.4 && lemonadeRatio == 1 {
                print("customer wanted strong but you made mid - no sell")
            }
            else if customerTaste > 0.6 && lemonadeRatio == 1 {
                print("customer wanted weak but you made mid - no sell")
            }
            else if customerTaste >= 0.4 && lemonadeRatio > 1 {
                print("customer preferred strong to mid but you made weak - no sell")
            }
            else if customerTaste > 0.4 && lemonadeRatio < 1 {
                print("customer wanted between strong & weak but you made weak - no sell")
            }
            else {
                print("customer taste: \(customerTaste), mix \(lemonadeRatio) final else evaluating")
            }
        }
    }
    
    func hardReset () {
        self.supplies = Supplies(aMoney: 10, aLemons: 0, aIceCubes: 0)
        //daily
        self.customers = 0
        self.numberOfCustomersWeak = 0
        self.numberOfCustomersStrong = 0
        self.numberOfCustomersMid = 0
        self.todaysProfit = 0
        self.glassesSoldToday = 0
        self.lemonsToPurchase = 0
        self.iceCubesToPurchase = 0
        
        
        //total
        self.totalCustomers = 0
        self.totalCustomersWeak = 0
        self.totalCustomersStrong = 0
        self.totalCustomersMid = 0
        self.totalProfit = 0
        self.dayNumber = 0
        self.totalGlassesSold = 0
        
        self.simulateWeatherToday()
        self.updateMainView()
        
    }
    
    //use this in the purchase button functions so you know when not enough left to play
    func checkForGameOver () -> Bool {
        
        if (supplies.lemons == 0 && supplies.money < price.lemon) || (supplies.iceCubes == 0 && supplies.money < price.iceCube) {
            return true
        }
        else {
            return false
        }
    }
    
    func roundTheCorners () {
        //round all the corner - buttons
        
        self.unPurchaseLemonButtonOutlet.layer.cornerRadius = 5
        self.purchaseLemonButtonOutlet.layer.cornerRadius = 5
        self.unPurchaseCubesButtonOutlet.layer.cornerRadius = 5
        self.purchaseCubesButtonOutlet.layer.cornerRadius = 5
        self.removeLemonsFromMixButtonOutlet.layer.cornerRadius = 5
        self.addLemonsToMixButtonOutlet.layer.cornerRadius = 5
        self.removeCubesFromMixButtonOutlet.layer.cornerRadius = 5
        self.addCubesToMixButtonOutlet.layer.cornerRadius = 5
        self.startDayButtonOutlet.layer.cornerRadius = 5
        
        //round the labels
        self.moneyLeftLabel.layer.cornerRadius = 10
        self.moneyLeftLabel.clipsToBounds = true
        self.lemonsLeftLabel.layer.cornerRadius = 10
        self.lemonsLeftLabel.clipsToBounds = true
        self.cubesLeftLabel.layer.cornerRadius = 10
        self.cubesLeftLabel.clipsToBounds = true
        self.weatherDesciptionLabel.layer.cornerRadius = 10
        self.weatherDesciptionLabel.clipsToBounds = true
        
        //round imageviews
        self.weatherImageView.layer.cornerRadius = 10
        self.moneyLeftImageView.layer.cornerRadius = 10
        self.lemonsLeftImageView.layer.cornerRadius = 10
        self.cubesLeftImageView.layer.cornerRadius = 10
        self.cubesLeftImageView.clipsToBounds = true
        self.purchaseLemonImageView.layer.cornerRadius = 10
        self.purchaseCubeImageView.layer.cornerRadius = 10
        self.purchaseCubeImageView.clipsToBounds = true
        self.mixLemonImageView.layer.cornerRadius = 10
        self.mixCubeLemonView.layer.cornerRadius = 10
        self.mixCubeLemonView.clipsToBounds = true
        
        self.containerTwoView.layer.cornerRadius = 10
        self.containerFourView.layer.cornerRadius = 10
    }
    
    
    //gameover put up an alert view to inform user the game is done
    func gameOverAlertView () {
        self.gameOverAlertController = UIAlertController(title: "Game Over", message: "Not enough supplies or cash, or both!", preferredStyle: UIAlertControllerStyle.Alert)
        let alertAction = UIAlertAction(title: "Summary", style: UIAlertActionStyle.Default) { (action) in
            print("Summary please")
            self.gameOverSummaryAndReset()
        }
        self.gameOverAlertController?.addAction(alertAction)
        self.presentViewController(self.gameOverAlertController!, animated: true, completion: nil)
    }

    
    //MARK: Summary & Game Over Summary Views
    func gameOverSummaryAndReset () {
        
        self.setUpGameOverViews()
        self.setUpGameOverLabels()
        
        //touch gesture to dismiss summary
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.handleTapGesture(_:)))
        self.endOfGameSummaryViewInner.addGestureRecognizer(tapGesture)
        
    }
    
    //handle the tap on game over summary so the view goes away nicely
    func handleTapGesture (tapGesture: (UITapGestureRecognizer)) {
        print("tap")
        
        //dismiss view
        UIView.animateWithDuration(0.5, delay: 0.0, options: [], animations: {
            self.endOfGameSummaryView.center = CGPoint(x: self.view.bounds.width * self.kHalf, y: self.endOfGameSummaryView.bounds.height + self.view.bounds.height)
            }, completion: nil)
        self.hardReset()
  
    }
    
    //handle tap gesture for end of day so end of day summary view goes away also clear todays spend
    func handleDayEndTapGesture (tapGesture: (UITapGestureRecognizer)) {
        print("tap")
        
        //dismiss view
        UIView.animateWithDuration(0.5, delay: 0.0, options: [], animations: {
            self.endOfDaySummaryView.center = CGPoint(x: self.view.bounds.width * self.kHalf, y: self.endOfDaySummaryView.bounds.height + self.view.bounds.height)
            }, completion: nil)
        self.todaysSpend = 0 //need to clear todays spend here as anywhere else doesn't work
        self.simulateWeatherToday()
        self.updateMainView()
    
    }
    
    
    func setUpGameOverViews () {
        //set up the views ready to animate
        self.endOfGameSummaryView = UIView(frame: CGRect(x: self.view.bounds.origin.x + 10, y: self.view.bounds.height + 100, width: self.view.bounds.width - 20, height: self.view.bounds.height * 0.6))
        self.endOfGameSummaryView.backgroundColor = kMainOrangeColour
        self.endOfGameSummaryView.layer.cornerRadius = 10
        self.view.addSubview(self.endOfGameSummaryView)
        
        //inner view sits on game over view
        self.endOfGameSummaryViewInner = UIView(frame: CGRect(x: self.view.bounds.origin.x + 20, y: self.view.bounds.origin.y + 20, width: self.endOfGameSummaryView.bounds.width - 40, height: self.endOfGameSummaryView.bounds.height - 40))
        self.endOfGameSummaryViewInner.backgroundColor = kMainYellowColour
        self.endOfGameSummaryViewInner.layer.cornerRadius = 10.0
        self.endOfGameSummaryView.addSubview(self.endOfGameSummaryViewInner)
        
        //animate the outer view the inner stuff will go with it
        UIView.animateWithDuration(2, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: [], animations: {
            self.endOfGameSummaryView.center = CGPoint(x: self.view.bounds.width * 0.5, y: self.view.bounds.height * 0.5)
            }, completion: nil)
        
    }
    
    
    func setUpGameOverLabels () {
        //add each label including title
        self.gameOverTitle = UILabel()
        self.gameOverTitle.text = "Game Over"
        self.gameOverTitle.textColor = kMainBlueColour
        self.gameOverTitle.font = UIFont(name: "ChalkboardSE-Regular", size: 25)
        self.gameOverTitle.sizeToFit()
        self.gameOverTitle.center = CGPoint(x: self.endOfGameSummaryViewInner.bounds.width * 0.5, y: self.endOfGameSummaryViewInner.bounds.origin.y + 20)
        self.gameOverTitle.textAlignment = NSTextAlignment.Center
        self.endOfGameSummaryViewInner.addSubview(self.gameOverTitle)
        
        self.youLastedLabel = UILabel()
        if self.dayNumber == 1 {
            self.youLastedLabel.text = "You lasted for \(self.dayNumber) day"
        }
        else {
            self.youLastedLabel.text = "You lasted for \(self.dayNumber) days"
        }
        self.youLastedLabel.textColor = kMainBlueColour
        self.youLastedLabel.font = kSummaryViewFont
        self.youLastedLabel.sizeToFit()
        self.youLastedLabel.center = CGPoint(x: self.view.bounds.width + 150, y: self.endOfGameSummaryViewInner.bounds.height * (kEighth * 2))
        self.youLastedLabel.textAlignment = NSTextAlignment.Left
        self.endOfGameSummaryViewInner.addSubview(self.youLastedLabel)
        
        
        self.youHadCustomersLabel = UILabel()
        self.youHadCustomersLabel.text = "You had a total of \(self.totalCustomers) customers"
        self.youHadCustomersLabel.textColor = kMainBlueColour
        self.youHadCustomersLabel.font = kSummaryViewFont
        self.youHadCustomersLabel.sizeToFit()
        self.youHadCustomersLabel.center = CGPoint(x: self.view.bounds.width + 150, y: self.endOfGameSummaryViewInner.bounds.height * (kEighth * 3))
        self.youHadCustomersLabel.textAlignment = NSTextAlignment.Left
        self.endOfGameSummaryViewInner.addSubview(self.youHadCustomersLabel)
        
        self.youSoldGlassesLabel = UILabel()
        self.youSoldGlassesLabel.text = "You sold \(self.totalGlassesSold) glasses"
        self.youSoldGlassesLabel.textColor = kMainBlueColour
        self.youSoldGlassesLabel.font = kSummaryViewFont
        self.youSoldGlassesLabel.sizeToFit()
        self.youSoldGlassesLabel.center = CGPoint(x: self.view.bounds.width + 150, y: self.endOfGameSummaryViewInner.bounds.height * (kEighth * 4))
        self.youSoldGlassesLabel.textAlignment = NSTextAlignment.Left
        self.endOfGameSummaryViewInner.addSubview(self.youSoldGlassesLabel)
        
        self.youMadeProfitLabel = UILabel()
        if self.totalProfit >= 0 {
           self.youMadeProfitLabel.text = "You made a total of $\(self.totalProfit) profit"
        }
        else {
            self.youMadeProfitLabel.text = "You made a loss of $\(abs(self.totalProfit))"
        }
        self.youMadeProfitLabel.textColor = kMainBlueColour
        self.youMadeProfitLabel.font = kSummaryViewFont
        self.youMadeProfitLabel.sizeToFit()
        self.youMadeProfitLabel.center = CGPoint(x: self.view.bounds.width + 150, y: self.endOfGameSummaryViewInner.bounds.height * (kEighth * 5))
        self.youMadeProfitLabel.textAlignment = NSTextAlignment.Left
        self.endOfGameSummaryViewInner.addSubview(self.youMadeProfitLabel)
        
        //then animate the labels
        UIView.animateWithDuration(1.5, delay: 2.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: [], animations: {
            self.youLastedLabel.center = CGPoint(x: self.endOfGameSummaryViewInner.bounds.width * self.kHalf , y: self.endOfGameSummaryViewInner.bounds.height * (self.kEighth * 2))
            }, completion: nil)
        
        UIView.animateWithDuration(1.5, delay: 2.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: [], animations: {
            self.youHadCustomersLabel.center = CGPoint(x: self.endOfGameSummaryViewInner.bounds.width * self.kHalf, y: self.endOfGameSummaryViewInner.bounds.height * (self.kEighth * 3))
            }, completion: nil)
        
        UIView.animateWithDuration(1.5, delay: 3.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: [], animations: {
            self.youSoldGlassesLabel.center = CGPoint(x: self.endOfGameSummaryViewInner.bounds.width * self.kHalf, y: self.endOfGameSummaryViewInner.bounds.height * (self.kEighth * 4))
            }, completion: nil)
        
        UIView.animateWithDuration(1.5, delay: 3.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: [], animations: {
            self.youMadeProfitLabel.center = CGPoint(x: self.endOfGameSummaryViewInner.bounds.width * self.kHalf, y: self.endOfGameSummaryViewInner.bounds.height * (self.kEighth * 5))
            }, completion: nil)
        
    }
    
    func endOfDaySummary() {
        self.setUpDailyReportViews()
        self.setUpDailyReportLabels()
        
        //touch to dismiss or a button to dismiss ready for next day
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.handleDayEndTapGesture(_:)))
        self.endOfDaySummaryViewInner.addGestureRecognizer(tapGesture)
        
        
    }
    
    func setUpDailyReportViews() {
        //set up outer view
        self.endOfDaySummaryView = UIView(frame: CGRect(x: self.view.bounds.origin.x + 10, y: self.view.bounds.height + 100, width: self.view.bounds.width - 20, height: self.view.bounds.height * 0.6))
        self.endOfDaySummaryView.backgroundColor = kMainOrangeColour
        self.endOfDaySummaryView.layer.cornerRadius = 10
        self.view.addSubview(self.endOfDaySummaryView)
        
        //inner view sits on outer view
        self.endOfDaySummaryViewInner = UIView(frame: CGRect(x: self.view.bounds.origin.x + 20, y: self.view.bounds.origin.y + 20, width: self.endOfDaySummaryView.bounds.width - 40, height: self.endOfDaySummaryView.bounds.height - 40))
        self.endOfDaySummaryViewInner.backgroundColor = kMainYellowColour
        self.endOfDaySummaryViewInner.layer.cornerRadius = 10.0
        self.endOfDaySummaryView.addSubview(self.endOfDaySummaryViewInner)
        
        //animate the outer view the inner stuff will go with it
        UIView.animateWithDuration(1.5, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: [], animations: {
            self.endOfDaySummaryView.center = CGPoint(x: self.view.bounds.width * 0.5, y: self.view.bounds.height * 0.5)
            }, completion: nil)
        
    }
    
    func setUpDailyReportLabels() {
        //add each label
        self.dailyReportTitle = UILabel()
        self.dailyReportTitle.text = "Day \(self.dayNumber) is done"
        self.dailyReportTitle.textColor = UIColor.blackColor()
        self.dailyReportTitle.font = UIFont(name: "ChalkboardSE-Regular", size: 25)
        self.dailyReportTitle.sizeToFit()
        self.dailyReportTitle.center = CGPoint(x: self.endOfDaySummaryViewInner.bounds.width * self.kHalf, y: self.endOfDaySummaryViewInner.bounds.origin.y + 15)
        self.dailyReportTitle.textAlignment = NSTextAlignment.Center
        self.endOfDaySummaryViewInner.addSubview(self.dailyReportTitle)
        
        self.weatherTodayLabel = UILabel()
        self.weatherTodayLabel.text = "The weather today was \(self.theWeatherToday)"
        self.weatherTodayLabel.textColor = kMainBlueColour
        self.weatherTodayLabel.font = kSummaryViewFont
        self.weatherTodayLabel.sizeToFit()
        self.weatherTodayLabel.center = CGPoint(x: self.view.bounds.width + 100, y: self.endOfDaySummaryViewInner.bounds.height * (kNineteenth * 2) + 5)
        self.endOfDaySummaryViewInner.addSubview(self.weatherTodayLabel)

        self.numberOfCustomersTodayLabel = UILabel()
        if self.customers == 1 {
            self.numberOfCustomersTodayLabel.text = "You had \(self.customers) customer today"
        }
        else {
            self.numberOfCustomersTodayLabel.text = "You had \(self.customers) customers today"
        }
        self.numberOfCustomersTodayLabel.textColor = kMainBlueColour
        self.numberOfCustomersTodayLabel.font = kSummaryViewFont
        self.numberOfCustomersTodayLabel.sizeToFit()
        self.numberOfCustomersTodayLabel.center = CGPoint(x: self.view.bounds.width + 100, y: self.endOfDaySummaryViewInner.bounds.height * (kNineteenth * 4))
        self.numberOfCustomersTodayLabel.textAlignment = NSTextAlignment.Center
        self.endOfDaySummaryViewInner.addSubview(self.numberOfCustomersTodayLabel)
        
        self.numberGlassesSoldLabel = UILabel()
        if self.glassesSoldToday == 1 {
            self.numberGlassesSoldLabel.text = "You sold \(self.glassesSoldToday) glass"
        }
        else {
            self.numberGlassesSoldLabel.text = "You sold \(self.glassesSoldToday) glasses"
        }
        self.numberGlassesSoldLabel.textColor = kMainBlueColour
        self.numberGlassesSoldLabel.font = kSummaryViewFont
        self.numberGlassesSoldLabel.sizeToFit()
        self.numberGlassesSoldLabel.center = CGPoint(x: self.view.bounds.width + 100, y: self.endOfDaySummaryViewInner.bounds.height * (self.kNineteenth * 6))
        self.numberGlassesSoldLabel.textAlignment = NSTextAlignment.Center
        self.endOfDaySummaryViewInner.addSubview(self.numberGlassesSoldLabel)
        
        self.typeLemonadeMadeTodayLabel = UILabel()
        self.typeLemonadeMadeTodayLabel.text = "Your mix today was \(self.todaysMix)"
        self.typeLemonadeMadeTodayLabel.textColor = kMainBlueColour
        self.typeLemonadeMadeTodayLabel.font = kSummaryViewFont
        self.typeLemonadeMadeTodayLabel.sizeToFit()
        self.typeLemonadeMadeTodayLabel.center = CGPoint(x: self.view.bounds.width + 100, y: self.endOfDaySummaryViewInner.bounds.height * (self.kNineteenth * 8))
        self.typeLemonadeMadeTodayLabel.textAlignment = NSTextAlignment.Center
        self.endOfDaySummaryViewInner.addSubview(self.typeLemonadeMadeTodayLabel)
        
        self.numberCustomerLikedStrongTodayLabel = UILabel()
        if self.numberOfCustomersStrong == 1 {
            self.numberCustomerLikedStrongTodayLabel.text = "\(self.numberOfCustomersStrong) customer liked it strong"
        }
        else {
             self.numberCustomerLikedStrongTodayLabel.text = "\(self.numberOfCustomersStrong) customers liked it strong"
        }
        self.numberCustomerLikedStrongTodayLabel.textColor = kMainBlueColour
        self.numberCustomerLikedStrongTodayLabel.font = kSummaryViewFont
        self.numberCustomerLikedStrongTodayLabel.sizeToFit()
        self.numberCustomerLikedStrongTodayLabel.center = CGPoint(x: self.view.bounds.width + 100, y: self.endOfDaySummaryViewInner.bounds.height * (kNineteenth * 10))
        self.numberCustomerLikedStrongTodayLabel.textAlignment = NSTextAlignment.Center
        self.endOfDaySummaryViewInner.addSubview(self.numberCustomerLikedStrongTodayLabel)
        
        self.numberCustomersLikedWeakTodayLabel = UILabel()
        if self.numberOfCustomersWeak == 1 {
           self.numberCustomersLikedWeakTodayLabel.text = "\(self.numberOfCustomersWeak) customer liked it weak"
        }
        else {
            self.numberCustomersLikedWeakTodayLabel.text = "\(self.numberOfCustomersWeak) customers liked it weak"
        }
        self.numberCustomersLikedWeakTodayLabel.textColor = kMainBlueColour
        self.numberCustomersLikedWeakTodayLabel.font = kSummaryViewFont
        self.numberCustomersLikedWeakTodayLabel.sizeToFit()
        self.numberCustomersLikedWeakTodayLabel.center = CGPoint(x: self.view.bounds.width + 100, y: self.endOfDaySummaryViewInner.bounds.height * (kNineteenth * 12))
        self.numberCustomersLikedWeakTodayLabel.textAlignment = NSTextAlignment.Center
        self.endOfDaySummaryViewInner.addSubview(self.numberCustomersLikedWeakTodayLabel)
        
        self.numberCustomersLikedBalancedTodayLabel = UILabel()
        if self.numberOfCustomersMid == 1 {
            self.numberCustomersLikedBalancedTodayLabel.text = "\(self.numberOfCustomersMid) customer liked it balanced"
        }
        else {
            self.numberCustomersLikedBalancedTodayLabel.text = "\(self.numberOfCustomersMid) customers liked it balanced"
        }
        self.numberCustomersLikedBalancedTodayLabel.textColor = kMainBlueColour
        self.numberCustomersLikedBalancedTodayLabel.font = kSummaryViewFont
        self.numberCustomersLikedBalancedTodayLabel.sizeToFit()
        self.numberCustomersLikedBalancedTodayLabel.center = CGPoint(x: self.view.bounds.width + 100, y: self.endOfDaySummaryViewInner.bounds.height * (kNineteenth * 14))
        self.numberCustomersLikedBalancedTodayLabel.textAlignment = NSTextAlignment.Center
        self.endOfDaySummaryViewInner.addSubview(self.numberCustomersLikedBalancedTodayLabel)
        
        self.totalProfitLabel = UILabel()
        if self.todaysProfit >= 0 {
            self.totalProfitLabel.text = "Today you made $\(self.todaysProfit) profit"
        }
        else {
            self.totalProfitLabel.text = "Today you made a loss of $\(abs(self.todaysProfit))"
        }
        self.totalProfitLabel.textColor = kMainBlueColour
        self.totalProfitLabel.font = kSummaryViewFont
        self.totalProfitLabel.sizeToFit()
        self.totalProfitLabel.center = CGPoint(x: self.view.bounds.width + 100, y: self.endOfDaySummaryViewInner.bounds.height * (kNineteenth * 16))
        self.totalProfitLabel.textAlignment = NSTextAlignment.Center
        self.endOfDaySummaryViewInner.addSubview(self.totalProfitLabel)
        
        
        //animate
        
        UIView.animateWithDuration(1.5, delay: 1.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: [], animations: {
            self.weatherTodayLabel.center = CGPoint(x: self.endOfDaySummaryViewInner.bounds.width * self.kHalf, y: self.endOfDaySummaryViewInner.bounds.height * (self.kNineteenth * 2) + 5)
            }, completion: nil)
        
        UIView.animateWithDuration(1.5, delay: 2.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: [], animations: {
            self.numberOfCustomersTodayLabel.center = CGPoint(x: self.endOfDaySummaryViewInner.bounds.width * self.kHalf, y: self.endOfDaySummaryViewInner.bounds.height * (self.kNineteenth * 4))
            }, completion: nil)
        
        UIView.animateWithDuration(1.5, delay: 2.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: [], animations: {
           self.numberGlassesSoldLabel.center = CGPoint(x: self.endOfDaySummaryViewInner.bounds.width * self.kHalf, y: self.endOfDaySummaryViewInner.bounds.height * (self.kNineteenth * 6))
            }, completion: nil)
        
        UIView.animateWithDuration(1.5, delay: 3.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: [], animations: {
            self.typeLemonadeMadeTodayLabel.center = CGPoint(x: self.endOfDaySummaryViewInner.bounds.width * self.kHalf, y: self.endOfDaySummaryViewInner.bounds.height * (self.kNineteenth * 8))
            }, completion: nil)
        
        UIView.animateWithDuration(1.5, delay: 3.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: [], animations: {
            self.numberCustomerLikedStrongTodayLabel.center = CGPoint(x: self.endOfDaySummaryViewInner.bounds.width * self.kHalf, y: self.endOfDaySummaryViewInner.bounds.height * (self.kNineteenth * 10))
            }, completion: nil)
        
        UIView.animateWithDuration(1.5, delay: 4.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: [], animations: {
            self.numberCustomersLikedWeakTodayLabel.center = CGPoint(x: self.endOfDaySummaryViewInner.bounds.width * self.kHalf, y: self.endOfDaySummaryViewInner.bounds.height * (self.kNineteenth * 12))
            }, completion: nil)
        
        UIView.animateWithDuration(1.5, delay: 4.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: [], animations: {
             self.numberCustomersLikedBalancedTodayLabel.center = CGPoint(x: self.endOfDaySummaryViewInner.bounds.width * self.kHalf, y: self.endOfDaySummaryViewInner.bounds.height * (self.kNineteenth * 14))
            }, completion: nil)

        UIView.animateWithDuration(1.5, delay: 5.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: [], animations: {
            self.totalProfitLabel.center = CGPoint(x: self.endOfDaySummaryViewInner.bounds.width * self.kHalf, y: self.endOfDaySummaryViewInner.bounds.height * (self.kNineteenth * 16))
            }, completion: nil)
        
    }
    
    
    //MARK: Weather
    //note could have put this into another class and called e.g.
    //Weather.simulateWeatherToday()
    
     func simulateWeatherToday () -> [Int] {
        
        let index = Int(arc4random_uniform(UInt32(weatherArray.count)))
        todaysWeather = weatherArray[index]
        
        switch index {
        case 0:
            print("Cold")
            self.weatherImageView.image = UIImage(named: "coldIcon")
            self.weatherDesciptionLabel.text = "Cold"
            self.theWeatherToday = "Cold"
            self.weatherDesciptionLabel.backgroundColor = UIColor(red: 91/255, green: 249/255, blue: 255/255, alpha: 1.0)
            
        case 1:
            print("Medium")
            self.weatherImageView.image = UIImage(named: "mildIcon")
            self.weatherDesciptionLabel.text = "Mild"
            self.theWeatherToday = "Mild"
            self.weatherDesciptionLabel.backgroundColor = UIColor.yellowColor()
            
        case 2:
            print("Warm")
            self.weatherImageView.image = UIImage(named: "warmIcon")
            self.weatherDesciptionLabel.text = "Warm"
            self.theWeatherToday = "Warm"
            self.weatherDesciptionLabel.backgroundColor = UIColor.orangeColor()
            
        default:
            print("Default fired")
            
        }
        return todaysWeather
        
    }
    
    //this function will find the average of ANYTHING not linked to the weather stuff
     func findAverage (data: [Int]) -> Int {
        var sum = 0
        for x in data {
            sum += x
        }
        
        let average: Double = Double(sum) / Double(data.count)
        let rounded: Int = Int(ceil(average))
        
        return rounded
        
    }

    
    
    
}

