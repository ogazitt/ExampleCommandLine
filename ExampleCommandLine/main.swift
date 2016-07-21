//
//  main.swift
//  ExampleCommandLine
//
//  Created by Omri Gazitt on 7/20/16.
//  Copyright © 2016 Omri Gazitt. All rights reserved.
//

import Foundation

var contentsOptional : String?
contentsOptional = try? String(contentsOfFile: "/Users/Omri/Swift/homework/ExampleCommandLine/TextFile.csv")

// check for bad file and initialize string anyway
if contentsOptional == nil {
    print("Bad File")
    contentsOptional = "Shipment Type,Weight (t)\nNeptune Fuel,6\nNeptune Fuel,5\nNeptune Fuel,6\nNeptune Fuel,4\nMars Food,3\nNeptune Fuel,10\nMars Food,3\nNeptune Fuel,6\nMars Food,10\nNeptune Fuel,8\nMars Food,7\nMars Food,2\nMars Food,9\nNeptune Fuel,5\nNeptune Fuel,7\nMars Food,8\nMars Food,7\nMars Food,9\n"
}

// get contents as non-optional string
var contents : String = contentsOptional!

var mars = 0; var neptune = 0; var lineCount = 0

print("Using enumerateLines closure")
contents.enumerateLines() { (line, stop) -> () in

    // skip first iteration
    if lineCount != 0 {
        
        // split key, value pair
        var keyVal = line.componentsSeparatedByString(",")
        
        // make sure both key and value exist
        if keyVal.count == 2 {
            
            // get the value
            var value : Int = Int(keyVal[1])!
            
            switch keyVal[0] {
            case "Mars Food":
                mars += value
            case "Neptune Fuel":
                neptune += value
            default:
                print("A value is neither Mars Food nor Neptune Fuel")
                exit(1)
            }
        }
    }
    lineCount += 1
    
}
print("Mars Food: \(mars)\nNeptune Fuel: \(neptune)\n")

print("Using filter and reduce")
var lineArray = contents.componentsSeparatedByString("\n")
lineArray.removeAtIndex(0)
var marsArray = lineArray.filter {
    $0.componentsSeparatedByString(",")[0] == "Mars Food"
}
var neptuneArray = lineArray.filter {
    $0.componentsSeparatedByString(",")[0] == "Neptune Fuel"
}
print("Mars Food: ", marsArray.reduce(0) {
    Int($1.componentsSeparatedByString(",")[1])! + $0
})
print("Neptune Fuel: ", neptuneArray.reduce(0) {
    Int($1.componentsSeparatedByString(",")[1])! + $0
})
