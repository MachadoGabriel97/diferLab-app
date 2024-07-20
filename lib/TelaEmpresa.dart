import 'package:flutter/material.dart';

class TelaEmpresa extends StatefulWidget {
  const TelaEmpresa({super.key});

  @override
  State<TelaEmpresa> createState() => _TelaEmpresaState();
}

class _TelaEmpresaState extends State<TelaEmpresa> {
  @override
  static const  String _texto_descritivo_empresa = """
  \nLocalizada estrategicamente no coração financeiro da cidade, a ATM Consultoria é uma empresa renomada especializada na negociação de imóveis de alto padrão e veículos de luxo. Com anos de experiência no mercado, a ATM Consultoria destaca-se pela sua expertise em identificar oportunidades únicas e oferecer serviços personalizados que atendem às exigências dos clientes mais exigentes. 
  \nSeja para adquirir uma residência exclusiva com vistas deslumbrantes ou um automóvel de última geração, a ATM Consultoria garante um processo transparente e eficiente, com uma equipe de consultores altamente qualificados dedicados a cada transação. Compromisso com a Excelência: Na ATM Consultoria, o compromisso com a excelência está enraizado em cada aspecto do seu serviço. Cada transação é tratada com o mais alto nível de profissionalismo e discrição, assegurando a satisfação total dos clientes e construindo relações de confiança duradouras. 
  \nA ATM Consultoria não apenas facilita negociações, mas cria experiências únicas que refletem o estilo e as necessidades individuais de cada cliente, consolidando seu papel como líder no mercado de consultoria em imóveis e veículos de luxo.
    """;

  static const String _atm_holding = """ 
    \nHolding ATM: Como holding do grupo ATM, a ATM Consultoria não se limita apenas ao setor imobiliário e automotivo. Integrando-se com o ATM Bank, uma instituição financeira de prestígio reconhecida por suas soluções inovadoras e serviços bancários personalizados, a holding ATM oferece uma gama completa de serviços financeiros que  complementam suas atividades principais. 
    \nEssa sinergia estratégica permite à holding  ATM proporcionar aos seus clientes uma experiência completa e integrada, desde a compra do imóvel dos sonhos até a assistência financeira necessária para concretizar os seus objetivos.
    """;

  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text("Informações sobre a Empresa"),
        backgroundColor: Colors.grey,
      ),
      body: SingleChildScrollView(
        child: Center(
         child: Column(
           children: [
             Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Image.asset("imagens/logo.png"),
                    ],
                  ),
                  const Text(
                    _texto_descritivo_empresa,
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Image.asset("imagens/atm_holdings.jpg",
                        width: 100,),
                    ],
                  ),
                  const Text(
                    _atm_holding,
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),)
    );
  }
}
