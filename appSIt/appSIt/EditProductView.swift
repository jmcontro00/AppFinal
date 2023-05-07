import SwiftUI
import Firebase

struct EditProductView: View {
    @State private var codigo = ""
    @State private var atributos: [String: Any] = [:]
    @State private var isEditing = false

    private var productosRef: CollectionReference {
        return Firestore.firestore().collection("productos")
    }

    private func buscarElemento() {
        productosRef.document(codigo).getDocument { (snapshot, error) in
            if let snapshot = snapshot, snapshot.exists {
                self.atributos = snapshot.data() ?? [:]
                self.isEditing = true
            } else {
                self.atributos = [:]
                self.isEditing = false
            }
        }
    }

    private func actualizarProducto() {
        productosRef.document(codigo).setData(atributos) { error in
            if let error = error {
                print("Error al actualizar el producto: \(error.localizedDescription)")
            } else {
                print("Producto actualizado correctamente")
            }
        }
    }

    var body: some View {
        VStack {
            HStack {
                TextField("Ingrese el código del producto", text: $codigo)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                Button(action: buscarElemento) {
                    Text("Buscar")
                }
                .disabled(codigo.isEmpty)
                .padding(.trailing)
            }
            .padding(.top)

            Divider()

            if isEditing {
                ForEach(atributos.sorted(by: { $0.key < $1.key }), id: \.key) { atributo in
                    HStack {
                        Text(atributo.key)
                        Spacer()
                        TextField("", text: Binding(get: {
                            "\(atributo.value)"
                        }, set: { newValue in
                            self.atributos[atributo.key] = newValue
                        }))
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 4)
                }

                Button(action: actualizarProducto) {
                    Text("Actualizar producto")
                }
                .padding(.top, 16)
            } else {
                Text("No se encontró ningún producto con el código \(codigo)")
                    .padding(.top, 16)
            }

            Spacer()
        }
    }
}
