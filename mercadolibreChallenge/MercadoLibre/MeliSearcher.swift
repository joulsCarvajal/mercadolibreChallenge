//
//  MeliSearcher.swift
//  mercadolibreChallenge
//
//  Created by Julian Carvajal on 3/07/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct MeliSearcher: View {
    @State var productName: String = ""
    @State var wrapper: ApiNetWork.Wrapper? = nil
    @State var loading: Bool = false
    @State var showError: Bool = false
    @State var errorMessage: String = ""
    
    var body: some View {
        VStack{
            ZStack(alignment: .leading) {
                TextField("", text: $productName, prompt: Text("Buscar en Mercado Libre").font(.title3).foregroundColor(.gray))
                    .padding(.leading, 32) // Espacio para el icono
                    .padding(8)
                    .background(Color.white)
                    .cornerRadius(16)
                    .font(.title3)
                    .bold()
                    .foregroundColor(.gray)
                    .autocorrectionDisabled()
                    .onSubmit {
                        loading = true //Con esto mostramos el progress
                        print(productName)
                        //Creamos un objeto task asíncrono
                        searchProduct()
                    }
                
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                    .padding(.leading, 8)
            }
            .padding()
            
            if loading{
                ProgressView().tint(.white)
            }
            //Aquí usamos un navigation para el detail del producto
            NavigationStack{
                List(wrapper?.results ?? []){ product in
                    ZStack{
                        ProductItem(product: product)
                        NavigationLink(destination: ProductDetail(product: product)) {
                            ProductItem(product: product)
                        }.buttonStyle(.plain)
                    }.listRowBackground(Color.backgroundMeli)
                }.listStyle(.plain)
            }
            Spacer()
        }.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
            .background(.backgroundMeli)
            .alert(isPresented: $showError){
                Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
    }
    
    private func searchProduct() {
            loading = true
            print(productName)
            Task {
                do {
                    wrapper = try await ApiNetWork().getProductByQuery(query: productName)
                } catch let error as NetworkError {
                    handleSearchError(error)
                } catch {
                    handleSearchError(.unknownError)
                }
                loading = false
            }
        }
    
    private func handleSearchError(_ error: NetworkError) {
            handleError(error)
            errorMessage = error.localizedDescription
            showError = true
        }
}



struct ProductItem: View {
    let product: ApiNetWork.Product
    var body: some View {
        ZStack{
            WebImage(url: URL(string: product.thumbnail))
                .resizable()
                .indicator(.activity)
                .scaledToFill()
                .frame(height: 200)
            VStack{
                Spacer()
                Text(product.title).foregroundColor(.black)
                    .font(.title3)
                    .padding()
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    .background(.white.opacity(0.8))
            }
        }.frame(height: 200).cornerRadius(32)
        
    }
}

#Preview {
    MeliSearcher()
}

//#Preview {
//    ProductItem(product: ApiNetWork.Product(id: "", title: "Algo"))
//}
