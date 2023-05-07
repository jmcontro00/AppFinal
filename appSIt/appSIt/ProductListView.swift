//
//  ProductListView.swift
//  appSIt
//
//  Created by Amieva on 06/05/23.
//

import SwiftUI
import Firebase

struct Product: Identifiable {
    let id: String
    let pieza: String
    let marca: String
    let modelo: String
    let año: String
    let codigo: String
    let ubicacion: String
}

class FirestoreViewModel: ObservableObject {
    private var db = Firestore.firestore()
    @Published var products = [Product]()
    
    func fetchData() {
        db.collection("productos").getDocuments { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("No se pudo recuperar la colección de productos: \(error?.localizedDescription ?? "error desconocido")")
                return
            }
            
            self.products = documents.map { document in
                let data = document.data()
                let id = document.documentID
                let pieza = data["pieza"] as? String ?? ""
                let marca = data["marca"] as? String ?? ""
                let modelo = data["modelo"] as? String ?? ""
                let año = data["año"] as? String ?? ""
                let codigo = data["codigo"] as? String ?? ""
                let ubicacion = data["ubicacion"] as? String ?? ""
                
                return Product(id: id, pieza: pieza, marca: marca, modelo: modelo, año: año, codigo: codigo, ubicacion: ubicacion)
            }
        }
    }
    
    func deleteProduct(id: String) {
        db.collection("productos").document(id).delete { error in
            if let error = error {
                print("No se pudo eliminar el producto: \(error.localizedDescription)")
            }
        }
    }
}

struct ProductListView: View {
    @ObservedObject var viewModel = FirestoreViewModel()
    let currentDate = Date()
    let dateFormatter = DateFormatter()
    
    var body: some View {
        VStack(spacing:0) {
            ZStack(alignment: .leading) {
                Color.green
                    .ignoresSafeArea()
                    .frame(height: 80)
                
                HStack(alignment: .bottom, spacing: 10) {
                    Image(systemName: "cube.box.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.white)
                        .padding(.leading, 0)
                    
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: 5) {
                        Text(getUserEmail())
                            .bold()
                            .foregroundColor(.white)
                            .font(.custom("Helvetica Neue", size: 20))
                        
                        Text(dateFormatter.string(from: currentDate))
                            .bold()
                            .foregroundColor(.white)
                            .font(.custom("Helvetica Neue", size: 14))
                    }
                    .padding(.trailing, 0)
                }
                .padding(.horizontal, 20)
            }

            
            ZStack {
                NavigationView {
                    List(viewModel.products) { product in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(product.pieza)
                                    .font(.headline)
                                Text("\(product.marca) \(product.modelo) \(product.año) ")
                                    .font(.subheadline)
                                Text("\(product.codigo) \(product.ubicacion) ")
                                    .font(.subheadline)
                            }
                            Spacer()
                            VStack {
                                /*Button(action: {
                                    // Acción de editar
                                }) {
                                    Image(systemName: "pencil")
                                }*/
                                Button(action: {
                                    viewModel.deleteProduct(id: product.id)
                                    viewModel.fetchData()
                                }) {
                                    Image(systemName: "trash")
                                }
                            }
                        }
                    }
                    .navigationBarTitle("Productos")
                    .navigationBarItems(trailing:
                                            Button(action: {
                        viewModel.fetchData()
                    }) {
                        Image(systemName: "arrow.clockwise")
                    }
                    )
                }
                .onAppear {
                    viewModel.fetchData()
                }
            }
            HStack {
                
                Button(action: {
                    let helpScreen = HelpScreen()
                    let navView = NavigationView {
                        helpScreen
                    }
                    navView.navigationBarBackButtonHidden(true)
                    UIApplication.shared.windows.first?.rootViewController = UIHostingController(rootView: navView)
                }) {
                    Image(systemName: "questionmark.circle.fill")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(.gray)
                }
                Spacer()
                Button(action: {
                    let homeScreen = HomeScreen()
                    let navView = NavigationView {
                        homeScreen
                    }
                    navView.navigationBarBackButtonHidden(true)
                    UIApplication.shared.windows.first?.rootViewController = UIHostingController(rootView: navView)
                }) {
                    Image(systemName: "house.fill")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(.gray)
                }
                Spacer()
                Button(action: {
                    do {
                        try Auth.auth().signOut()
                        UIApplication.shared.windows.first?.rootViewController = UIHostingController(rootView: ContentView())
                    } catch let signOutError as NSError {
                        print("Error al cerrar la sesión: %@", signOutError)
                    }
                }) {
                    Image(systemName: "power")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(.gray)
                }
            }
            .padding(.horizontal, 40)
            .padding(.bottom, 0)
            
            
        }
    }
    func getUserEmail() -> String {
        if let user = Auth.auth().currentUser {
            return user.email ?? "Correo no encontrado"
        } else {
            return "Usuario no autenticado"
        }
    }
}



struct ProductListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListView()
    }
}
