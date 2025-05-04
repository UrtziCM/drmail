extends Node

const Illness = Classes.Illness

const hello_statements: Array[String] = [
	"Buenas Dr. $name,",
	"Estimado Dr. $name,",
	"Hola,",
	"Por favor ayudenos Dr. $name,"
]

const one_symptom_explanation: Array[String] = [""]

const two_symptom_explanation: Array[String] = [""]

const bye_statements: Array[String] = [
	"Adios,",
	"Dios le bendiga,",
	"Que la luz guíe tu camino,"
	]

static func get_text_for_illness(illness: Illness) -> String:
	var salute = hello_statements.pick_random()
	var explanation: String
	if illness.symptoms.size() > 1:
		explanation = two_symptom_explanation.pick_random()
	else:
		explanation = one_symptom_explanation.pick_random()
	
	var goodbye: String = bye_statements.pick_random()
	
	var full_card = salute + "\n\n" + explanation + "\n\n" + goodbye
	
	return full_card

static func create_card_panel(creator: Node2D):
	var card_panel = preload("res://src/instanceables/envelope/card_panel.tscn").instantiate()
	card_panel.get_node("Text").text = get_text_for_illness(Illness.NAUSEA)
	card_panel.get_node("ExitButton").connect("pressed", creator._hide_envelope_contents)
	creator.panel = card_panel
	creator.add_child(card_panel)
	
