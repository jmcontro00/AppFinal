import SwiftUI

struct SplashView: View {
    @State private var animation = false
    @State private var isActive = false
    @State private var rotationAngle: Double = 0
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.green.edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer()
                    
                    Text("StoreIt")
                        .font(.system(size: 50, weight: .bold, design: .default))
                        .foregroundColor(.white)
                        .scaleEffect(animation ? 1.5 : 1)
                        .animation(Animation.easeInOut(duration: 1.5).delay(0.5))
                    
                    
                    VStack {
                        RoundedRectangle(cornerRadius: 25.0)
                            .frame(width: 150, height: 150)
                            .foregroundColor(Color.white.opacity(0.9))
                            .overlay(
                                Image(systemName: "cube.box.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(.green)
                                    .frame(width: 60, height: 60)
                                    .rotationEffect(.degrees(rotationAngle)) // agregar rotación
                            )
                            .scaleEffect(animation ? 1 : 0)
                            .animation(Animation.easeInOut(duration: 1.5).delay(1.0))
                            .onAppear {
                                withAnimation(Animation.linear(duration: 2.0).repeatForever()) {
                                    rotationAngle += 360 // girar continuamente
                                }
                            }
                    }
                    
                    Spacer()
                    
                    HStack {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .scaleEffect(1.5)
                            .padding(.trailing, 10)
                    }
                    
                    Spacer()
                    
                    Text("Versión 1.1.0").bold()
                        .bold()
                        .foregroundColor(.white)
                        .padding(.bottom, 10)
                    
                }
            }
        }
        .onAppear {
            self.animation.toggle()
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                self.isActive = true
            }
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .fullScreenCover(isPresented: $isActive) {
            ContentView()
        }
    }
}


struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
