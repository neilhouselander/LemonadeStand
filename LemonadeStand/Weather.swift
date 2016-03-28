//
//  Weather.swift
//  LemonadeStand
//
//  Created by Neil Houselander on 28/03/2016.
//  Copyright © 2016 Neil Houselander. All rights reserved.
//

import Foundation

class Weather {
   
    

    
    class func simulateWeatherToday () -> [Int] {
        var weatherArray: [[Int]] = [[-1, -2, -4, 0], [14, 8, 10, 9], [22, 25, 27, 23]]
        var todaysWeather: [Int] = [0, 0, 0, 0]
        
        let index = Int(arc4random_uniform(UInt32(weatherArray.count)))
        todaysWeather = weatherArray[index]
        
        switch index {
        case 0: print("Cold")
        case 1: print("Medium")
        case 2: print("Warm")
        default: print("Default fired")
            
        }
        return todaysWeather
        
    }
    
    class func findAverage (data: [Int]) -> Int {
        var sum = 0
        for x in data {
            sum += x
        }
        
        let average: Double = Double(sum) / Double(data.count)
        let rounded: Int = Int(ceil(average))
        
        return rounded
        
    }
    
    class func customersToday () -> Int {
        let arrayToAverage = self.simulateWeatherToday()
        let average = abs(findAverage(arrayToAverage))
        print("Average temp today \(average)")
        return average
        
    }
    
    
    
    
}
