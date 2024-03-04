{pkgs, ...}:
{
	environment.interactiveShellInit = ''
		alias cyber='cd /home/hytx/Desktop/CYBERSEC/'
		alias tpas='cd /home/hytx/Desktop/CYBERSEC/"TEORIA E PRÁTICA DE ATAQUES DE SEGURANÇA"'
		alias fraude='cd /home/hytx/Desktop/CYBERSEC/"DETEÇÃO DE FRAUDE"'
		alias ops='cd /home/hytx/Desktop/CYBERSEC/"OPERAÇÕES DE SEGURANÇA"'
		alias segredes='cd /home/hytx/Desktop/CYBERSEC/"SEGURANÇA DE REDES"'
		alias cripto='cd /home/hytx/Desktop/CYBERSEC/"CRIPTOGRAFIA APLICADA"'
		alias ses='cd /home/hytx/Desktop/CYBERSEC/SEGURANÇA-EM-ENGENHARIA-SOFTWARE'
		alias ssd='cd /home/hytx/Desktop/CYBERSEC/SEGURANÇA-DE-SISTEMAS-E-DADOS'
		alias redes='cd /home/hytx/Desktop/CYBERSEC/TÓPICOS-AVANÇADOS-EM-REDES'
		alias sistemas='cd /home/hytx/Desktop/CYBERSEC/SISTEMAS-EMBUTIDOS'
		alias hardware='cd /home/hytx/Desktop/CYBERSEC/SEGURANÇA-E-APLICAÇÕES-DE-HARDWARE-CONFIÁVEL'
	'';
}