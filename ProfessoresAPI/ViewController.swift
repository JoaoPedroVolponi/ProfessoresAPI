import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtNome: UITextField!
    @IBAction func buttonAdd(_ sender: Any)  {
        
        let url = URL(string :"https://cors.grandeporte.com.br/cursos.grandeporte.com.br:8080/professores")!
        
        var requisicao = URLRequest(url: url)
        requisicao.httpMethod = "POST"
        
        requisicao.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let professor = ProfessorModel()
        professor.nome = txtNome.text
        professor.email = txtEmail.text
        
        let encoder = JSONEncoder()
    
        // Conversao e atribuir JSON para o corpo da requisicao
        do {
            requisicao.httpBody = try encoder.encode(professor)
        }
        catch{
            print("Erro ao converter professor")
        }
        
        // criar a tarefa assincrona que vai fazer a requisicao
        
        let tarefa = URLSession.shared.dataTask(with: requisicao){ (dados, resposta, erro) in
            
            if (erro == nil){
                print("Professor criado com sucesso")
            }
            else{
                print("Erro ao criar o professor")
            }
            
        }
        tarefa.resume()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

