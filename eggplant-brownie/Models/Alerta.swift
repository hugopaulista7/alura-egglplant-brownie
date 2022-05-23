//
//  Alerta.swift
//  eggplant-brownie
//
//  Created by Hugo Paulista on 21/05/22.
//

import UIKit

class Alerta {
    
    let controller: UIViewController
    
    init(controller: UIViewController) {
        self.controller = controller
    }
    
    func exibe(title: String = "Erro", message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok    = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        
        alert.addAction(ok)
        
        controller.present(alert, animated: true, completion: nil)
    }
}
