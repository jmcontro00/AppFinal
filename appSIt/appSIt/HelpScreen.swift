import SwiftUI
import Firebase

struct HelpScreen: View {
    
    let currentDate = Date()
    let dateFormatter = DateFormatter()
    @Environment(\.presentationMode) var presentationMode
    
    
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
            
            Spacer() // Agregamos un Spacer
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Preguntas Frecuentes")
                        .bold()
                        .font(.system(size: 32, weight: .thin))
                        .foregroundColor(.black)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("¿Cómo cambio mi contraseña?")
                            .font(.system(size: 20, weight: .bold))
            
                        Text("Para cambiar tu contraseña, ve a la pantalla de inicio de sesión y haz clic en \"¿Olvidaste tu contraseña?\".")
                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("¿Cómo puedo actualizar un producto?")
                            .font(.system(size: 20, weight: .bold))
                        Text("Para actualizar un prodcuto en la ventana de agregar, ingresa todos los datos del producto a modificar. El sistema tomara el codigo como referencia y actualizara todos los campos.")
                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("¿Cómo cierro sesión en la aplicación?")
                            .font(.system(size: 20, weight: .bold))
                        Text("Puedes cerrar sesión en la aplicación haciendo clic en el botón de apagado en la esquina inferior derecha de la pantalla.")
                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("¿Cómo agrego un nuevo producto?")
                            .font(.system(size: 20, weight: .bold))
                        Text("Para agregar un nuevo producto dirijiste en el menú principal a Añadir e ingresa los datos de la pieza. Por último haz click en Añadir.\".")
                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("¿Cómo veo los productos")
                            .font(.system(size: 20, weight: .bold))
                        Text("Para visualizar los productos dirijite en el menú principal a la opción de Visualizar.")
                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("¿Qué es la caja que se encuentra en el encabezado?")
                            .font(.system(size: 20, weight: .bold))
                        Text("Es el logo de nuestra aplicación StoreIt.")
                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("¿Cómo puedo contactar al equipo de soporte?")
                            .font(.system(size: 20, weight: .bold))
                        Text("Envía un correo electrónico al supervisor. Su correo es: jose.contro04@anahuac.mx")
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                .padding(.bottom, 50)
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

struct HelpScreen_Previews: PreviewProvider {
    static var previews: some View {
        HelpScreen()
    }
}
