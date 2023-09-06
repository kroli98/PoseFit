
import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer
    
    static let preview: PersistenceController = {
          let controller = PersistenceController(inMemory: true)
         
          let viewContext = controller.container.viewContext
          for _ in 0..<10 {
              let newItem = CompletedExercise(context: viewContext)
              newItem.date = Date()
              newItem.name = "Exercise \(Int.random(in: 1...5))"
              newItem.repetition = Int32.random(in: 5...20)
              newItem.series = Int32.random(in: 1...5)
              newItem.correctness = Double.random(in: 0.0...100.0)
              newItem.elapsedExerciseTime = Int32.random(in: 60...600)
           
          }
          do {
              try viewContext.save()
          } catch {
            
              fatalError("Unresolved error \(error)")
          }
          return controller
      }()

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "PoseGym")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
               
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
