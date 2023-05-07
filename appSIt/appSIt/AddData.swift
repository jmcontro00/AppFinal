//
//  AddData.swift
//  appSIt
//
//  Created by Amieva on 05/05/23.
//

import SwiftUI
import Firebase

struct AddData: View {
    
    @State private var pieza: String = ""
    @State private var marca: String = ""
    @State private var modelo: String = ""
    @State private var año: String = ""
    @State private var codigo: String = ""
    @State private var ubicacion: String = ""
    @State private var showingAlert = false
    @State private var showingAlert2 = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var formIncomplete = false
    @Environment(\.presentationMode) var presentationMode
    @State private var showingConfirmationAlert = false
    @State private var confirmationAlertTitle = ""
    @State private var confirmationAlertMessage = ""
    @State private var confirmationAlertAction: (() -> Void)? = nil
    
    
    let currentDate = Date()
    let dateFormatter = DateFormatter()
    
    var body: some View {
        VStack(spacing: 0) {
            
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
            
            VStack {
                Group {
                    HStack {
                        Text("Pieza:").bold()
                        Spacer()
                    }
                    
                    TextField("Pieza", text: $pieza)
                        .padding()
                        .background(Color.white.opacity(0.5))
                        .cornerRadius(10.0)
                        .foregroundColor(.black)
                        .padding(.bottom, 2)
                    
                    HStack {
                        Text("Marca:").bold()
                        Spacer()
                    }
                    
                    TextField("Marca", text: $marca)
                        .padding()
                        .background(Color.white.opacity(0.5))
                        .cornerRadius(10.0)
                        .foregroundColor(.black)
                        .padding(.bottom, 2)
                    
                    HStack {
                        Text("Modelo:").bold()
                        Spacer()
                    }
                    
                    TextField("Modelo", text: $modelo)
                        .padding()
                        .background(Color.white.opacity(0.5))
                        .cornerRadius(10.0)
                        .foregroundColor(.black)
                        .padding(.bottom, 2)
                }
                
                Group {
                    
                    HStack {
                        Text("Año:").bold()
                        Spacer()
                    }
                    
                    TextField("Año", text: $año)
                        .padding()
                        .background(Color.white.opacity(0.5))
                        .cornerRadius(10.0)
                        .foregroundColor(.black)
                        .padding(.bottom, 2)
                    
                    HStack {
                        Text("Código:").bold()
                        Spacer()
                    }
                    
                    TextField("Código", text: $codigo)
                        .padding()
                        .background(Color.white.opacity(0.5))
                        .cornerRadius(10.0)
                        .foregroundColor(.black)
                        .padding(.bottom, 2)
                    
                    HStack {
                        Text("Ubicación:").bold()
                        Spacer()
                    }
                    
                    TextField("Ubicación", text: $ubicacion)
                        .padding()
                        .background(Color.white.opacity(0.5))
                        .cornerRadius(10.0)
                        .foregroundColor(.black)
                        .padding(.bottom, 0)
                    
                }
                
                Group {
                    Button {
                        if pieza.isEmpty || marca.isEmpty || modelo.isEmpty || año.isEmpty || codigo.isEmpty || ubicacion.isEmpty {
                            alertTitle = "Error"
                            alertMessage = "Rellena los valores para continuar."
                            showingAlert = true
                        } else {
                            añadirDatos()
                        }
                    } label: {
                        Text("Añadir")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 220, height: 50)
                            .background(Color.green)
                            .cornerRadius(15.0)
                    }
                }
                
            }
            .frame(width: 325)
            .padding()
            .background(Color.white.opacity(0.8))
            .cornerRadius(10.0)
            .shadow(radius: 10.0)
            .padding(.horizontal)
            .padding(.top, 10)
            
            Color.white
                .edgesIgnoringSafeArea(.all)
            Spacer()
            
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
        .alert(isPresented: $showingAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
        
        .alert(isPresented: $showingAlert2) {
           Alert(title: Text(confirmationAlertTitle), message: Text(confirmationAlertMessage), primaryButton: .default(Text("Aceptar"), action: confirmationAlertAction), secondaryButton: .cancel(Text("Cancelar")))
        }

        
        
    }
    
    func getUserEmail() -> String {
        if let user = Auth.auth().currentUser {
            return user.email ?? "Correo no encontrado"
        } else {
            return "Usuario no autenticado"
        }
    }
    
    func añadirDatos() {
        let db = Firestore.firestore().collection("productos")
        let data: [String: Any] = [
            "pieza": pieza,
            "marca": marca,
            "modelo": modelo,
            "año": año,
            "codigo": codigo,
            "ubicacion": ubicacion
        ]
        
        print("verifacion")
        db.whereField("codigo", isEqualTo: codigo).getDocuments { querySnapshot, error in
            if let error = error {
                print("Error")
                alertTitle = "Error"
                alertMessage = error.localizedDescription
                showingAlert = true
            } else if let snapshot = querySnapshot, snapshot.documents.count > 0 {
                print("snapshsot")
                confirmationAlertTitle = "El código ya existe"
                confirmationAlertMessage = "¿Desea actualizar los datos?"
                showingAlert2 = true
                confirmationAlertAction = {
                    let document = snapshot.documents[0]
                    document.reference.updateData(data) { error in
                        if let error = error {
                            alertTitle = "Error"
                            alertMessage = error.localizedDescription
                            showingAlert = true
                        } else {
                            alertTitle = "Éxito"
                            alertMessage = "Data updated correctly."
                            showingAlert = true
                            
                            // Limpiar los campos del formulario
                            pieza = ""
                            marca = ""
                            modelo = ""
                            año = ""
                            codigo = ""
                            ubicacion = ""
                            
                            // Reiniciar la vista de inicio
                            let homeScreen = HomeScreen()
                            let navView = NavigationView {
                                homeScreen
                            }
                            UIApplication.shared.windows.first?.rootViewController = UIHostingController(rootView: navView)
                        }
                    }
                }
                showingConfirmationAlert = true
            } else {
                print("agregar")
                db.addDocument(data: data) { error in
                    if let error = error {
                        alertTitle = "Error"
                        alertMessage = error.localizedDescription
                        showingAlert = true
                    } else {
                        alertTitle = "Éxito"
                        alertMessage = "Data inserted correctly."
                        showingAlert = true
                        
                        // Limpiar los campos del formulario
                        pieza = ""
                        marca = ""
                        modelo = ""
                        año = ""
                        codigo = ""
                        ubicacion = ""
                        
                        // Reiniciar la vista de inicio
                        let homeScreen = HomeScreen()
                        let navView = NavigationView {
                            homeScreen
                        }
                        UIApplication.shared.windows.first?.rootViewController = UIHostingController(rootView: navView)
                    }
                }
            }
        }
        func confirmationAction() {
            confirmationAlertAction?()
            confirmationAlertAction = nil
            showingConfirmationAlert = false
        }
    }
    
    struct AddData_Previews: PreviewProvider {
        static var previews: some View {
            AddData()
        }
    }
}
