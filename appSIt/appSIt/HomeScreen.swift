import SwiftUI
import Firebase

struct HomeScreen: View {
    
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
            
            VStack {
                Spacer()
                
                HStack(spacing: 0) {
                    Button(action: {
                        let addData = AddData()
                        let navView = NavigationView {
                            addData
                        }
                        UIApplication.shared.windows.first?.rootViewController = UIHostingController(rootView: navView)
                    }) {
                        VStack {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .frame(width: 70, height: 70)
                                .foregroundColor(.white)
                                .padding(20)
                            
                            Text("Añadir")
                                .foregroundColor(.white)
                                .font(.custom("Helvetica Neue", size: 16))
                        }
                        .background(Color.green)
                        .cornerRadius(10)
                        .padding(.horizontal, 40)
                    }
                    
                    Button(action: {
                        let viewScreen = ProductListView()
                        let navView = NavigationView {
                            viewScreen
                        }
                        UIApplication.shared.windows.first?.rootViewController = UIHostingController(rootView: navView)
                    }) {
                        VStack {
                            Image(systemName: "eye.circle.fill")
                                .resizable()
                                .frame(width: 70, height: 70)
                                .foregroundColor(.white)
                                .padding(20)
                            
                            Text("Ver")
                                .foregroundColor(.white)
                                .font(.custom("Helvetica Neue", size: 16))
                        }
                        .background(Color.green)
                        .cornerRadius(10)
                        .padding(.horizontal, 40)
                    }
                }
                .padding(.bottom, 10)
                
                HStack(spacing: 0) {
                    Button(action: {
                    }) {
                        VStack {
                            Image(systemName: "map.fill")
                                .resizable()
                                .frame(width: 70, height: 70)
                                .foregroundColor(.white)
                                .padding(20)
                            
                            Text("Mapa")
                                .foregroundColor(.white)
                                .font(.custom("Helvetica Neue", size: 16))
                        }
                        .background(Color.green)
                        .cornerRadius(10)
                        .padding(.horizontal, 40)
                    }
                    
                    Button(action: {
                    }) {
                        VStack {
                            Image(systemName: "person.fill")
                                .resizable()
                                .frame(width: 70, height: 70)
                                .foregroundColor(.white)
                                .padding(20)
                            
                            Text("Perfil")
                                .foregroundColor(.white)
                                .font(.custom("Helvetica Neue", size: 16))
                        }
                        .background(Color.green)
                        .cornerRadius(10)
                        .padding(.horizontal, 40)
                    }
                }
                
                Spacer()
            }
            .padding(.top,100)
            
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
    }
    
    func getUserEmail() -> String {
        if let user = Auth.auth().currentUser {
            return user.email ?? "Correo no encontrado"
        } else {
            return "Usuario no autenticado"
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
