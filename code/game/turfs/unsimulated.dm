/turf/unsimulated
	name = "command"
	oxygen = MOLES_O2STANDARD
	nitrogen = MOLES_N2STANDARD
	initialized = TRUE // Don't call init on unsimulated turfs (at least not yet)

//VOREStation Add
/turf/unsimulated/fake_space
	name = "\proper space"
	icon = 'icons/turf/space.dmi'
	icon_state = "0"
	dynamic_lighting = FALSE

/turf/unsimulated/fake_space/New()
	..()
	icon_state = "[((x + y) ^ ~(x * y) + z) % 25]"
//VOREStation Add End