import SwiftUI
import Firebase

struct RegistroView: View {
    
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
                        Text("Ingresa los siguientes datos para completar tu registro.")
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
                        
                        HStack {
                            Text("Contraseña:").bold()
                            Spacer()
                        }
                        SecureField("Contraseña", text: $contraseña)
                            .padding()
                            .background(Color.white.opacity(0.5))
                            .cornerRadius(10.0)
                            .foregroundColor(.black)
                            .padding(.bottom, 20)
                        
                        Button(action: {
                            register()
                        }) {
                            Text("Regístrate")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(width: 220, height: 60)
                                .background(Color.green)
                                .cornerRadius(15.0)
                        }
                        
                        /*NavigationLink(destination: ContentView()) {
                         Text("¿Ya tienes usuario? Haz click aquí")
                         .foregroundColor(.blue)
                         .padding(.top, 20)
                         }*/
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
    
    func register(){
        Auth.auth().createUser(withEmail: nombreUsuario, password: contraseña) { result, error in
            if let error = error {
                alertTitle = "Error"
                alertMessage = error.localizedDescription
                showingAlert = true
            } else {
                let homeScreen = HomeScreen()
                let navView = NavigationView {
                    homeScreen
                }
                navView.navigationBarBackButtonHidden(true)
                UIApplication.shared.windows.first?.rootViewController = UIHostingController(rootView: navView)
            }
        }
    }
}

struct RegistroView_Previews: PreviewProvider {
    static var previews: some View {
        RegistroView()
    }
}
