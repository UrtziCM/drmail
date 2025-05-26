extends Node

const Illness = Classes.Illness

#var GameManager: Node = get_tree().get_first_node_in_group("GameManager")


const hello_statements: Array[String] = [
	"Buenas Dr. Mail,",
	"Estimado Dr. Mail,",
	"Hola,",
	"Por favor ayudenos Dr. Mail,"
]

const family_members: Array[String] = [
	"hijo",
	"hermano",
	"marido",
	"cuñado",
	"sobrino",
	"abuelo"
]

const bye_statements: Array[String] = [
	"Adios,",
	"Dios le bendiga,",
	"Que la luz guíe tu camino,"
	]

static func get_text_for_illness(illness: Illness) -> String:
	var salute = hello_statements.pick_random()
	var explanation: String = "Mi " + family_members.pick_random() + " tiene los siguiente sítomas:"
	
	for symptom in illness.symptoms:
		explanation += "\n\t - " + symptom.description
	
	var goodbye: String = bye_statements.pick_random()
	
	var full_card = salute + "\n\n" + explanation + "\n\n" + goodbye
	
	return full_card

static func create_card_panel(creator: Node2D):
	var gm = Engine.get_main_loop().get_first_node_in_group("GameManager")
	var card_panel = preload("res://src/instanceables/envelope/card_panel.tscn").instantiate()
	card_panel.get_node("Text").text = get_text_for_illness(creator.illness)
	card_panel.get_node("ExitButton").connect("pressed", creator._hide_envelope_contents)
	creator.panel = card_panel
	var send_list: ItemList = creator.panel.get_node("MixToSendList")
	for item in gm.saved_mix_dict.keys():
		send_list.add_item(item)
	var send_button = card_panel.get_node("SendButton")
	send_button.connect("pressed", send_button.get_parent().queue_free)
	send_button.connect("pressed", creator.queue_free)
	
	
	creator.add_child(card_panel)
	
