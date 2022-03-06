//
//  ViewController.swift
//  calculatorUIKit
//
//  Created by Mateus Goncalves De Ouro on 05/03/2022.
//

import UIKit

class ViewController: UIViewController {
   
    @IBOutlet var holder : UIView!
    
    var firstNumber = 0
    var resultNumber = 0
    var currentOperation : Operations?
    
    enum Operations{
        case add, subtract, multiply, divide, equal
    }
    
    private var resultLabel : UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .white
        label.textAlignment = .right
        label.font = UIFont(name: "Arial", size: 100)
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setUpNumberPad()
    }
    
    private func setUpNumberPad(){
        let buttonSize: CGFloat = view.frame.size.width/4
        
        let zeroButton = UIButton(frame: CGRect(x: 0, y: holder.frame.size.height-buttonSize , width: buttonSize*3, height: buttonSize))
        zeroButton.setTitleColor(.black, for: .normal)
        zeroButton.backgroundColor = .white
        zeroButton.setTitle("0", for: .normal)
        holder.addSubview(zeroButton)
        zeroButton.tag = 1
        zeroButton.addTarget(self, action: #selector( numberPressed(_:)), for: .touchUpInside)
        
        for x in 0..<3 {
            let button1 = UIButton(frame: CGRect(x: buttonSize * CGFloat(x),
            y: holder.frame.size.height-(buttonSize*2),
            width: buttonSize, height: buttonSize))
            button1.setTitleColor(.black, for: .normal)
            button1.backgroundColor = .white
            button1.setTitle("\(x+1)", for: .normal)
            holder.addSubview(button1)
            button1.tag = x + 2
            button1.addTarget(self, action: #selector( numberPressed(_:)), for: .touchUpInside)
        }
        
        for x in 0...2 {
            let button2 = UIButton(frame: CGRect(x: buttonSize * CGFloat(x),
            y: holder.frame.size.height-(buttonSize*3),
            width: buttonSize, height: buttonSize))
            button2.setTitleColor(.black, for: .normal)
            button2.backgroundColor = .white
            button2.setTitle("\(x+4)", for: .normal)
            holder.addSubview(button2)
            button2.tag = x + 2
            button2.addTarget(self, action: #selector( numberPressed(_:)), for: .touchUpInside)
        }
        
        for x in 0...2 {
            let button3 = UIButton(frame: CGRect(x: buttonSize * CGFloat(x),
            y: holder.frame.size.height-(buttonSize*4),
            width: buttonSize, height: buttonSize))
            button3.setTitleColor(.black, for: .normal)
            button3.backgroundColor = .white
            button3.setTitle("\(x+7)", for: .normal)
            holder.addSubview(button3)
            button3.tag = x + 8
            button3.addTarget(self, action: #selector( numberPressed(_:)), for: .touchUpInside)
        }
        
        
        let clear = UIButton(frame: CGRect(x: buttonSize * CGFloat(),
        y: holder.frame.size.height-(buttonSize*5),
        width: buttonSize*3, height: buttonSize))
        clear.setTitleColor(.red, for: .normal)
        clear.backgroundColor = .white
        clear.setTitle("CLEAR", for: .normal)
        holder.addSubview(clear)
        
        let operations = [ "=","+", "-" , "x" , "/" ]
        for x in 0..<5 {
            let operationsButton = UIButton(frame: CGRect(x: buttonSize * 3,
            y: holder.frame.size.height-(buttonSize*CGFloat(x+1)),
            width: buttonSize, height: buttonSize))
            operationsButton.setTitleColor(.black, for: .normal)
            operationsButton.backgroundColor = .orange
            operationsButton.setTitle(operations[x], for: .normal)
            holder.addSubview(operationsButton)
            operationsButton.addTarget(self, action: #selector(operationPressed(_:)), for: .touchUpInside)
            operationsButton.tag = x + 1
        }
        
        resultLabel.frame = CGRect(x: 0, y: clear.frame.origin.y - 100.0, width: view.frame.size.width, height: 100)
        holder.addSubview(resultLabel)
        
        clear.addTarget(self, action: #selector(clearResult), for: .touchUpInside)
    }
    
    @objc func clearResult(){
        resultLabel.text = "0"
        currentOperation = nil
        firstNumber = 0
    }
    
    @objc func numberPressed(_ sender: UIButton){
        let tag = sender.tag - 1
        
        if resultLabel.text == "0"{
            resultLabel.text = "\(tag)"
        }else if let text = resultLabel.text{
            resultLabel.text = "\(text)\(tag)"
        }else if resultLabel.text == "6"{
            resultLabel.text = "\(tag)"
        }
    }
    
    @objc func operationPressed(_ sender: UIButton){
        let tag = sender.tag
        if let text = resultLabel.text, let value = Int(text), firstNumber == 0{
            firstNumber = value
            resultLabel.text = "0"
        }
        if tag == 1 {
            if let operation = currentOperation {
                var secondNumber = 0
                if let text = resultLabel.text , let value = Int(text){
                    secondNumber = value
                }
                switch operation{
                
                case .add:
                    let  result = firstNumber + secondNumber
                    resultLabel.text = "\(result)"
                    break
                case .subtract:
                    let  result = firstNumber - secondNumber
                    resultLabel.text = "\(result)"
                    break
                case .multiply:
                    let  result = firstNumber * secondNumber
                    resultLabel.text = "\(result)"
                    break
                case .divide:
                    let  result = firstNumber / secondNumber
                    resultLabel.text = "\(result)"
                    break
                default:
                    break
                    
                }
            }
        } else if tag == 2 {
            currentOperation = .add}
        else if tag == 3 {
            currentOperation = .subtract}
        else if tag == 4 {
            currentOperation = .multiply}
        else if tag == 5{
            currentOperation = .divide}
        
    }
    

    
}

