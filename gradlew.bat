use std::time::{Duration, Instant};
use std::thread;
use std::f64;

// Modos de operação do B12
#[derive(Debug, Clone, Copy)]
enum ModoOperacao {
    Ar,      // Rápido e invisível
    Tunel,   // Seguro mas lento
}

// Status de rastreamento
#[derive(Debug)]
struct Rastreamento {
    posicao_x: f64,
    posicao_y: f64,
    velocidade: f64,
    timestamp: Instant,
    modo: ModoOperacao,
}

// O B12 Digital
struct B12Digital {
    id: String,
    modo: ModoOperacao,
    invisivel: bool,
    historico_rastreamento: Vec<Rastreamento>,
}

impl B12Digital {
    fn novo(id: String) -> Self {
        B12Digital {
            id,
            modo: ModoOperacao::Ar,
            invisivel: true,  // Sempre invisível por padrão
            historico_rastreamento: Vec::new(),
        }
    }

    // Voar no ar digital - RÁPIDO
    fn voar(&mut self, destino_x: f64, destino_y: f64) {
        println!("\n🚀 B12 [{}] DECOLANDO no modo AR DIGITAL", self.id);
        println!("   Status: {}", if self.invisivel { "👻 INVISÍVEL" } else { "👁️  VISÍVEL" });
        
        let mut posicao_x = 0.0;
        let mut posicao_y = 0.0;
        let velocidade = 150.0; // Muito rápido!
        
        let dx = destino_x - posicao_x;
        let dy = destino_y - posicao_y;
        let distancia = (dx * dx + dy * dy).sqrt();
        let steps = (distancia / velocidade).ceil() as usize;
        
        for i in 0..=steps {
            let progresso = i as f64 / steps as f64;
            posicao_x = progresso * destino_x;
            posicao_y = progresso * destino_y;
            
            self.registrar_rastreamento(posicao_x, posicao_y, velocidade);
            
            if i % 3 == 0 {
                println!("   ✈️  Posição: ({:.1}, {:.1}) | Velocidade: {:.0} km/h", 
                    posicao_x, posicao_y, velocidade);
            }
            
            thread::sleep(Duration::from_millis(50)); // Rápido!
        }
        
        println!("   ✅ B12 chegou ao destino! ({:.1}, {:.1})", destino_x, destino_y);
    }

    // Modo túnel - SEGURO mas LENTO
    fn tunel(&mut self, destino_x: f64, destino_y: f64) {
        println!("\n🔒 B12 [{}] ENTRANDO NO TÚNEL SEGURO", self.id);
        println!("   Status: 🛡️  MÁXIMA SEGURANÇA");
        
        let mut posicao_x = 0.0;
        let mut posicao_y = 0.0;
        let velocidade = 30.0; // Lento mas seguro
        
        let dx = destino_x - posicao_x;
        let dy = destino_y - posicao_y;
        let distancia = (dx * dx + dy * dy).sqrt();
        let steps = (distancia / velocidade).ceil() as usize;
        
        for i in 0..=steps {
            let progresso = i as f64 / steps as f64;
            posicao_x = progresso * destino_x;
            posicao_y = progresso * destino_y;
            
            self.registrar_rastreamento(posicao_x, posicao_y, velocidade);
            
            if i % 2 == 0 {
                println!("   🔐 Posição: ({:.1}, {:.1}) | Criptografia ativa", 
                    posicao_x, posicao_y);
            }
            
            thread::sleep(Duration::from_millis(200)); // Mais lento
        }
        
        println!("   ✅ B12 saiu do túnel com segurança! ({:.1}, {:.1})", destino_x, destino_y);
    }

    // Sistema "ACHO TUDO" - Rastreamento
    fn registrar_rastreamento(&mut self, x: f64, y: f64, vel: f64) {
        let rastreio = Rastreamento {
            posicao_x: x,
            posicao_y: y,
            velocidade: vel,
            timestamp: Instant::now(),
            modo: self.modo,
        };
        self.historico_rastreamento.push(rastreio);
    }

    fn mostrar_rastreamento(&self) {
        println!("\n📡 SISTEMA 'ACHO TUDO' - RASTREAMENTO COMPLETO");
        println!("   B12 ID: {}", self.id);
        println!("   Total de pontos rastreados: {}", self.historico_rastreamento.len());
        
        if let Some(ultimo) = self.historico_rastreamento.last() {
            println!("   Última posição: ({:.1}, {:.1})", ultimo.posicao_x, ultimo.posicao_y);
            println!("   Velocidade atual: {:.0} km/h", ultimo.velocidade);
            println!("   Modo: {:?}", ultimo.modo);
        }
    }

    // Alternar modo de operação
    fn alternar_modo(&mut self) {
        self.modo = match self.modo {
            ModoOperacao::Ar => {
                println!("\n🔄 Mudando para modo TÚNEL (seguro)");
                ModoOperacao::Tunel
            },
            ModoOperacao::Tunel => {
                println!("\n🔄 Mudando para modo AR (rápido)");
                ModoOperacao::Ar
            }
        };
    }

    // Transmitir dados (simulação)
    fn transmitir_dados(&self, dados: &str) {
        println!("\n📤 TRANSMITINDO DADOS");
        println!("   Modo: {:?}", self.modo);
        println!("   Invisível: {}", if self.invisivel { "SIM ✅" } else { "NÃO ❌" });
        println!("   Payload: \"{}\"", dados);
        
        match self.modo {
            ModoOperacao::Ar => {
                println!("   ⚡ Transmissão no AR - ULTRA RÁPIDA!");
                thread::sleep(Duration::from_millis(100));
            },
            ModoOperacao::Tunel => {
                println!("   🔒 Transmissão no TÚNEL - ULTRA SEGURA!");
                thread::sleep(Duration::from_millis(500));
            }
        }
        
        println!("   ✅ Dados transmitidos com sucesso!");
    }
}

fn main() {
    println!("╔═══════════════════════════════════════╗");
    println!("║     🚀 B12 DIGITAL - SISTEMA V1.0    ║");
    println!("║      Feito em Rust - 100% Nativo     ║");
    println!("╚═══════════════════════════════════════╝");

    // Criar B12
    let mut b12 = B12Digital::novo("B12-ALPHA".to_string());

    // Demonstração 1: Voo rápido no AR
    println!("\n═══ DEMONSTRAÇÃO 1: VOO NO AR DIGITAL ═══");
    b12.voar(100.0, 75.0);
    b12.mostrar_rastreamento();

    // Transmitir dados no modo ar
    b12.transmitir_dados("HTTPS://exemplo.com/dados-secretos");

    // Demonstração 2: Modo túnel seguro
    println!("\n═══ DEMONSTRAÇÃO 2: MODO TÚNEL SEGURO ═══");
    b12.alternar_modo();
    b12.tunel(200.0, 150.0);
    b12.mostrar_rastreamento();

    // Transmitir dados no modo túnel
    b12.transmitir_dados("Informações classificadas - Nível 5");

    // Voltar ao modo ar
    println!("\n═══ DEMONSTRAÇÃO 3: RETORNO AO MODO AR ═══");
    b12.alternar_modo();
    b12.voar(300.0, 250.0);
    
    // Relatório final
    println!("\n╔═══════════════════════════════════════╗");
    println!("║       📊 RELATÓRIO FINAL DO B12      ║");
    println!("╚═══════════════════════════════════════╝");
    b12.mostrar_rastreamento();
    
    println!("\n✨ B12 Digital operando perfeitamente!");
    println!("   - Modo AR: Rápido e Invisível ✅");
    println!("   - Modo TÚNEL: Lento mas Seguro ✅");
    println!("   - Sistema ACHO TUDO: Ativo ✅");
}



