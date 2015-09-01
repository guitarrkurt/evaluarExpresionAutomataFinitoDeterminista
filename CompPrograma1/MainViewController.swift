//
//  MainViewController.swift
//  
//
//  Created by guitarrkurt on 24/08/15.
//
//

import UIKit

class MainViewController: UIViewController {

    
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var first             : UIView!
    @IBOutlet weak var second            : UIView!
    @IBOutlet weak var eeTextField       : UITextField!
    @IBOutlet weak var aaAlfabeto        : UITextField!
    @IBOutlet weak var aaEstados         : UITextField!
    @IBOutlet weak var aaEstadosIniciales: UITextField!
    @IBOutlet weak var aaEstadosFinales  : UITextField!
    
    var alfabetoArray = [String]()
    var estadosArray = [String]()
    var estadosInicialesArray = [String]()
    var estadosFinalesArray = [String]()
    
    let path = NSTemporaryDirectory() + "MyFile.txt"
    let pathMatrix2 = NSTemporaryDirectory() + "Matrix.txt"
    
    let dict: NSDictionary = NSDictionary()
    var bandFirstInApp = true
    var bandAA = 0
    var matrix2 = NSMutableDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println("bandAA vale: \(bandAA)")
        
        let readDict: NSDictionary? = NSDictionary(contentsOfFile: path)
        
        if  readDict?.count > 0{
            println("entra")
            
            aaAlfabeto?.text? = readDict?.objectForKey("alfabeto") as! String
            alfabetoArray = (readDict?.objectForKey("alfabeto") as! String).componentsSeparatedByString(",")
            
            aaEstados?.text?  = readDict?.objectForKey("estados") as! String
            estadosArray = (readDict?.objectForKey("estados") as! String).componentsSeparatedByString(",")
            
            aaEstadosIniciales?.text? = readDict?.objectForKey("estadosiniciales") as! String
            estadosInicialesArray = (readDict?.objectForKey("estadosiniciales") as! String).componentsSeparatedByString(",")
            
            aaEstadosFinales?.text? = readDict?.objectForKey("estadosfinales") as! String
            estadosFinalesArray = (readDict?.objectForKey("estadosfinales") as! String).componentsSeparatedByString(",")
 
            bandFirstInApp = false
        }else{
            println("The dictionary is empty")
        }
        
        if bandAA == 1{
            bandAA = 0
            println("atributos automata")
            
            segment.selectedSegmentIndex = 1
            first.hidden = false
            second.hidden = true
        
            
        }
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

            if bandFirstInApp{
                bandFirstInApp = false
                
                let alert = UIAlertView()
                alert.title =   "a,b,c,d,e,f..."
                alert.message = "Recuerda introducir los caracteres separados por comas 💡"
                alert.addButtonWithTitle("Ok 🐶")
                alert.show()
            }

            break;
        default:
            
            break;
        }
    }
    
    @IBAction func eeEvaluar(sender: UIButton) {
        matrix2 = NSMutableDictionary(contentsOfFile: pathMatrix2)!
        println(matrix2)
        
        var tablaTransiciones = NSMutableDictionary()
        var k = 0
        
        for var i = 0; i < estadosArray.count; ++i{
            for var j = 0; j < alfabetoArray.count; ++j{
                var key = "\(estadosArray[i]),\(alfabetoArray[j])"
                var object = matrix2.objectForKey("\(k)") as! String
                ++k
                tablaTransiciones.setValue(object, forKey: key)
            }
        }
        
        
        println("tablaTransiciones: \(tablaTransiciones)")
        var expresion = NSArray()
        expresion = eeTextField.text.componentsSeparatedByString(",")
        println("expresion: \(expresion)")
        
        var edo = estadosInicialesArray[0]
        if(expresion.count > 0){
            for var i = 0; i < expresion.count; ++i{
                
                var llave = "\(edo),\(expresion[i])"
                
                println("i apuntador: \(i)")
                println("edo: \(edo)")
                println("letra:\(expresion[i])")
                println("expresion: \(edo),\(expresion[i])")

                
                edo = tablaTransiciones.objectForKey(llave) as! String
                
                if (edo != "?"){

                        println("Si se encuentra en el diccionario ✅")
                        println("edo: \(edo)")

                    //No hagas nada
                } else {
                    //SI es nil, no esta en la tabla
                    let alert = UIAlertView()
                    alert.title =   "La expresion ❌"
                    alert.message = "No es una expresion valida 😔"
                    alert.addButtonWithTitle("Ok")
                    alert.show()
                    break;
                }
                
                //Si llego al final es una expresion valida
                if i == expresion.count-1 {
                    println("entraa edo : \(edo)")
                    
                    if edo == estadosFinalesArray[0]
                    {
                        let alert = UIAlertView()
                        alert.title =   "La expresion ✅"
                        alert.message = "Es una expresion valida 😃"
                        alert.addButtonWithTitle("Ok")
                        alert.show()
                    }else {
                        println("nou")
                        let alert = UIAlertView()
                        alert.title =   "La expresion 🔴"
                        alert.message = "Es una expresion no valida 😃"
                        alert.addButtonWithTitle("Ok")
                        alert.show()
                    }

                }

            }
        
        } else {
            let alert = UIAlertView()
            alert.title =   "Warning ⚠️"
            alert.message = "Por favor introduce una expresión a evaluar"
            alert.addButtonWithTitle("Ok")
            alert.show()
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func aaFuncionTransicion(sender: UIButton) {
        /*Leemos los campos introducidos por el usuario y los guardamos en un archivo*/
        /*Read and write an NSDIctionary*/
        println("path: \(path)")

        let dict: NSDictionary = ["alfabeto":aaAlfabeto.text, "estados":aaEstados.text, "estadosiniciales":aaEstadosIniciales.text, "estadosfinales":aaEstadosFinales.text]
        //Write to file
        if dict.writeToFile(path, atomically: true) {
            //get contents of file
            let readDict: NSDictionary? = NSDictionary(contentsOfFile: path)
            //write and read are equals success
            if  dict == readDict {
                println("Read nice: \(dict)")
            } else {
                println("lectura y escritura no coinciden")
            }
        } else {
            println("file write to disk")
        }
        
        /*Pasamos a la vista funcion de transicion para que meta las funciones*/
        performSegueWithIdentifier("funcionTransicion", sender: self)
        
    }
    

}
