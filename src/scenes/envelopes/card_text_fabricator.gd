extends Node

const Illness = Classes.Illness
const Potion = Classes.Potion

@onready
var GameManager: Node = get_tree().get_first_node_in_group("GameManager")


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
	var explanation: String = "Mi " + family_members.pick_random() + " tiene los siguientes sítomas:"
	
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
	if gm.unlocked_potion_array().size() > 0:
		for item: Potion in gm.unlocked_potion_array():
			send_list.add_item(item._to_string())
	var send_button = card_panel.get_node("SendButton")
	
	
	send_button.connect("pressed", send.bind(creator,send_list))
	send_button.connect("pressed", send_button.get_parent().queue_free)
	send_button.connect("pressed", creator.queue_free)
	
	
	creator.add_child(card_panel)
	

static func send(creator: Node2D,send_list: ItemList):
	var gm = Engine.get_main_loop().get_first_node_in_group("GameManager")
	
	var selected_potions: Array[Potion] = []
	for potion_index in send_list.get_selected_items():
		var potion_name = send_list.get_item_text(potion_index)
		selected_potions.append(Potion.get_potion_by_name(potion_name.split(" ")[0])) # I use this cause potion name also contains effect (e.g. "Asfirox - Antibiótico")
	if creator.illness.apply_potions(selected_potions):
		gm.add_healed()
	else:
		gm.add_deceased()
	gm.add_envelope(creator)
