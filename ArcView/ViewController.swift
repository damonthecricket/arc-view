//
//  ViewController.swift
//  ArcView
//
//  Created by Damon Cricket on 18.09.2019.
//  Copyright © 2019 DC. All rights reserved.
//

import UIKit

// MARK: - ViewController

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var changeBarButtonItem: UIBarButtonItem?
    
    @IBOutlet weak var segmentedControl: UISegmentedControl?
    
    @IBOutlet weak var textField: UITextField?
    
    @IBOutlet weak var pickerView: UIPickerView?
    
    @IBOutlet weak var arcView: ArcView?
    
    let colorAttributedStrings: [NSAttributedString] = [
        NSAttributedString(string: "black", attributes: [.foregroundColor: UIColor.black, .font: UIFont.systemFont(ofSize: 15.0)]),
        NSAttributedString(string: "blue", attributes: [.foregroundColor: UIColor.blue, .font: UIFont.systemFont(ofSize: 15.0)]),
        NSAttributedString(string: "gray", attributes: [.foregroundColor: UIColor.gray, .font: UIFont.systemFont(ofSize: 15.0)])
    ]

    // MARK: - ViewController LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField?.addTarget(self, action: #selector(textFieldDidChangeText(sender:)), for: .editingChanged)
        
        arcView?.startAngle = 0.0
        arcView?.endAngle = DegreesToRadians(90.0)
        arcView?.radius = 50.0
        arcView?.thickness = 25.0
        arcView?.color = UIColor.black
        arcView?.isClockwise = true
    }
    
    // MARK: - UIActions
    
    @IBAction func changeBarButtonItemTap(sender: UIBarButtonItem) {
        if segmentedControl?.selectedSegmentIndex == 0 {
            let angle = DegreesToRadians(textField!.cgFloat())
            let animation = CABasicAnimation(keyPath: "startAngle")
            animation.fromValue = arcView!.startAngle
            animation.toValue = angle
            animation.duration = 0.5
            arcView?.layer.add(animation, forKey: "startAngle")
            arcView?.startAngle = angle
        } else if segmentedControl?.selectedSegmentIndex == 1 {
            let angle = DegreesToRadians(textField!.cgFloat())
            let animation = CABasicAnimation(keyPath: "endAngle")
            animation.fromValue = arcView!.endAngle
            animation.toValue = angle
            animation.duration = 0.5
            arcView?.layer.add(animation, forKey: "endAngle")
            arcView?.endAngle = angle
        } else if segmentedControl?.selectedSegmentIndex == 2 {
            let radius = textField!.cgFloat()
            let animation = CABasicAnimation(keyPath: "radius")
            animation.fromValue = arcView!.radius
            animation.toValue = radius
            animation.duration = 0.5
            arcView?.layer.add(animation, forKey: "radius")
            arcView?.radius = radius
        } else if segmentedControl?.selectedSegmentIndex == 3 {
            let thickness = textField!.cgFloat()
            let animation = CABasicAnimation(keyPath: "thickness")
            animation.fromValue = arcView!.thickness
            animation.toValue = thickness
            animation.duration = 0.5
            arcView?.layer.add(animation, forKey: "thickness")
            arcView?.thickness = thickness
        } else if segmentedControl?.selectedSegmentIndex == 4 {
            let attributedString = colorAttributedStrings[pickerView!.selectedRow(inComponent: 0)]
            let color = attributedString.attribute(.foregroundColor, at: 0, effectiveRange: nil) as! UIColor
            let animation = CABasicAnimation(keyPath: "color")
            animation.fromValue = arcView!.color.cgColor
            animation.toValue = color.cgColor
            animation.duration = 0.5
            arcView?.layer.add(animation, forKey: "color")
            arcView?.color = color
        }
    }
    
    @IBAction func segmentedControlValueChanged(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 || sender.selectedSegmentIndex == 1 || sender.selectedSegmentIndex == 2 || sender.selectedSegmentIndex == 3 {
            textField?.isHidden = false
            textField?.text = ""
            pickerView?.isHidden = true
        } else if sender.selectedSegmentIndex == 4 {
            pickerView?.isHidden = false
            textField?.isHidden = true
        }
        
        changeBarButtonItem?.isEnabled = false
    }
    
    @objc func textFieldDidChangeText(sender: UITextField) {
        let text = textField?.text ?? ""
        changeBarButtonItem?.isEnabled = !text.isEmpty
    }
    
    // MARK: - UITextFieldDelegate / UITextFieldDataSource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return colorAttributedStrings.count
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return colorAttributedStrings[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        changeBarButtonItem?.isEnabled = true
    }
}

// MARK: - Convert

func DegreesToRadians(_ degrees: CGFloat) -> CGFloat {
    return CGFloat.pi * degrees / CGFloat(180)
}

func RadiansToDegrees(_ radians: CGFloat) -> CGFloat {
    return CGFloat(180) * radians / CGFloat.pi
}

// MARK: - Extensions

extension UITextField {
    
    func isText() -> Bool {
        return text != nil && !text!.isEmpty
    }

    func cgFloat() -> CGFloat {
        return CGFloat(double())
    }
    
    func double() -> Double {
        return isText() ? ((text! as NSString).replacingOccurrences(of: ",", with: ".") as NSString).doubleValue : 0.0
    }
}
