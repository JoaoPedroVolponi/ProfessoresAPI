import UIKit


class ViewController: UIViewController {
    var teste1 = ProfessorModel()
    var index = -1
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtNome: UITextField!
    @IBAction func buttonAdd(_ sender: Any)  {
        var requisicao : URLRequest
        
        if !(index >= 0){
            
            
            let url = URL(string :"https://cors.grandeporte.com.br/cursos.grandeporte.com.br:8080/professores/")!
            
            requisicao = URLRequest(url: url)
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
            // editar
        }else{
            
            let url = URL(string: "https://cors.grandeporte.com.br/cursos.grandeporte.com.br:8080/professores/" + String (teste1.id!))!
            
            requisicao = URLRequest(url: url)
            requisicao.httpMethod = "PATCH"
            requisicao.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let professor = ProfessorModel()
            professor.nome = txtNome.text
            professor.email = txtEmail.text
            
            let encoder = JSONEncoder()
            
            do {
                requisicao.httpBody = try encoder.encode(professor)
            }
            catch{
                print("Erro ao converter professor")
            }
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
        
        if(index >= 0){
            txtNome.text = teste1.nome
            txtEmail.text = teste1.email
        }
        
        
    }
    
    
}

