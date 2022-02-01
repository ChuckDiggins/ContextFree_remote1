//
//  CollectionView.swift
//  CollectionView
//
//  Created by Charles Diggins on 1/29/22.
//

import SwiftUI

struct CollectionView: View {
    @EnvironmentObject var cfModelView : CFModelView
    @State private var collectionManager = dWordCollectionManager()
    @State private var collectionList = [dWordCollection]()
    @State private var collectionNameList = [String]()
    @State private var currentCollection = dWordCollection()
    
    var body: some View {
        NavigationView {
            List {
                Section(
                    header:
                        HStack{
                            Text("Collections")
                            Image(systemName: "flame.fill")
                        }.font(.headline)
                        .foregroundColor(.orange)
                ){
                    ForEach(0..<collectionList.count) { i in
                        NavigationLink(destination:ShowCurrentCollectionContents(currentCollection: collectionList[i])){
                                Text(collectionNameList[i]).bold()
                        }.frame(height: 50)
                            .padding(5)
                            .background(Color.orange)
                            .cornerRadius(10)
                    }
                    .onDelete(perform: delete)
                    .onMove(perform: move)
                    .listRowBackground(Color.yellow)
                }

            }
            .onAppear{
                collectionManager = cfModelView.getWordCollectionManager()
                fillCollectionList()
            }
            
            .listStyle(GroupedListStyle())
            .navigationTitle("Collection List")
            .navigationBarItems(
                leading: EditButton(),
                trailing: addButton)
            
        }.accentColor(.red)
    }
    
    struct ShowCurrentCollectionContents: View{
        var currentCollection : dWordCollection
        
        var body: some View {
            VStack{
                Text("Word collection: \(currentCollection.collectionName)")
                Text("Word count: \(currentCollection.getWordCount())")
            }
                VStack{
                    Text("Words:").bold()
                    ForEach (0..<currentCollection.getWordCount()){ i in
                        Text(currentCollection.getWord(index: i).spanish)
                    }
                }.background(Color.red.opacity(0.3))
                    .padding()
            Spacer()
        }
    }
    
    func fillCollectionList(){
        collectionList.removeAll()
        for collection in collectionManager.getCollectionList(){
            collectionList.append(collection)
            collectionNameList.append(collection.collectionName)
        }
    }
    func delete(indexSet: IndexSet){
//        fruits.remove(atOffsets: indexSet)
    }
    
    func move(indices: IndexSet,  newOffset: Int){
//        fruits.move(fromOffsets: indices, toOffset: newOffset)
    }
    
    var addButton: some View {
        Button("Add Bundle", action: {add()})
    }
    
    func add(){
//        fruits.append("Coconut")
    }

}

struct CollectionView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionView()
    }
}

