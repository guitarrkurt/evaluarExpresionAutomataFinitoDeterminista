//
//  funcionTransicionViewController.swift
//  CompPrograma1
//
//  Created by guitarrkurt on 27/08/15.
//  Copyright (c) 2015 guitarrkurt. All rights reserved.
//

import UIKit

class funcionTransicionViewController: UIViewController, UICollectionViewDataSource {
    
    var bandAA = 0
    var offset = 0
    let path = NSTemporaryDirectory() + "MyFile.txt"
    let pathMatrix2 = NSTemporaryDirectory() + "Matrix.txt"
    
    var alfabeto = String()
    var estados = String()
    var estadosIniciales = String()
    var estadosFinales = String()
    
    var alfabetoArray = [String]()
    var estadosArray = [String]()
    var estadosInicialesArray = [String]()
    var estadosFinalesArray = [String]()
    var matrix = [String]()
    var matrix2 = NSMutableDictionary()

    @IBOutlet weak var myCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println("entra constructor")
        
        let readDict: NSDictionary? = NSDictionary(contentsOfFile: path)
        
        if  readDict?.count > 0{
            println("entra")
            alfabeto = readDict?.objectForKey("alfabeto") as! String
            estados  = readDict?.objectForKey("estados") as! String
            estadosIniciales = readDict?.objectForKey("estadosiniciales") as! String
            estadosFinales = readDict?.objectForKey("estadosfinales") as! String
            
        }else{
            println("The dictionary is empty")
        }
        
        alfabetoArray = alfabeto.componentsSeparatedByString(",")
        println("\(alfabetoArray)")
        
        estadosArray = estados.componentsSeparatedByString(",")
        println("\(estados)")
        
        estadosInicialesArray = estadosIniciales.componentsSeparatedByString(",")
        println("\(estadosIniciales)")
        
        estadosFinalesArray = estadosFinales.componentsSeparatedByString(",")
        println("\(estadosFinales)")

        for var i = 0; i < estadosArray.count; ++i{
            for var j = 0; j < alfabetoArray.count; ++j{
                    matrix.append("\(estadosArray[i])\\\(alfabetoArray[j])")
                    println("\(estadosArray[i])\\\(alfabetoArray[j])")
            }
        }
        
    }
    
    @IBAction func alfabetoAction(sender: UIBarButtonItem) {
            bandAA = 1
            performSegueWithIdentifier("main", sender: self)
    }

    @IBAction func evaluarAction(sender: UIBarButtonItem) {
            println("writed in Matrix.txt: \(matrix2)")
            performSegueWithIdentifier("main", sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return matrix.count
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("collectionViewCell", forIndexPath: indexPath) as! transicionCollectionViewCell
        
            cell.label.text = matrix[indexPath.row]
        


        matrix2 = NSMutableDictionary(contentsOfFile: pathMatrix2)!
        println("readMatrix2 in cell: \(matrix2)")
        if  matrix2.count > 0{
            
            cell.textField.text = matrix2.objectForKey("\(indexPath.row)") as? String
        }

        cell.textField.addTarget(self, action: "guardaDatosMatrix:", forControlEvents: .EditingDidEnd)

        return cell
    }
    
   func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    

        var ancho = Double(self.view.frame.size.width)/Double(alfabetoArray.count+1)
        var alto  = Double(self.view.frame.size.width)/Double(alfabetoArray.count+2)
    
        return CGSize(width: ancho, height: alto);

    }
    
    func guardaDatosMatrix(sender: UITextField){
        var theParentCell = (sender.superview?.superview as! transicionCollectionViewCell)
        var indexPath = myCollectionView.indexPathForCell(theParentCell)

        matrix2.setObject(sender.text, forKey: "\(indexPath!.row)")
        println("\(matrix2)")

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "main" {
            if matrix2.writeToFile(pathMatrix2, atomically: true){
                println("writed in Matrix.txt: \(matrix2)")
            }
            (segue.destinationViewController as! MainViewController).bandAA = bandAA
            (segue.destinationViewController as! MainViewController).matrix2 = matrix2
        }
    }



}
