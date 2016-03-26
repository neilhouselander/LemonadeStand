//
//  ViewController.swift
//  LemonadeStand
//
//  Created by Neil Houselander on 14/03/2016.
//  Copyright © 2016 Neil Houselander. All rights reserved.
//


// NEIL DO NEXT



//daily report views
//daily report labels set up
//daily report labels animation
//add these functions to game
//ideally game over test triggers an alert which when dismissed gives summary



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
    let kSummaryViewFont = UIFont(name: "MarkerFelt-Wide", size: 20)
    let kEighth = CGFloat(1.0/8.0)
    let kHalf = CGFloat(1.0/2.0)
    
    //MARK: Properties: initial values
    
    var supplies = Supplies(aMoney: 10, aLemons: 1, aIceCubes: 1)
    let price = Price()
    
    var lemonsToPurchase = 0
    var iceCubesToPurchase = 0
    
    var lemonsToMix = 0
    var iceCubesToMix = 0
    
    //end of day stats
    var customers: Int = 0
    var numberOfCustomersWeak = 0
    var numberOfCustomersStrong = 0
    var numberOfCustomersMid = 0
    var todaysProfit = 0
    var todaysMix = ""
    var glassesSoldToday = 0
    
    //total stats
    var totalProfit = 0
    var dayNumber = 0
    var totalCustomers = 0
    var totalCustomersWeak = 0
    var totalCustomersStrong = 0
    var totalCustomersMid = 0
    var totalGlassesSold = 0
    
    
    
    
    //MARK: Main functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.roundTheCorners()
        
        self.updateMainView()
        
        //self.gameOverSummaryAndReset()
        
        
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
            self.updateMainView()
        }
        else if (self.checkForGameOver()) {
            print("Game over")
            self.gameOverSummaryAndReset()
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
            self.updateMainView()
        }
        else if (self.checkForGameOver()) {
           print ("Game Over")
            self.gameOverSummaryAndReset()
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
        self.dayNumber += 1
        
        if self.endOfGameSummaryView != nil {
            self.endOfGameSummaryView.removeFromSuperview()
        }
        
        
        self.customers = Int(arc4random_uniform(UInt32(kMaxNumberOfCustomers)) + 1)
        
        self.numberOfCustomersWeak = 0
        self.numberOfCustomersMid = 0
        self.numberOfCustomersStrong = 0
        self.todaysProfit = 0
        self.glassesSoldToday = 0
        
        
        if self.customers == 1 {
            print("Just \(customers) customer today")
         }
        else {
            print("You had \(customers) customers today")
        }
                
        if self.lemonsToMix == 0 || self.iceCubesToMix == 0 {
            self.showAlertWithText(message: "You need to add at least 1 lemon and 1 ice cube")
        }
        
        else {
            self.checkTasteVersusMix()
            
            print("number customers who preferred weak mix: \(self.numberOfCustomersWeak)")
            print("number customers who preferred strong mix: \(self.numberOfCustomersStrong)")
            print("number customers who preferred mid mix: \(self.numberOfCustomersMid)")
            print("")
            print("total profit today: \(self.todaysProfit)")
            print("Day Number: \(self.dayNumber)")
            
            //update UI to zero
            self.lemonsToPurchase = 0
            self.iceCubesToPurchase = 0
            self.lemonsToMix = 0
            self.iceCubesToMix = 0
            
            self.updateMainView()
        }
        //add todays stats to total stats
        self.totalProfit += self.todaysProfit
        self.totalCustomers += self.customers
        self.totalCustomersWeak += self.numberOfCustomersWeak
        self.totalCustomersMid += self.numberOfCustomersMid
        self.totalCustomersStrong += self.numberOfCustomersStrong
        print("Total profit so far: \(self.totalProfit)")
        self.totalGlassesSold += self.glassesSoldToday
        
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
                supplies.money += 1
                self.todaysProfit += 1
                self.glassesSoldToday += 1
                print("Customer preferred strong, mix was strong : Paid")
            }
            else if customerTaste > 0.6 && lemonadeRatio < 1 {
                supplies.money += 1
                self.todaysProfit += 1
                self.glassesSoldToday += 1
                print("Customer preferred weak, mix was weak: Paid")
            }
            else if customerTaste <= 0.6 && customerTaste >= 0.4 && lemonadeRatio == 1 {
                supplies.money += 1
                self.todaysProfit += 1
                self.glassesSoldToday += 1
                print("Customer preferred equal mix, mix was equal: Paid")
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
        self.supplies = Supplies(aMoney: 10, aLemons: 1, aIceCubes: 1)
        self.customers = 0
        self.numberOfCustomersWeak = 0
        self.numberOfCustomersStrong = 0
        self.numberOfCustomersMid = 0
        self.todaysProfit = 0
        self.totalProfit = 0
        self.dayNumber = 0
        self.totalGlassesSold = 0
        
        self.updateMainView()
        
    }
    
    func checkForGameOver () -> Bool {
        
        if (supplies.lemons == 0 && supplies.money < price.lemon) || (supplies.iceCubes == 0 && supplies.money < price.iceCube) {
            return true
        }
        else {
            return false
        }
    }
    
    func gameOverSummaryAndReset () {
        //trigger modal?
        self.setUpGameOverViews()
        self.setUpGameOverLabels()
        
        //reset button or touch gesture?
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.handleTapGesture(_:)))
        self.endOfGameSummaryViewInner.addGestureRecognizer(tapGesture)
        
 
        
    }
    
    func handleTapGesture (tapGesture: (UITapGestureRecognizer)) {
        print("tap")
        //dismiss view
        UIView.animateWithDuration(0.5, delay: 0.0, options: [], animations: {
            self.endOfGameSummaryView.center = CGPoint(x: self.view.bounds.width * self.kHalf, y: self.endOfGameSummaryView.bounds.height + self.view.bounds.height)
            }, completion: nil)
        self.hardReset()
        

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
        self.gameOverTitle.font = UIFont(name: "MarkerFelt-Wide", size: 25)
        self.gameOverTitle.sizeToFit()
        self.gameOverTitle.center = CGPoint(x: self.endOfGameSummaryViewInner.bounds.width * 0.5, y: self.endOfGameSummaryViewInner.bounds.origin.y + 20)
        self.gameOverTitle.textAlignment = NSTextAlignment.Center
        self.endOfGameSummaryViewInner.addSubview(self.gameOverTitle)
        
        self.youLastedLabel = UILabel()
        self.youLastedLabel.text = "You lasted for \(self.dayNumber) days"
        self.youLastedLabel.textColor = kMainBlueColour
        self.youLastedLabel.font = kSummaryViewFont
        self.youLastedLabel.sizeToFit()
        //self.youLastedLabel.center = CGPoint(x: self.endOfGameSummaryViewInner.bounds.width * kHalf , y: self.endOfGameSummaryViewInner.bounds.height * (kEighth * 2))
        self.youLastedLabel.center = CGPoint(x: self.view.bounds.width + 100, y: self.endOfGameSummaryViewInner.bounds.height * (kEighth * 2))
        self.youLastedLabel.textAlignment = NSTextAlignment.Left
        self.endOfGameSummaryViewInner.addSubview(self.youLastedLabel)
        
        self.youHadCustomersLabel = UILabel()
        self.youHadCustomersLabel.text = "You had a total of \(self.totalCustomers) customers"
        self.youHadCustomersLabel.textColor = kMainBlueColour
        self.youHadCustomersLabel.font = kSummaryViewFont
        self.youHadCustomersLabel.sizeToFit()
        //self.youHadCustomersLabel.center = CGPoint(x: self.endOfGameSummaryViewInner.bounds.width * kHalf, y: self.endOfGameSummaryViewInner.bounds.height * (kEighth * 3))
        self.youHadCustomersLabel.center = CGPoint(x: self.view.bounds.width + 100, y: self.endOfGameSummaryViewInner.bounds.height * (kEighth * 3))
        self.youHadCustomersLabel.textAlignment = NSTextAlignment.Left
        self.endOfGameSummaryViewInner.addSubview(self.youHadCustomersLabel)
        
        self.youSoldGlassesLabel = UILabel()
        self.youSoldGlassesLabel.text = "You sold \(self.totalGlassesSold) glasses"
        self.youSoldGlassesLabel.textColor = kMainBlueColour
        self.youSoldGlassesLabel.font = kSummaryViewFont
        self.youSoldGlassesLabel.sizeToFit()
        //self.youSoldGlassesLabel.center = CGPoint(x: self.endOfGameSummaryViewInner.bounds.width * kHalf, y: self.endOfGameSummaryViewInner.bounds.height * (kEighth * 4))
        self.youSoldGlassesLabel.center = CGPoint(x: self.view.bounds.width + 100, y: self.endOfGameSummaryViewInner.bounds.height * (kEighth * 4))
        self.youSoldGlassesLabel.textAlignment = NSTextAlignment.Left
        self.endOfGameSummaryViewInner.addSubview(self.youSoldGlassesLabel)
        
        self.youMadeProfitLabel = UILabel()
        self.youMadeProfitLabel.text = "You made a total of $\(self.totalProfit) profit"
        self.youMadeProfitLabel.textColor = kMainBlueColour
        self.youMadeProfitLabel.font = kSummaryViewFont
        self.youMadeProfitLabel.sizeToFit()
        //self.youMadeProfitLabel.center = CGPoint(x: self.endOfGameSummaryViewInner.bounds.width * kHalf, y: self.endOfGameSummaryViewInner.bounds.height * (kEighth * 5))
        self.youMadeProfitLabel.center = CGPoint(x: self.view.bounds.width + 100, y: self.endOfGameSummaryViewInner.bounds.height * (kEighth * 5))
        self.youMadeProfitLabel.textAlignment = NSTextAlignment.Left
        self.endOfGameSummaryViewInner.addSubview(self.youMadeProfitLabel)
        
        //then animate
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
        
        
    }
    
    func setUpDailyReportViews() {
        //set up outer view
        //set up inner view
        //animate outer view
        
        
        
    }
    
    func setUpDailyReportLabels() {
        //add each label
        //animate
        
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
    
    
    
    
}

