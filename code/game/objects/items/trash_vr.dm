// Custom garbage or whatever

/obj/item/trash/attack(mob/living/M as mob, mob/living/user as mob)
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(H.species.trashcan == 1)
			playsound(H.loc,'sound/items/eatfood.ogg', rand(10,50), 1)
			user.drop_item()
			forceMove(H.vore_selected)
			to_chat(H, "<span class='notice'>You can taste the flavor of garbage. Wait what?</span>")
			return
