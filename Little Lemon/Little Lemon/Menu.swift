//
//  Menu.swift
//  Little Lemon
//
//  Created by Rick Konstan on 19/3/2024.
//

import SwiftUI

struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var menuItems = [MenuItem]()
    @State var searchText = ""
    
    var body: some View {
        VStack {
            HStack {
                Image("Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(alignment: .center)
                Spacer()
                Image("Profile")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
            }
            ZStack {
                VStack(alignment: .leading) {
                    Text("Little Lemon")
                        .font(.largeTitle)
                        .foregroundStyle(.yellow)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    Text("Chicago")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .foregroundStyle(.white)
                    HStack {
                        Text("We are a family owned Mediterranean restaurant, focussed on traditional recipes served with a modern twist.")
                            .foregroundStyle(.white)
                            .font(.headline)
                        Image("Hero image")
                            .resizable()
                            .scaledToFit()
                            .clipShape(.rect(cornerRadius: 15))
                    }
                    TextField("Search menu", text: $searchText)
                        .padding()
                        .background(Color.gray.cornerRadius(10))
                        .foregroundColor(.white)
                        .font(.headline)
                }
                .padding()
            }
            .background(Color("HeroColor"))
            
            VStack {
                Text("Order for delivery!".uppercased())
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .frame(alignment: .leading)
            }
            .padding(.top)
            
            FetchedObjects(predicate: buildPredicate(),
                sortDescriptors: buildSortDescriptors()) {
                (dishes: [Dish]) in
                List {
                    ForEach(dishes) { dish in
                        VStack(alignment: .leading) {
                            HStack {
                                VStack {
                                    Text("\(dish.title ?? "")")
                                        .padding()
                                    Text("\(dish.category ?? "")")
                                    Text("\(dish.price ?? "")")
                                        .foregroundColor(.gray)
                                        .font(.callout)
                                        .padding()
                                }
                                Spacer()
                                AsyncImage(url: URL(string: dish.image ?? "")) { image in
                                    image.image?.resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 100)
                                        .padding(.bottom, 30)
                                }
                            }
                        }
                        .contentShape(Rectangle())
                    }
                }
                .listStyle(SidebarListStyle())
            }
            
        }
        .onAppear() {
            getMenuData()
        }
    }
    
    func getMenuData() {
        //persistenceController.clear()
        
        // define the url address as a String object
        let serverUrl = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
        
        // create a URL object from the url address String object
        let url = URL(string: serverUrl)!
        // create a request with the unwrapped object
        let request = URLRequest(url: url)
        // create a dataTask object using the url request
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
           // unwrap the data and convert to a struct
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode(MenuList.self, from: data)
                    menuItems = result.menu
                    for item in menuItems {
                        let newDish = Dish(context: viewContext)
                        newDish.title = item.title
                        newDish.image = item.image
                        newDish.price = item.price
                        newDish.category = item.category
                    }
                    try? viewContext.save()
                } catch {
                    print(error)
                    menuItems = []
                }
                
                
            }
        }
        dataTask.resume()
    }
    
    func buildSortDescriptors() -> [NSSortDescriptor] {
        return [NSSortDescriptor(key: "title", ascending: true, selector: #selector(NSString .localizedStandardCompare))]
    }
    
    func buildPredicate() -> NSPredicate {
        if searchText == "" {
            return NSPredicate(value: true)
        }
        return NSPredicate(format: "title CONTAINS[cd] %@", searchText)
    }
}

#Preview {
    Menu()
}
