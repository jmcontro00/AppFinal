//
//  productViewModel.swift
//  appSIt
//
//  Created by Amieva on 06/05/23.
//

import Foundation
import FirebaseFirestore

class productViewModel: ObservableObject {
    
    @Published var products = [Product]()
    
    private var db = Firestore.firestore()
    
    func fetchData() {
        db.collection("productos").addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.document else {
                print("No documents")
                return
            }
            
            self.products = documents.map { (QueryDocumentSnapshot) -> Product in
                let data = QueryDocumentSnapshot.data()
                let pieza = data["pieza"] as? String ?? ""
                let marca = data["marca"] as? String ?? ""
                let modelo = data["modelo"] as? String ?? ""
                let año = data["año"] as? String ?? ""
                let codigo = data["codigo"] as? String ?? ""
                let ubicacion = data["ubicacion"] as? String ?? ""
                
            }
        }
    }
}
