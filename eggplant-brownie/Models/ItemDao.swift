//
//  ItemDao.swift
//  eggplant-brownie
//
//  Created by Hugo Paulista on 23/05/22.
//

import Foundation

class ItemDao {
    func save(_ itens: Array<Item>) {
        do {
            let dados = try NSKeyedArchiver.archivedData(withRootObject: itens, requiringSecureCoding: false)
            guard let caminho = recuperarDiretorio() else {return}
            try dados.write(to: caminho)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func get() -> [Item] {
        guard let caminho = recuperarDiretorio() else { return [] }
        do {
            let dados = try Data(contentsOf: caminho)
            let itensSalvos = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(dados) as! Array<Item>
            
            return itensSalvos
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    func recuperarDiretorio() -> URL? {
        guard let diretorio = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return diretorio.appendingPathComponent("itens")
    }
}
