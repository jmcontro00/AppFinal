//
//  RestablecerView.swift
//  appSIt
//
//  Created by Amieva on 05/05/23.
//

import SwiftUI
import Firebase

struct RestablecerView: View {
    
    @State private var nombreUsuario: String = ""
    @State private var contraseña: String = ""
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Spacer()
                    
                    ZStack {
                        Circle()
                            .foregroundColor(.green)
                            .frame(width: 120, height: 120)
                        
                        Image(systemName: "cube.box.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.white)
                            .frame(width: 60, height: 60)
                    }
                    .padding(.top, -60)
                    .padding(.bottom, 20)
                    
                    VStack {
                        Text("Ingresa el correo con el que te registraste.")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.center)
                                .padding()
                        HStack {
                            Text("Correo Electrónico:").bold()
                            Spacer()
                        }
                        TextField("Correo Electrónico", text: $nombreUsuario)
                            .padding()
                            .background(Color.white.opacity(0.5))
                            .cornerRadius(10.0)
                            .foregroundColor(.black)
                            .padding(.bottom, 20)

                        
                        Button(action: {
                            resetPassword()
                        }) {
                            Text("Restablecer")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(width: 220, height: 60)
                                .background(Color.green)
                                .cornerRadius(15.0)
                        }
                        
                        
                        
                    }
                    .frame(width: 300)
                    .padding()
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(10.0)
                    .shadow(radius: 10.0)
                    .padding(.horizontal)
                    
                    Spacer()
                        
                }
            }
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    func resetPassword() {
            Auth.auth().sendPasswordReset(withEmail: nombreUsuario) { error in
                if let error = error {
                    alertTitle = "Error"
                    alertMessage = error.localizedDescription
                    showingAlert = true
                } else {
                    alertTitle = "Éxito"
                    alertMessage = "Se envió un correo electrónico de restablecimiento de contraseña a \(nombreUsuario)."
                    showingAlert = true
                }
            }
        }
}


struct RestablecerView_Previews: PreviewProvider {
    static var previews: some View {
        RestablecerView()
    }
}
