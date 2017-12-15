//
//  ViewController.swift
//  SMSquareDrawing
//
//  Created by SunilMaurya on 15/12/17.
//  Copyright © 2017 SunilMaurya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //IBOutlet
    @IBOutlet weak var welcomeLabel: UILabel!
    
    //Device width & height
    let deviceWidth = UIScreen.main.bounds.size.width
    let deviceHeight = UIScreen.main.bounds.size.height
    
    /*
     * This contains all the drawn area
     */
    var restrictedPoint = [(x1:CGFloat,y1:CGFloat,width:CGFloat,height:CGFloat)]()
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //MARK:- Helper method
    fileprivate func showAlertIfScreenFilledWithBox() {
        let alertController = UIAlertController(title: "Software Merchant", message:
            "Your screen has been filled with square.", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK:- TapGesure Action
    @IBAction func tapGestureAction(_ sender: Any) {
        //hiding welcome label
        if !self.welcomeLabel.isHidden {
            self.welcomeLabel.isHidden = true
        }
        
        if let tapGesture = sender as? UITapGestureRecognizer {
            //calculating area of device
            let areaOfDevice = deviceWidth * deviceHeight
            var allBoxesArea:CGFloat = 0
            for value in restrictedPoint {//calculating area of already drawn square
                let squareArea = value.width * value.height
                allBoxesArea = allBoxesArea + squareArea
            }
            if allBoxesArea >= areaOfDevice {//if device filled with square
                showAlertIfScreenFilledWithBox()
            }
            
            let tappedPoint = tapGesture.location(in: self.view)
            var x1 = floor(tappedPoint.x)
            var y1 = floor(tappedPoint.y)
            var x2 = floor(tappedPoint.x)
            var y2 = floor(tappedPoint.y)
            
            //check for if tapped area is already in restricted area
            for value in restrictedPoint {
                let square = CGRect(x: value.x1, y: value.y1, width: value.width, height: value.height)
                if square.contains(tappedPoint) {
                    print("clicked point already has drawn box...")
                    return
                }
            }
            
            //moving for finding stop
            while ((x1 > 0) && (y1 > 0) && (x2 < deviceWidth) && (y2 < deviceHeight)) {
                var willStop = false
                for value in restrictedPoint {
                    let square = CGRect(x: value.x1, y: value.y1, width: value.width, height: value.height)
                    let point1 = CGPoint(x: x1, y: y1)
                    let point2 = CGPoint(x: x2, y: y2)
                    if square.contains(point1) || square.contains(point2) {
                        print("overlapped...")
                        willStop = true
                        break
                    }
                }
                if !willStop {//If not overlapping then moving next
                    x1 = x1 - 1
                    y1 = y1 - 1
                    x2 = x2 + 1
                    y2 = y2 + 1
                } else { // if overlapped
                    break
                }
            }
            
            //adding area in restricted point
            restrictedPoint.append((x1: x1, y1: y1, width: x2-x1, height: y2-y1))
            
            //drawing square
            let draw = DrawableView(frame: CGRect(x: x1, y: y1, width: x2-x1, height: y2-y1))
            self.view.addSubview(draw)
        }
    }

}

