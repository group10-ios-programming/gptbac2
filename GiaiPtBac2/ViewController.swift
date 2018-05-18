//
//  ViewController.swift
//  GiaiPtBac2
//
//  Created by NhatThanh on 5/16/18.
//  Copyright © 2018 NhatThanh. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var txta: UITextField!
    @IBOutlet weak var txtb: UITextField!
    @IBOutlet weak var txtc: UITextField!
    
    @IBOutlet weak var lblResult1: UILabel!
    @IBOutlet weak var lblResult2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        lblResult1.isHidden = true
        lblResult2.isHidden = true
        txta.delegate = self
        txtb.delegate = self
        txtc.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // kiem tra hop le
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        let aSet = NSCharacterSet(charactersIn: "0123456789.-").inverted
        let cursor=range.location
        let compSepByCharInSet = string.components(separatedBy: aSet)
        if ((textField.text?.contains("."))! && compSepByCharInSet[0] == ".") ||
            ((textField.text?.contains("-"))! && compSepByCharInSet[0] == "-") ||
            (cursor==0 && compSepByCharInSet[0] == ".") || (cursor != 0 && compSepByCharInSet[0] == "-"){
            return false
        }
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        return string == numberFiltered
    }
    
    @IBAction func GiaiPT(_ sender: UIButton) {
        lblResult2.text = ""
        lblResult1.isHidden = false
        var a:Double=0
        var b:Double=0
        var c:Double=0
        if(txta.text == "" || txtb.text == "" || txtc.text == ""
            || txta.text == "-" || txtb.text == "-" || txtc.text == "-"){
            lblResult1.text = "Kiem tra lai dinh dang!"
            return
        }
        //
        if txta.text != ""{
            a = Double(txta.text!)!
        }
        if txtb.text != ""{
            b = Double(txtb.text!)!
            
        }
        if txtc.text != ""{
            c = Double(txtc.text!)!
            
        }
        if(a==0)
        {
            if(b==0)
            {
                if(c==0)
                {
                    lblResult1.text = "Phương trình có vô số nghiệm"
                }
                else
                {
                    lblResult1.text = "Phương trình vô nghiệm"
                }
            }
            else
            {
                if(c==0)
                {
                    lblResult1.text = "Phương trình có nghiệm x = 0"
                }
                else
                {   let x = -c/b
                    let kq = Double(round(10000*x)/10000)
                    lblResult1.text = "Phương trình có nghiệm x = \(kq)"
                }
            }
        }
        else
        {
            if(b==0 && c==0)
            {
                lblResult1.text = "Phương trình có nghiệm x = 0"
            }
            else
            {
                let delta = b*b-4*a*c
                if(delta<0)
                {
                    lblResult1.text = "Phương trình vô nghiệm"
                }
                else
                {
                    if(delta==0)
                    {
                        let n = -b/(2*a)
                        let kq = Double(round(10000*n)/10000)
                        lblResult1.text = "x1 = x2 = \(kq)" //PT có nghiệm kép
                    }
                    else
                    {
                        lblResult2.isHidden = false
                        //PT có 2 nghiệm phân biệt
                        let n1 = ((-b+sqrt(delta))/(2*a)*10000)/10000
                        let n2 = ((-b-sqrt(delta))/(2*a)*10000)/10000
                        let x1 = Double(round(10000*n1)/10000)
                        let x2 = Double(round(10000*n2)/10000)
                        lblResult1.text = "x1 = \(x1)"
                        lblResult2.text = "x2 = \(x2)"
                    }
                }
            }
        }
    }
}

