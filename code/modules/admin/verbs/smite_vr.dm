var/redspace_abduction_z

/area/redspace_abduction
	name = "Another Time And Place"
	requires_power = FALSE
	dynamic_lighting = FALSE

/proc/redspace_abduction(mob/living/target, user)
	if(redspace_abduction_z < 0)
		to_chat(user,"<span class='warning'>The abduction z-level is already being created. Please wait.</span>")
		return
	if(!redspace_abduction_z)
		redspace_abduction_z = -1
		to_chat(user,"<span class='warning'>This is the first use of the verb this shift, it will take a minute to configure the abduction z-level. It will be z[world.maxz+1].</span>")
		var/z = ++world.maxz
		for(var/x = 1 to world.maxx)
			for(var/y = 1 to world.maxy)
				var/turf/T = locate(x,y,z)
				new /area/redspace_abduction(T)
				T.ChangeTurf(/turf/unsimulated/fake_space)
				T.plane = -100
				CHECK_TICK
		redspace_abduction_z = z

	if(!target || !user)
		return

	var/size_of_square = 26
	var/halfbox = round(size_of_square*0.5)
	target.transforming = TRUE
	to_chat(target,"<span class='danger'>You feel a strange tug, deep inside. You're frozen in momentarily...</span>")
	to_chat(user,"<span class='notice'>Beginning vis_contents copy to abduction site, player mob is frozen.</span>")
	sleep(1 SECOND)
	//Lower left corner of a working box
	var/llc_x = max(0,halfbox-target.x) + min(target.x+halfbox, world.maxx) - size_of_square
	var/llc_y = max(0,halfbox-target.y) + min(target.y+halfbox, world.maxy) - size_of_square

	//Copy them all
	for(var/x = llc_x to llc_x+size_of_square)
		for(var/y = llc_y to llc_y+size_of_square)
			var/turf/T_src = locate(x,y,target.z)
			var/turf/T_dest = locate(x,y,redspace_abduction_z)
			T_dest.vis_contents.Cut()
			T_dest.vis_contents += T_src
			T_dest.density = T_src.density
			T_dest.opacity = T_src.opacity
			CHECK_TICK

	//Feather the edges
	for(var/x = llc_x to llc_x+1) //Left
		for(var/y = llc_y to llc_y+size_of_square)
			if(prob(50))
				var/turf/T = locate(x,y,redspace_abduction_z)
				T.density = FALSE
				T.opacity = FALSE
				T.vis_contents.Cut()

	for(var/x = llc_x+size_of_square-1 to llc_x+size_of_square) //Right
		for(var/y = llc_y to llc_y+size_of_square)
			if(prob(50))
				var/turf/T = locate(x,y,redspace_abduction_z)
				T.density = FALSE
				T.opacity = FALSE
				T.vis_contents.Cut()

	for(var/x = llc_x to llc_x+size_of_square) //Top
		for(var/y = llc_y+size_of_square-1 to llc_y+size_of_square)
			if(prob(50))
				var/turf/T = locate(x,y,redspace_abduction_z)
				T.density = FALSE
				T.opacity = FALSE
				T.vis_contents.Cut()

	for(var/x = llc_x to llc_x+size_of_square) //Bottom
		for(var/y = llc_y to llc_y+1)
			if(prob(50))
				var/turf/T = locate(x,y,redspace_abduction_z)
				T.density = FALSE
				T.opacity = FALSE
				T.vis_contents.Cut()

	target.forceMove(locate(target.x,target.y,redspace_abduction_z))
	to_chat(target,"<span class='danger'>The tug relaxes, but everything around you looks... slightly off.</span>")
	to_chat(user,"<span class='notice'>The mob has been moved. ([admin_jump_link(target,usr.client.holder)])</span>")

	target.transforming = FALSE
