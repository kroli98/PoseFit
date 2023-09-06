
import AVFoundation
import SwiftUI


struct HomeView: View {
   
    @State var name: String = "Ismeretlen"
    @EnvironmentObject var navigationCoordinator: NavigationCoordinator
  


    var body: some View {
        
        VStack {
            Text("Üdv, \(name)!")
                .font(.largeTitle)
            
           

            WeeklySummaryCardView()
                .frame(maxHeight: 150)
                .padding(.bottom)
            
              

            WorkoutLaunchCardView()

            Spacer()
        }
        .padding()
        .ignoresSafeArea(.all, edges: .bottom)
        .onAppear {
          
            name = UserDefaults.standard.string(forKey: "UserName") ?? "Ismeretlen"
            navigationCoordinator.isNavigating = false
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let navigationCoordinator = NavigationCoordinator()
        ScrollView{
            HomeView()
        }
            .environmentObject(navigationCoordinator)
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)

    }
}
