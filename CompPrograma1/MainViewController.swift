//
//  MainViewController.swift
//  
//
//  Created by guitarrkurt on 24/08/15.
//
//

import UIKit

class MainViewController: UIViewController {

    


    @IBOutlet weak var first             : UIView!
    @IBOutlet weak var second            : UIView!
    @IBOutlet weak var eeTextField       : UITextField!
    @IBOutlet weak var aaAlfabeto        : UITextField!
    @IBOutlet weak var aaEstados         : UITextField!
    @IBOutlet weak var aaEstadosIniciales: UITextField!
    @IBOutlet weak var aaEstadosFinales  : UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func segmentAction(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex
        {
        //Evaluar expresion
        case 0:
            println("evaluar expresion")
            first.hidden = true
            second.hidden = false
            
            break;
        //Atributos automata
        case 1:
            println("atributos automata")

            first.hidden = false
            second.hidden = true
            break;
        default:
            
            break;
        }
    }
    
    @IBAction func eeEvaluar(sender: UIButton) {
        

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func aaGuardar(sender: UIButton) {

        
    }
    
}
