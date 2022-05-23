//
//  ViewController.swift
//  eggplant-brownie
//
//  Created by Hugo Paulista on 28/03/22.
//

import UIKit

protocol AdicionaRefeicaoDelegate {
    func add (_ refeicao: Refeicao)
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AdicionaItensDelegate {
    
    // MARK: - Atributos
    var delegate: AdicionaRefeicaoDelegate?
    var itens: [Item] = []
    var itensSelecionados: [Item] = []
    
    // MARK: - IBOutlets
    @IBOutlet var nomeTextField: UITextField?
    @IBOutlet var felicidadeTextField: UITextField?
    @IBOutlet weak var itensTableView: UITableView!
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        let botaoAdicionarItem = UIBarButtonItem(title: "Adicionar", style: .plain, target: self, action: #selector(self.adicionarItens))
        navigationItem.rightBarButtonItem = botaoAdicionarItem
        
        getItens()
    }
    
    func getItens() {
        itens = ItemDao().get()
    }
    
    @objc func adicionarItens() {
        let adicionarItensViewController = AdicionarItensViewController(delegate: self)
        navigationController?.pushViewController(adicionarItensViewController, animated: true)
    }
    
    func add(_ item: Item) {
        itens.append(item)
        ItemDao().save(itens)
        if let tableView = itensTableView {
            tableView.reloadData()
            return
        }
        
        Alerta(controller: self).exibe(message: "Não foi possível atualizar a tabela")
    }
    
    func getRefeicao() -> Refeicao? {
        guard let nomeRefeicao = nomeTextField?.text else {
            return nil
        }
        
        guard let felicidadeRefeicao = felicidadeTextField?.text, let felicidade = Int(felicidadeRefeicao) else {
            return nil
        }
        
        return Refeicao(nome: nomeRefeicao, felicidade: felicidade, itens: itensSelecionados)
    }
    
    // MARK: - Actions
    @IBAction func adicionar() {
        guard let refeicao = getRefeicao() else {
            Alerta(controller: self).exibe(message: "Erro nos dados do formulário")
            return
        }
        delegate?.add(refeicao)
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itens.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cel = UITableViewCell(style: .default, reuseIdentifier: nil)
        cel.textLabel?.text = itens[indexPath.row].nome
        
        return cel
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cel = tableView.cellForRow(at: indexPath) else { return }
        
        if cel.accessoryType == .none {
            cel.accessoryType = .checkmark
            
            itensSelecionados.append(itens[indexPath.row])
        } else {
            cel.accessoryType = .none
            let item = itens[indexPath.row]
            
            if let position = itensSelecionados.firstIndex(of: item) {
                itensSelecionados.remove(at: position)
                
                print(itensSelecionados.debugDescription)
            }
        }
    }

}

