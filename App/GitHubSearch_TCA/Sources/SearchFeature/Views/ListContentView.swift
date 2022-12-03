//
//  ListView.swift
//  
//
//  Created by クォン ジュンヒョク on 2022/08/20.
//

import ComposableArchitecture
import DataSource
import SwiftUI

public struct ListContentView: View {

    public init(store: Store<ListState, ListAction>) {
        self.store = store
    }

    let store: Store<ListState, ListAction>
    
    public var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            ScrollView {
                VStack(spacing: 16) {
                    SearchBar(keyword: viewStore.binding(get: \.keyword, send: ListAction.keywordChanged))

                    ForEach(viewStore.repositoryList, id: \.self) { repository in
                        Button {
                            viewStore.send(.repositoryItemTapped(url: repository.htmlUrl, title: repository.name))
                        } label: {
                            ListItem(imageUrl: repository.owner.avatarUrl,
                                     title: repository.name,
                                     userName: repository.owner.login,
                                     language: repository.language ?? "",
                                     stargazersCount: repository.stargazersCount)
                        }
                    }

                    Spacer()
                }
                .padding(16)
            }
            .background {
                if viewStore.isLoading {
                    ProgressView()
                        .progressViewStyle(.circular)
                }
            }
            .ignoresSafeArea(edges: .bottom)
            .alert(store.scope(state: \.alertState, action: ListAction.alertAction), dismiss: .onDismiss)
            .onAppear {
                viewStore.send(.onAppear)
            }
        }
    }
}

private struct SearchBar: View {
    
    @Binding var keyword: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            
            TextField("", text: $keyword)
            
            if !keyword.isEmpty {
                Button {
                    keyword.removeAll()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
        }
        .frame(height: 48)
        .padding(.horizontal, 12)
        .cornerRadius(8)
        .background(Color.white)
        .overlay {
            RoundedRectangle(cornerRadius: 8)
                .strokeBorder(Color(uiColor: .lightGray), lineWidth: 2)
        }
    }
}

private struct ListItem: View {
    
    var imageUrl: URL
    var title: String
    var userName: String
    var language: String
    var stargazersCount: Int
    
    var body: some View {
        HStack(spacing: 16) {
            AsyncImage(url: imageUrl) { image in
                image.resizable().scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 80, height: 80)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.title)
                    .fontWeight(.bold)
                
                Text(userName)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Text(language)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                HStack(spacing: 2) {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    
                    Text(String(stargazersCount))
                        .font(.subheadline)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct ListView_Previews: PreviewProvider {
    
    static var previews: some View {
        Preview()
    }
    
    private struct Preview: View {
        
        var body: some View {
            ListContentView(store: Store(initialState: .init(),
                                         reducer: listReducer,
                                         environment: .unimplemented))
        }
    }
}
