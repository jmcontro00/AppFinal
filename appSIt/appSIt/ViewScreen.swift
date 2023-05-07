import SwiftUI
import Firebase

struct ViewScreen: View {
    
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
    }
    
    func getUserEmail() -> String {
        if let user = Auth.auth().currentUser {
            return user.email ?? "Correo no encontrado"
        } else {
            return "Usuario no autenticado"
        }
    }
}

struct ViewScreen_Previews: PreviewProvider {
    static var previews: some View {
        ViewScreen()
    }
}
