//
//  AdicionarItensViewController.swift
//  eggplant-brownie
//
//  Created by Hugo Paulista on 20/05/22.
//

import UIKit

protocol AdicionaItensDelegate {
    func add(_ item: Item)
}

class AdicionarItensViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var nomeTextField: UITextField!
    @IBOutlet weak var caloriasTextField: UITextField!
    
    // MARK: - Atributos
    
    var delegate: AdicionaItensDelegate?
    
    // MARK: - View life cycle
    
    init(delegate: AdicionaItensDelegate) {
        super.init(nibName: "AdicionarItensViewController", bundle: nil)
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - IBAction
    
    @IBAction func adicionarItem(_ sender: Any) {
        
        guard let nome = nomeTextField.text else { return }
        guard let calorias = caloriasTextField.text, let caloriasDouble = Double(calorias) else { return }
        
        let item = Item(nome: nome, calorias: caloriasDouble)
        
        delegate?.add(item)
        
        navigationController?.popViewController(animated: true)
    }
    
}
