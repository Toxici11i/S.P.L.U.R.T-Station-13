#define CUM_TARGET_NIPPLE "nipple"
#define CUM_TARGET_URETHRA "urethra"
#define CUM_TARGET_THIGHS "thighs"
#define CUM_TARGET_BELLY "belly"
#define CUM_TARGET_ARMPIT "armpit"

/mob/living
	var/has_belly = FALSE

/mob/living/proc/has_belly(var/nintendo = REQUIRE_ANY)
	var/mob/living/carbon/C = src
	if(has_belly && !istype(C))
		return TRUE
	if(istype(C))
		var/obj/item/organ/genital/peepee = C.getorganslot(ORGAN_SLOT_BELLY)
		if(peepee)
			switch(nintendo)
				if(REQUIRE_ANY)
					return TRUE
				if(REQUIRE_EXPOSED)
					if(peepee.is_exposed())
						return TRUE
					else
						return FALSE
				if(REQUIRE_UNEXPOSED)
					if(!peepee.is_exposed())
						return TRUE
					else
						return FALSE
				else
					return TRUE
	return FALSE

/mob/living/cum(mob/living/partner, target_orifice)
	var/message
	//var/u_His = p_their()
	//var/u_He = p_they()
	//var/u_S = p_s()
	//var/t_His = partner?.p_their()
	var/cumin = FALSE
	var/obj/item/organ/genital/target_gen
	var/mob/living/carbon/c_partner
	var/cum_the_II = FALSE //If the cumming interaction is fully handled here or goes back to ..()
	//Carbon checks
	if(iscarbon(partner))
		c_partner = partner

	if(src != partner)
		if(!last_genital)
			if(has_penis())
				if(!istype(partner))
					target_orifice = null
				switch(target_orifice)
					if(CUM_TARGET_NIPPLE)
						cum_the_II = TRUE
						cumin = TRUE
						if(partner.has_breasts())
							message = "cums iside \the <b>[partner]</b>'s nipple!."
							target_gen = partner.getorganslot(ORGAN_SLOT_BREASTS)
						else
							message = "cums on \the <b>[partner]</b>'s chest and neck."
							if((partner.client?.prefs.cit_toggles & BREAST_ENLARGEMENT) && c_partner)
								target_gen = new /obj/item/organ/genital/breasts
								target_gen.Insert(c_partner)
						if(target_gen)
							target_gen.climax_modify_size(src, getorganslot(ORGAN_SLOT_PENIS))
					if(CUM_TARGET_URETHRA)
						cum_the_II = TRUE
						cumin = TRUE
						message = "cums down \the <b>[partner]</b>'s [pick(GLOB.dick_nouns + list("[pick("cock", "dick")]hole", "urethra"))]!"
						if(c_partner)
							target_gen = partner.getorganslot(ORGAN_SLOT_PENIS)
							target_gen.climax_modify_size(src, getorganslot(ORGAN_SLOT_PENIS))
					if(CUM_TARGET_THIGHS)
						cum_the_II = TRUE
						if(partner.has_legs() >= 2)
							message = "cums right into \the <b>[partner]</b>'s thighs!"
						else
							message = "cums... somehow..."
					if(CUM_TARGET_BELLY)
						cumin = TRUE
						cum_the_II = TRUE
						if(partner.has_belly(REQUIRE_EXPOSED))
							message = "cums into the <b>[partner]</b>'s navel, [pick(list("making it into a massive pond of jizz", "[p_their()] spunk drooling out of it"))]."
							if(c_partner)
								target_gen = c_partner.getorganslot(ORGAN_SLOT_BELLY)
						else
							message = "cums on the <b>[partner]</b>'s midsection."
						if(c_partner)
							if(partner.client?.prefs.cit_toggles & BELLY_INFLATION)
								var/obj/item/organ/genital/belly/gut = partner.getorganslot(ORGAN_SLOT_BELLY)
								if(!gut)
									gut = new
									gut.Insert(partner)
								gut.climax_modify_size(src, getorganslot(ORGAN_SLOT_PENIS), target_orifice)
							else if((partner.client?.prefs.cit_toggles & BUTT_ENLARGEMENT) && target_orifice == CUM_TARGET_ANUS)
								var/obj/item/organ/genital/butt/ass = partner.getorganslot(ORGAN_SLOT_BUTT)
								if(!ass)
									ass = new
									ass.Insert(partner)
								ass.climax_modify_size(src, getorganslot(ORGAN_SLOT_PENIS))
					if(CUM_TARGET_ARMPIT)
						cum_the_II = TRUE
						message = "cums under \the <b>[partner]</b>'s armpit"

					if(CUM_TARGET_MOUTH, CUM_TARGET_THROAT, CUM_TARGET_VAGINA, CUM_TARGET_ANUS)
						if(c_partner)
							if(partner.client?.prefs.cit_toggles & BELLY_INFLATION)
								var/obj/item/organ/genital/belly/gut = partner.getorganslot(ORGAN_SLOT_BELLY)
								if(!gut)
									gut = new
									gut.Insert(partner)
								gut.climax_modify_size(src, getorganslot(ORGAN_SLOT_PENIS), target_orifice)
							else if((partner.client?.prefs.cit_toggles & BUTT_ENLARGEMENT) && target_orifice == CUM_TARGET_ANUS)
								var/obj/item/organ/genital/butt/ass = partner.getorganslot(ORGAN_SLOT_BUTT)
								if(!ass)
									ass = new
									ass.Insert(partner)
								ass.climax_modify_size(src, getorganslot(ORGAN_SLOT_PENIS))
		else
			switch(last_genital.type)
				if(/obj/item/organ/genital/penis)
					if(!istype(partner))
						target_orifice = null
					switch(target_orifice)
						if(CUM_TARGET_NIPPLE)
							cumin = TRUE
							cum_the_II = TRUE
							if(partner.has_breasts())
								message = "cums iside \the <b>[partner]</b>'s nipple!."
								target_gen = partner.getorganslot(ORGAN_SLOT_BREASTS)
							else
								message = "cums on \the <b>[partner]</b>'s chest and neck."
								if((partner.client?.prefs.cit_toggles & BREAST_ENLARGEMENT) && c_partner)
									target_gen = new /obj/item/organ/genital/breasts
									target_gen.Insert(partner)

							if(target_gen)
								target_gen.climax_modify_size(src, last_genital)
						if(CUM_TARGET_URETHRA)
							cum_the_II = TRUE
							cumin = TRUE
							message = "cums down \the <b>[partner]</b>'s [pick(GLOB.dick_nouns + list("[pick("cock", "dick")]hole", "urethra"))]!"
							if(c_partner)
								target_gen = partner.getorganslot(ORGAN_SLOT_PENIS)
								target_gen.climax_modify_size(src, last_genital)
						if(CUM_TARGET_THIGHS)
							cum_the_II = TRUE
							if(partner.has_legs() >= 2)
								message = "cums right into \the <b>[partner]</b>'s thighs!"
							else
								message = "cums... somehow..."
						if(CUM_TARGET_BELLY)
							cum_the_II = TRUE
							cumin = TRUE
							if(partner.has_belly(REQUIRE_EXPOSED))
								message = "cums into the <b>[partner]</b>'s navel, [pick(list("making it into a massive pond of jizz", "[p_their()] spunk drooling out of it"))]."
								if(c_partner)
									target_gen = c_partner.getorganslot(ORGAN_SLOT_BELLY)
							else
								message = "cums on the <b>[partner]</b>'s midsection."
							if(c_partner)
								if(partner.client?.prefs.cit_toggles & BELLY_INFLATION)
									var/obj/item/organ/genital/belly/gut = partner.getorganslot(ORGAN_SLOT_BELLY)
									if(!gut)
										gut = new
										gut.Insert(partner)
									gut.climax_modify_size(src, last_genital, target_orifice)
								else if((partner.client?.prefs.cit_toggles & BUTT_ENLARGEMENT) && target_orifice == CUM_TARGET_ANUS)
									var/obj/item/organ/genital/butt/ass = partner.getorganslot(ORGAN_SLOT_BUTT)
									if(!ass)
										ass = new
										ass.Insert(partner)
									ass.climax_modify_size(src, last_genital)

						if(CUM_TARGET_MOUTH, CUM_TARGET_THROAT, CUM_TARGET_VAGINA, CUM_TARGET_ANUS)
							if(c_partner)
								if(partner.client?.prefs.cit_toggles & BELLY_INFLATION)
									var/obj/item/organ/genital/belly/gut = partner.getorganslot(ORGAN_SLOT_BELLY)
									if(!gut)
										gut = new
										gut.Insert(partner)
									gut.climax_modify_size(src, last_genital, target_orifice)
								else if((partner.client?.prefs.cit_toggles & BUTT_ENLARGEMENT) && target_orifice == CUM_TARGET_ANUS)
									var/obj/item/organ/genital/butt/ass = partner.getorganslot(ORGAN_SLOT_BUTT)
									if(!ass)
										ass = new
										ass.Insert(partner)
									ass.climax_modify_size(src, last_genital)
	if(!cum_the_II)
		return ..()
	if(gender == MALE)
		playlewdinteractionsound(loc, pick('modular_sand/sound/interactions/final_m1.ogg',
							'modular_sand/sound/interactions/final_m2.ogg',
							'modular_sand/sound/interactions/final_m3.ogg',
							'modular_sand/sound/interactions/final_m4.ogg',
							'modular_sand/sound/interactions/final_m5.ogg'), 90, 1, 0)
	else if(gender == FEMALE)
		playlewdinteractionsound(loc, pick('modular_sand/sound/interactions/final_f1.ogg',
							'modular_sand/sound/interactions/final_f2.ogg',
							'modular_sand/sound/interactions/final_f3.ogg'), 70, 1, 0)
	else
		playlewdinteractionsound(loc, pick('modular_sand/sound/interactions/final_f1.ogg',
							'modular_sand/sound/interactions/final_f2.ogg',
							'modular_sand/sound/interactions/final_f3.ogg'), 70, 1, 0)
	visible_message(message = "<span class='userlove'><b>\The [src]</b> [message]</span>", ignored_mobs = get_unconsenting())
	multiorgasms += 1

	if(multiorgasms > (get_sexual_potency() * 0.34)) //AAAAA, WE DONT WANT NEGATIVES HERE, RE
		refractory_period = world.time + rand(300, 900) - get_sexual_potency()//sex cooldown
		// set_drugginess(rand(20, 30))
	else
		refractory_period = world.time + rand(300, 900) - get_sexual_potency()
		// set_drugginess(rand(5, 10))
	if(multiorgasms < get_sexual_potency())
		if(ishuman(src))
			var/mob/living/carbon/human/H = src
			if(!partner)
				H.mob_climax(TRUE, "masturbation", "none")
			else
				H.mob_climax(TRUE, "sex", partner, !cumin, target_gen)
	set_lust(0)
	SEND_SIGNAL(src, COMSIG_MOB_CAME, target_orifice, partner)

/mob/living/get_unconsenting(extreme, list/ignored_mobs, var/unholy)
	for(var/mob/M in range(7, src))
		if(M.client)
			var/client/cli = M.client
			if(unholy && (cli.prefs.unholypref == "No"))
				LAZYADD(ignored_mobs, M)
	. = ..()

/mob/living/proc/has_legs(nintendo = REQUIRE_ANY)
	var/legs = has_left_leg() + has_right_leg()
	if(legs)
		switch(nintendo)
			if(REQUIRE_EXPOSED)
				if(is_bottomless())
					return legs
			if(REQUIRE_UNEXPOSED)
				if(!is_bottomless())
					return legs
			if(REQUIRE_ANY)
				return legs
	return FALSE

// Interaction Procs

/mob/living/proc/do_oral_self(mob/living/user, var/fucktarget = "penis")
	var/message
	var/obj/item/organ/genital/peepee = null
	var/lust_increase = NORMAL_LUST
	var/t_His = p_their()
	var/t_Him = p_them()

	if(user.is_fucking(src, CUM_TARGET_MOUTH))
		if(prob(user.get_sexual_potency()))
			if(istype(src, /mob/living)) // Argh.
				var/mob/living/H = src
				H.adjustOxyLoss(3)
			message = "sucks [t_Him]self off"
			lust_increase += 5
		else
			var/improv = FALSE
			switch(fucktarget)
				if("vagina")
					if(user.has_vagina())
						message = pick(
							"licks [t_His] pussy.",
							"runs their tongue up the shape of [t_His] pussy.",
							"traces [t_His] slit with their tongue.",
							"darts the tip of their tongue around [t_His] clit.",
							"laps slowly at [t_Him].",
							"kisses [t_His] delicate folds.",
							"tastes [t_Him].",
						)
					else
						improv = TRUE
				if("penis")
					if(user.has_penis())
						message = pick(
							"sucks [t_Him] off.",
							"runs their tongue up the shape of [t_His] cock.",
							"traces [t_His] cock with their tongue.",
							"darts the tip of their tongue around tip of [t_His] cock.",
							"laps slowly at [t_His] shaft.",
							"kisses the base of [t_His] shaft.",
							"takes [t_Him] deeper into their mouth.",
						)
					else
						improv = TRUE
			if(improv)
				// get confused about how to do the sex
				message = pick(
					"licks [t_Him].",
					"looks a little unsure of where to lick [t_Him].",
					"runs their tongue between [t_His] legs.",
					"kisses [t_His] thigh.",
					"tries their best with [t_Him].",
				)
	else
		var/improv = FALSE
		switch(fucktarget)
			if("vagina")
				if(user.has_vagina())
					message = pick(
						"buries their face in [t_His] pussy.",
						"nuzzles [t_His] wet sex.",
						"finds their face caught between [t_His] thighs.",
						"kneels down between [t_His] legs.",
						"grips [t_His] legs, pushing them apart.",
						"sinks their face in between [t_His] thighs.",
					)
				else
					improv = TRUE
			if("penis")
				if(user.has_penis())
					message = pick(
						"takes [t_His] cock into their mouth.",
						"wraps their lips around [t_His] cock.",
						"finds their face between [t_His] thighs.",
						"kneels down between [t_His] legs.",
						"grips [t_His] legs, kissing at the tip of their cock.",
						"goes down on [t_Him].",
					)
				else
					improv = TRUE
		if(improv)
			message = pick(
				"begins to lick [t_His].",
				"starts kissing [t_His] thigh.",
				"sinks down between [t_His] thighs.",
				"briefly flashes a puzzled look from between [t_His] legs.",
				"looks unsure of how to handle [t_His] lack of genitalia.",
				"seems like they were expecting [t_His] to have a cock or a pussy or ... something.",
			)
			peepee = null
		else
			if(ishuman(user))
				var/mob/living/carbon/human/pardner = user
				switch(fucktarget)
					if("vagina")
						peepee = pardner.getorganslot(ORGAN_SLOT_VAGINA)
					if("penis")
						peepee = pardner.getorganslot(ORGAN_SLOT_PENIS)
		user.set_is_fucking(src, CUM_TARGET_MOUTH, peepee)

	playlewdinteractionsound(get_turf(src), pick('modular_sand/sound/interactions/bj1.ogg',
									'modular_sand/sound/interactions/bj2.ogg',
									'modular_sand/sound/interactions/bj3.ogg',
									'modular_sand/sound/interactions/bj4.ogg',
									'modular_sand/sound/interactions/bj5.ogg',
									'modular_sand/sound/interactions/bj6.ogg',
									'modular_sand/sound/interactions/bj7.ogg',
									'modular_sand/sound/interactions/bj8.ogg',
									'modular_sand/sound/interactions/bj9.ogg',
									'modular_sand/sound/interactions/bj10.ogg',
									'modular_sand/sound/interactions/bj11.ogg'), 50, 1, -1)
	visible_message(message = "<span class='lewd'><b>\The [src]</b> [message]</span>", ignored_mobs = get_unconsenting())
	user.handle_post_sex(lust_increase, CUM_TARGET_MOUTH, src)
	lust_increase = NORMAL_LUST //RESET IT REE

/mob/living/proc/do_breastfuck_self(mob/living/user)
	var/message
	var/t_His = p_their()

	if(is_fucking(user, CUM_TARGET_BREASTS))
		message = "[pick("fucks [t_His] breasts.",
			"grinds their cock between [t_His] boobs.",
			"thrusts into [t_His] tits.",
			"grabs [t_His] breasts together and presses their dick between them.")]"
	else
		message = "pushes [t_His] breasts together and presses their dick between them."
		set_is_fucking(user, CUM_TARGET_BREASTS, getorganslot(ORGAN_SLOT_PENIS) ? getorganslot(ORGAN_SLOT_PENIS) : null)

	playlewdinteractionsound(loc, pick('modular_sand/sound/interactions/bang1.ogg',
						'modular_sand/sound/interactions/bang2.ogg',
						'modular_sand/sound/interactions/bang3.ogg'), 70, 1, -1)
	visible_message(message = "<span class='lewd'><b>\The [src]</b> [message]</span>", ignored_mobs = get_unconsenting())
	handle_post_sex(NORMAL_LUST, CUM_TARGET_BREASTS, user)

/mob/living/proc/remove_equipment(mob/living/carbon/target)
	var/obj/item/organ/genital/holder = pick_receiving_organ(target, HAS_EQUIPMENT, "Remove equipment", "What genital?")
	if(!holder)
		to_chat(src, "<span class='warning'> You need exposed genitals!</b>")
		return
	if(!LAZYLEN(holder.equipment))
		to_chat(src, "<span class='warning'>You'll have to put something in it first, since it seems to be clean</span>")
		return

	var/obj/item/gimme = input(src, "What do you want to remove?", "Remove equipment", null) as null|anything in holder.equipment
	if(gimme)
		holder.remove_equipment(src, gimme)

/mob/living/proc/nuzzle_belly(mob/living/target)
	var/message
	var/u_His = p_their()
	var/list/belly_names = list("stomach", "belly", "gut", "midsection", "rolls")
	var/list/nuzzles = list(
		"rubs [u_His] face all accross [target]'s [pick(belly_names)]",
		"nuzzles [target]'s [pick(belly_names)][pick(list(" lovingly", ""))]",
		"shoves [u_His] face into [target]'s [pick(belly_names)] and gives it kisses all over",
		"licks right into [target]'s [pick(list("belly button", "navel"))]"
		)

	message = "<span class='lewd'><b>\The [src]</b> [pick(nuzzles)]. </span>"
	visible_message(message, ignored_mobs = get_unconsenting())

/mob/living/proc/do_bellyfuck(mob/living/partner)
	var/message

	if(is_fucking(partner, CUM_TARGET_BELLY))
		message = "[pick(
			"pounds \the <b>[partner]</b>'s belly.",
			"shoves their dick deep into \the <b>[partner]</b>'s soft tummy",
			"thrusts in and out of \the <b>[partner]</b>'s navel.",
			"goes balls deep into \the <b>[partner]</b>'s gut over and over again.")]"
	else
		message = "pulls his cock up and slides it into \the <b>[partner]</b>'s receiving navel."
		set_is_fucking(partner, CUM_TARGET_BELLY, getorganslot(ORGAN_SLOT_PENIS) ? getorganslot(ORGAN_SLOT_PENIS) : null)

	playlewdinteractionsound(loc, pick('modular_sand/sound/interactions/champ1.ogg',
						'modular_sand/sound/interactions/champ2.ogg'), 50, 1, -1)
	visible_message(message = "<span class='lewd'><b>\The [src]</b> [message]</span>", ignored_mobs = get_unconsenting())
	handle_post_sex(NORMAL_LUST, CUM_TARGET_BELLY, partner)
	//partner.handle_post_sex(NORMAL_LUST, null, src) //don't think we need it fo dis one

/mob/living/proc/do_breastsmother(mob/living/target)
	var/message
	var/u_His = p_their()
	var/list/lines = list(
		"squishes <b>[target]</b>'s face [pick(list("in between", "with"))] [u_His] [pick(GLOB.breast_nouns)]",
		"presses [u_His] [pick(GLOB.breast_nouns)] into \the <b>[target]</b>'s face",
		"shoves \the <b>[target]</b>'s whole head into [u_His] cleavage"
		)

	message = "<span class='lewd'>\The <b>[src]</b> [pick(lines)]</span>"
	visible_message(message, ignored_mobs = get_unconsenting())
	playlewdinteractionsound(loc, pick('modular_sand/sound/interactions/bang1.ogg',
						'modular_sand/sound/interactions/bang2.ogg',
						'modular_sand/sound/interactions/bang3.ogg'), 70, 1, -1)

/mob/living/proc/lick_sweat(mob/living/target)
	var/message
	var/t_His = target.p_their()
	var/list/lines = list("licks \the <b>[target]</b>'s sweat off [t_His] body",
							"slurps the salty sweat running through <b>[target]</b>'s skin",
							"has a nice taste of \the <b>[target]</b>'s drenched body",
							"takes a whiff of \the <b>[target]</b>'s musk and drinks [t_His] warm sweat")

	message = "<span class='lewd'>\The <b>[src]</b> [pick(lines)]</span>"
	visible_message(message, ignored_mobs = get_unconsenting())
	playlewdinteractionsound(loc, 'modular_sand/sound/interactions/champ_fingering.ogg', 50, 1, -1)

/mob/living/proc/smother_armpit(mob/living/target)
	var/message
	var/u_His = p_their()
	var/list/musk = list("musky ", "sweaty ", "damp ", "smelly ", "")
	var/list/lines = list(
		"shoves \the <b>[target]</b>'s face in [u_His] [pick(musk)] armpit",
		"squeezes \the <b>[target]</b>'s nose under [u_His] [pick(musk)] pit",
		"makes sure to squeeze \the <b>[target]</b>'s face well under [u_His] [pick(musk)] armpit and let them take a whiff"
		)

	message = "<span class='lewd'>\The <b>[src]</b> [pick(lines)]</span>"
	visible_message(message, ignored_mobs = get_unconsenting())
	playlewdinteractionsound(loc, pick(
		'modular_sand/sound/interactions/squelch1.ogg',
		'modular_sand/sound/interactions/squelch2.ogg',
		'modular_sand/sound/interactions/squelch3.ogg'), 50, 1, -1)

/mob/living/proc/lick_armpit(mob/living/target)
	var/message
	var/u_His = p_their()
	var/list/musk = list("musky ", "sweaty ", "damp ", "smelly ", "")
	var/list/lines = list(
		"shoves [u_His] nose deep into \the <b>[target]</b>'s armpit, giving it a big [pick(list("whiff", "lick", "nuzzle"))].",
		"presses [u_His] face under \the <b>[target]</b>'s [pick(musk)] pit, [pick(list("tasting and lapping it all over", "sniffing its scent"))]",
		"goes face deep into \the <b>[target]</b> [pick(musk)] armpit, worshipping it with [u_His] tongue and nose"
	)

	message = "<span class='lewd'>\The <b>[src]</b> [pick(lines)]</span>"
	visible_message(message, ignored_mobs = get_unconsenting())
	playlewdinteractionsound(loc, pick(
		'modular_sand/sound/interactions/squelch1.ogg',
		'modular_sand/sound/interactions/squelch2.ogg',
		'modular_sand/sound/interactions/squelch3.ogg'), 50, 1, -1)

/mob/living/proc/fuck_armpit(mob/living/target)
	var/message
	var/u_His = p_their()
	var/t_His = target.p_their()
	var/list/musk = list("musky ", "sweaty ", "damp ", "smelly ", "")
	var/list/lines

	if(is_fucking(target, CUM_TARGET_ARMPIT))
		lines = list(
			" slides [u_His] [pick(GLOB.dick_nouns)] back and forth under \the <b>[target]</b>'s [pick(musk)] armpit",
			"'s cock drools pre all over \the <b>[target]</b>'s [pick(musk)] armpit, thoroughly fucking its warm embrace",
			" shoves [u_His] [pick(GLOB.dick_nouns)] under \the <b>[target]</b>'s arm, using [t_His] [pick(musk)] pit like a fleshlight"
		)
	else
		if(target.is_topless())
			lines = list(
				" presents [u_His] [pick(GLOB.dick_nouns)] to \the <b>[target]</b>'s [pick(musk)] armpit, beginning to thrust its whole length right under [t_His] arm!"
			)
		else // https://cdn.discordapp.com/attachments/802990353883070474/962478553117622322/NoName-480p.mp4
			lines = list(
				" rips a hole through \the <b>[target]</b>'s clothes so [t_His] armpit is exposed. \The <b>[target]</b> can suddenly feel the warmth of \the <b>[src]</b>' throbbing [pick(GLOB.dick_nouns)] sliding all the way into [t_His] [pick(musk)] pit!"
			)
		set_is_fucking(target, CUM_TARGET_ARMPIT, getorganslot(ORGAN_SLOT_PENIS))

	message = "<span class='lewd'>\The <b>[src]</b>[pick(lines)]</span>"
	visible_message(message, ignored_mobs = get_unconsenting())
	playlewdinteractionsound(loc, pick('modular_sand/sound/interactions/bang1.ogg',
						'modular_sand/sound/interactions/bang2.ogg',
						'modular_sand/sound/interactions/bang3.ogg'), 70, 1, -1)
	handle_post_sex(NORMAL_LUST, CUM_TARGET_ARMPIT, target)

/mob/living/proc/do_pitjob(mob/living/target)
	var/message
	var/list/musk = list("musky ", "sweaty ", "damp ", "smelly ", "")
	var/u_His = p_their()
	var/t_His = target.p_their()
	var/list/lines

	if(is_fucking(target, CUM_TARGET_ARMPIT))
		lines = list(
			"squeezes [u_His] armpit right into \the <b>[target]</b>'s throbbing [pick(GLOB.dick_nouns)], massaging its length using [u_His] [pick(musk)]armpit!",
			"presses [u_His] arm down all over \the <b>[target]</b>'s leaking [pick(GLOB.dick_nouns)], milking it with [u_His] [pick(musk)] pit!",
			"rubs and grinds [u_His] [pick(musk)] arpit back and forth through \the <b>[target]</b>'s [pick(GLOB.dick_nouns)], deeply squeezing it to the base!"
		)
	else
		if(target.is_topless())
			lines = list(
				"presents [u_His] [pick(musk)] armpit to \the <b>[target]</b>, lifting [u_His] arm up before clamping it down into [t_His] [pick(GLOB.dick_nouns)] with a deep squeeze!",
			)
		else // https://cdn.discordapp.com/attachments/802990353883070474/962478553117622322/NoName-480p.mp4
			lines = list(
				"softly tears a hole in the cloth on the back of [u_His] armpit, suffing \the <b>[target]</b>'s whole rod right into it with a [pick(musk)] embrace!"
			)
		target.set_is_fucking(src, CUM_TARGET_ARMPIT, target.getorganslot(ORGAN_SLOT_PENIS))

	message = "<span class='lewd'>\The <b>[src]</b> [pick(lines)]</span>"
	visible_message(message, ignored_mobs = get_unconsenting())
	playlewdinteractionsound(loc, pick('modular_sand/sound/interactions/bang1.ogg',
						'modular_sand/sound/interactions/bang2.ogg',
						'modular_sand/sound/interactions/bang3.ogg'), 70, 1, -1)
	target.handle_post_sex(NORMAL_LUST, CUM_TARGET_ARMPIT, src)

/mob/living/proc/do_boobjob(mob/living/target)
	var/message
	var/u_His = p_their()
	var/list/lines

	if(target.is_fucking(src, CUM_TARGET_BREASTS))
		lines = list(
			"slides [u_His] [pick(GLOB.breast_nouns)], up and down through \the <b>[target]</b>'s throbbing cock",
			"squeezes [u_His] [pick(GLOB.breast_nouns)] through all of \the <b>[target]</b>'s lenght",
			"jerks \the <b>[target]</b> off lustfully with [u_His] supple [pick(GLOB.breast_nouns)]"
		)
	else
		lines = list(
			"clamps [u_His] [pick(GLOB.breast_nouns)] around \the <b>[target]</b>'s throbbing cock, wrapping it in their sheer warmth",
			"envelops \the <b>[target]</b>'s hard member with [u_His] soft [pick(GLOB.breast_nouns)], giving it a tight and sloshing squeeze",
			"lets [u_His] [pick(GLOB.breast_nouns)] fall into \the <b>[target]</b>'s fat cock, smothering it in [u_His] cleavage"
		)
		target.set_is_fucking(src, CUM_TARGET_BREASTS, getorganslot(ORGAN_SLOT_PENIS))

	message = "<span class='lewd'>\The <b>[src]</b> [pick(lines)]</span>"
	visible_message(message, ignored_mobs = get_unconsenting())
	playlewdinteractionsound(loc, pick('modular_sand/sound/interactions/bang1.ogg',
						'modular_sand/sound/interactions/bang2.ogg',
						'modular_sand/sound/interactions/bang3.ogg'), 70, 1, -1)
	target.handle_post_sex(NORMAL_LUST, CUM_TARGET_BREASTS, src)

/mob/living/proc/lick_nuts(mob/living/target)
	var/message
	var/u_His = p_their()
	var/t_His = target.p_their()
	var/lust_increase = 1
	var/list/balls = list("balls", "nuts", "[pick(list("cum", "spunk", "nut", "jizz", "seed"))] [pick(list("orbs", "spheres", "tanks", "holders", "churners"))]")
	var/list/lines

	if(target.is_fucking(src, NUTS_TO_FACE))
		lines = list(
			"worships \the <b>[target]</b>'s [pick(balls)] with [u_His] tongue",
			"takes a huff of \the <b>[target]</b>'s heavy ball musk and proceeds to lap the sweat off [t_His] [pick(balls)]",
			"plants smooches all over \the <b>[target]</b>'s heavy [pick(balls)], tasting [t_His] nutsack and massaging it with [u_His] lips"
		)
	else
		lines = list(
			"opens [u_His] maw and proceeds to bring \the <b>[target]</b>'s [pick(balls)] right in",
			"uses [u_His] tongue to fit \the <b>[target]</b>'s balls in [u_His] mouth, deeply huffing their scent",
			"willingly lets \the <b>[target]</b>'s [pick(balls)] fall into and fill [u_His] mouth, lustfully sucking into them"
		)
		target.set_is_fucking(src, NUTS_TO_FACE, getorganslot(ORGAN_SLOT_PENIS))

	message = "<span class='lewd'>\The <b>[src]</b> [pick(lines)]</span>"
	visible_message(message, ignored_mobs = get_unconsenting())
	target.handle_post_sex(lust_increase, CUM_TARGET_MOUTH, src)

/mob/living/proc/do_cockfuck(mob/living/target)
	var/message
	var/u_His = p_their()
	var/t_His = target.p_their()
	var/list/cock = GLOB.dick_nouns
	var/list/lines
	var/list/noises = list(
		'modular_sand/sound/interactions/bang1.ogg',
		'modular_sand/sound/interactions/bang2.ogg',
		'modular_sand/sound/interactions/bang3.ogg',
		'modular_sand/sound/interactions/bang4.ogg',
		'modular_sand/sound/interactions/bang5.ogg',
		'modular_sand/sound/interactions/bang6.ogg',
	)

	if(is_fucking(target, CUM_TARGET_URETHRA))
		lines = list(
			"humps right into \the <b>[target]</b>'s [pick(cock)], stretiching it as their balls slam together",
			"slides [u_His] [pick(cock)] all the way down \the <b>[target]</b>'s own throbbing [pick(cock)], [t_His] urethra is so tight!",
			"rams [u_His] [pick(cock)] back and forth through \the <b>[target]</b>'s urethra, giving it a very nice fucking"
		)
	else
		lines = list(
			"'s tip gently smooches \the <b>[target]</b>'s, right before forcing its way right down [t_His] dickhole",
			"grinds [u_His] tip against \the <b>[target]</b>'s [pick(cock)], only to slide [u_His] whole [pick(cock)] all the way down to [t_His] base",
			"makes \the <b>[target]</b>'s fat [pick(cock)] stretch and throb as the size of [u_His] [pick(cock)] makes its way right in"
		)
		set_is_fucking(target, CUM_TARGET_URETHRA, getorganslot(ORGAN_SLOT_PENIS))

	message = "<span class='lewd'>\The <b>[src]</b> [pick(lines)]</span>"
	visible_message(message, ignored_mobs = get_unconsenting())
	playlewdinteractionsound(src, pick(noises), 70, 1, -1)
	handle_post_sex(NORMAL_LUST, CUM_TARGET_URETHRA, target)
	target.handle_post_sex(NORMAL_LUST, CUM_TARGET_URETHRA, src)

/mob/living/proc/do_nipfuck(mob/living/target)
	var/message
	var/list/lines
	var/u_His = p_their()
	var/t_His = target.p_their()
	if(is_fucking(target, CUM_TARGET_NIPPLE) && target.has_breasts(REQUIRE_EXPOSED))
		lines = list(
			"slides [u_His] [pick(GLOB.dick_nouns)] back and forth into \the <b>[target]</b>'s nipple",
			"thrusts in and out of \the <b>[target]</b>'s leaky and puffy nip, making [t_His] [pick(GLOB.breast_nouns)] slosh and leak",
			"'s balls slap loudly against \the <b>[target]</b>'s jostling [pick(GLOB.breast_nouns)] as [t_His] nipple swallows [u_His] [pick(GLOB.dick_nouns)] whole"
		)
	else if(target.has_breasts(REQUIRE_EXPOSED))
		lines = list(
			"presses [u_His] throbbing tip against \the <b>[target]</b>'s puffy nipple, forcing the whole lenght all the way in with a wet smack",
			"stretches \the <b>[target]</b>'s nipple with his fingers, before forcing it open with the whole girth of [u_His] twitching [pick(GLOB.dick_nouns)]"
		)
	else
		lines = list(
			"rubs [u_His] tip gently against \the <b>[target]</b>'s [pick("nipple", "chest")]",
			"slaps [u_His] snaky [pick(GLOB.dick_nouns)] into \the <b>[target]</b>'s chest",
			"smooches \the <b>[target]</b>'s nipple with [u_His] dickhole"
		)

	if(!is_fucking(target, CUM_TARGET_NIPPLE))
		set_is_fucking(target, CUM_TARGET_NIPPLE, getorganslot(ORGAN_SLOT_PENIS))

	message = "<span class='lewd'>\The <b>[src]</b> [pick(lines)]!</span>"
	visible_message(message, ignored_mobs = get_unconsenting())
	playlewdinteractionsound(src, pick('modular_sand/sound/interactions/bang1.ogg',
						'modular_sand/sound/interactions/bang2.ogg',
						'modular_sand/sound/interactions/bang3.ogg'), 70, 1, -1)
	handle_post_sex(NORMAL_LUST, CUM_TARGET_NIPPLE, target)
	target.handle_post_sex(NORMAL_LUST, null, src)

/mob/living/proc/do_thighfuck(mob/living/target)
	var/message
	var/list/lines
	var/u_His = p_their()
	var/t_His = target.p_their()

	if(is_fucking(target, CUM_TARGET_THIGHS))
		lines = list(
			"thrusts in and out of \the <b>[target]</b>'s [pick("pudgy ", "soft ", "")]thighs, making them jiggle",
			"lustfully rolls [u_His] [pick(GLOB.dick_nouns)] back and forth between \the <b>[target]</b>'s thighs",
			"vigorously fucks \the <b>[target]</b>'s legs, making [u_His] tip pop in and out of [t_His] supple thighs"
		)
	else
		lines = list(
			"presses [u_His] tip against \the <b>[target]</b>'s [pick("pudgy ", "soft ", "")] thighs, soon shoving [u_His] whole lenght right in between them",
			"presents [u_His] [pick(GLOB.dick_nouns)] to \the <b>[target]</b>'s legs, ramming its full size right into [t_His] thigh lock",
			"smooches \the <b>[target]</b>'s crotch with [u_His] throbbing tip, right before piercing between [t_His] thighs with [u_His] full [pick(GLOB.dick_nouns)]"
		)
		set_is_fucking(target, CUM_TARGET_THIGHS, getorganslot(ORGAN_SLOT_PENIS))

	message = "<span class='lewd'>\The <b>[src]</b> [pick(lines)]!</span>"
	visible_message(message, ignored_mobs = get_unconsenting())
	playlewdinteractionsound(loc, pick('modular_sand/sound/interactions/bang1.ogg',
						'modular_sand/sound/interactions/bang2.ogg',
						'modular_sand/sound/interactions/bang3.ogg'), 70, 1, -1)
	handle_post_sex(NORMAL_LUST, CUM_TARGET_THIGHS, target)
	target.handle_post_sex(LOW_LUST, CUM_TARGET_PENIS, src)

/mob/living/proc/do_thighjob(mob/living/target)
	var/message
	var/list/lines
	var/u_His = p_their()
	var/t_He = target.p_they()
	var/t_His = target.p_their()

	if(target.is_fucking(src, CUM_TARGET_THIGHS))
		lines = list(
			"grinds and presses [u_His] thighs [pick("deeply ", "")] against \the <b>[target]</b>'s [pick(GLOB.dick_nouns)], massaging it all over with [u_His] thighs",
			"squeezes \the <b>[target]</b>'s [pick(GLOB.dick_nouns)] between [u_His] supple thighs, smothering it deep under [u_His] crotch",
			"rides \the <b>[target]</b>'s [pick(GLOB.dick_nouns)] with [u_His] [pick("pudgy ", "soft ", "")]thighs, [t_He] can feel [u_His] flesh smothering it down"
		)
	else
		lines = list(
			"presents [u_His] [pick("pudgy ", "soft ", "")] thighs to \the <b>[target]</b>'s [pick(GLOB.dick_nouns)], slamming them right into it[pick(" with a [pick("wet ", "")]smack", "")]",
			"grinds \the <b>[target]</b>'s tip against [u_His] supple thighs, before slamming them right down into [t_His] [pick(GLOB.dick_nouns)]",
			"forces \the <b>[target]</b>'s [pick(GLOB.dick_nouns)] right into the tight hold of [u_His] thighs, giving it a deep and lewd squeeze"
		)
		target.set_is_fucking(src, CUM_TARGET_THIGHS, target.getorganslot(ORGAN_SLOT_PENIS))

	message = "<span class='lewd'>\The <b>[src]</b> [pick(lines)]!</span>"
	visible_message(message, ignored_mobs = get_unconsenting())
	playlewdinteractionsound(loc, pick('modular_sand/sound/interactions/bang1.ogg',
						'modular_sand/sound/interactions/bang2.ogg',
						'modular_sand/sound/interactions/bang3.ogg'), 70, 1, -1)
	handle_post_sex(LOW_LUST, CUM_TARGET_PENIS, target)
	target.handle_post_sex(NORMAL_LUST, CUM_TARGET_THIGHS, src)

////////////////////////////////////////////////////////////////////////////////////////////////////////
///////// 									U N H O L Y										   /////////
////////////////////////////////////////////////////////////////////////////////////////////////////////
/mob/living/proc/do_facefart(mob/living/carbon/target)
	var/message
	var/t_His = target.p_their()
	var/u_His = p_their()
	var/u_He = p_they()

	var/list/asscheeks = list("asscheeks", "buttcheeks", "ass buns", "booty pillows", "dumptruck spheres", "[pick(list("jiggly", "bouncy", "wobbly"))] buttocks")
	var/list/ass = list("ass", "butt", "dumptruck", "tush", "badonk", "booty", "rump")
	var/jiggle = "[u_His] [pick(asscheeks)] [pick(list("jiggle", "bounce", "bounce around", "wobble"))] like crazy!"
	var/list/stank = list("greasy", "rancid", "pungent", "rotten", "boiling hot", "wet", "nose-burning", "heavy", "dense", "thick", "stinky", "stenchy", "warm")
	var/list/braps = list(
		"rips a [pick(list("massive", "fat", "engulfing", "breathtaking"))][pick(list(", [pick(stank)]", ""))] one",
		"[pick(list("", "wetly", "loudly"))] [pick(list("braps", "farts", "rips ass"))]",
		"lets out some of that [pick(stank)] [pick(list("gas", "flatulence", "anal hurricane"))]",
		"lets [u_His] shitter drop a [pick(list("large", "fat", "greasy"))] gas bomb",
		"allows [u_His] [pick(ass)] to rip an enormous, greasy gas cloud"
	)
	var/list/hell = list(
		"'s asshole squints as she shoves \the <b>[target]</b>'s face in between [u_His] sweaty [pick(asscheeks)], letting hell go loose!",
		" pushes [u_His] [pick(ass)] into \the <b>[target]</b>'s face, [pick(list("[t_His] nose shoved deep in [src]'s musky butthole", "[u_His] asshole sqints"))] as [u_He] [pick(braps)][pick(list("", ", [jiggle]"))]",
		" smothers \the [target]'s whole head in between [u_His][pick(list(" sweaty", "", " musky"))] [pick(asscheeks)], pushing out gallons of pure braps. [pick(list("", "[jiggle]"))]",
		"'s [pick(ass)] claps against \the <b>[target]</b>'s nose, right before [u_He] [pick(braps)]"
	)

	message = "<span class='lewd'>\The <b>[src]</b>[pick(hell)]</span>"
	visible_message(message, ignored_mobs = get_unconsenting(unholy = TRUE))
	playlewdinteractionsound(loc, pick(GLOB.brap_noises), 50, 1, -1, ignored_mobs = get_unconsenting(unholy = TRUE))
	if(!is_fucking(target, GRINDING_FACE_WITH_ANUS))
		set_is_fucking(target, GRINDING_FACE_WITH_ANUS, null)
	handle_post_sex(LOW_LUST, null, src)

/mob/living/proc/do_crotchfart(mob/living/carbon/target)
	var/message
	var/u_His = p_their()

	var/obj/item/organ/genital/brap_catcher = target.has_penis(REQUIRE_EXPOSED) && target.has_vagina(REQUIRE_EXPOSED) ? pick(list(target.getorganslot(ORGAN_SLOT_PENIS), target.getorganslot(ORGAN_SLOT_VAGINA))) : (target.has_penis(REQUIRE_EXPOSED) ? target.getorganslot(ORGAN_SLOT_PENIS) : (target.has_vagina(REQUIRE_EXPOSED) ? target.getorganslot(ORGAN_SLOT_VAGINA) : null))
	var/list/asscheeks = list("asscheeks", "buttcheeks", "ass buns", "booty pillows", "dumptruck spheres", "[pick(list("jiggly", "bouncy", "wobbly"))] buttocks")
	var/list/ass = list("ass", "butt", "dumptruck", "tush", "badonk", "booty", "rump")
	var/jiggle = "[u_His] [pick(asscheeks)] [pick(list("jiggle", "bounce", "bounce around", "wobble"))] like crazy!"
	var/list/stank = list("greasy", "rancid", "pungent", "rotten", "boiling hot", "wet", "nose-burning", "heavy", "dense", "thick", "stinky", "stenchy", "warm")
	var/list/braps = list(
		"rips a [pick(list("massive", "fat", "engulfing", "breathtaking"))][pick(list(", [pick(stank)]", ""))] one",
		"[pick(list("", "wetly", "loudly"))] [pick(list("braps", "farts", "rips ass"))]",
		"lets out some of that [pick(stank)] [pick(list("gas", "flatulence", "anal hurricane"))]",
		"lets [u_His] shitter drop a [pick(list("large", "fat", "greasy"))] gas bomb",
		"allows [u_His] [pick(ass)] to rip an enormous, greasy gas cloud."
	)
	var/list/hell = list(
		" pushes [u_His] [pick(ass)] into \the <b>[target]</b>'s crotch, [pick(list("ripping a fat[pick(list("", " and [pick(stank)]"))] one", " and subsequently [pick(braps)]"))][pick(list("", ". [jiggle]"))]",
		" and \the <b>[target]</b> can smell the [prob(50) ? pick(stank) : "flatulent"] gas fill the room ass it seeps in between \the <b>[target]</b>'s thighs!",
		" [pick(braps)] into \the <b>[target]</b>'s [brap_catcher ? brap_catcher : "crotch"]"
	)

	message = "<span class='lewd'>\The <b>[src]</b>[pick(hell)]</span>"
	visible_message(message, ignored_mobs = get_unconsenting(unholy = TRUE))
	playlewdinteractionsound(loc, pick(GLOB.brap_noises), 50, 1, -1, ignored_mobs = get_unconsenting(unholy = TRUE))
	if(!target.is_fucking(src, CUM_TARGET_ANUS))
		target.set_is_fucking(src, CUM_TARGET_ANUS, target.has_penis(REQUIRE_EXPOSED) ? target.getorganslot(ORGAN_SLOT_PENIS) : (target.has_vagina(REQUIRE_EXPOSED) ? target.getorganslot(ORGAN_SLOT_VAGINA) : null))
	target.handle_post_sex(NORMAL_LUST, CUM_TARGET_ANUS, src)
	handle_post_sex(NORMAL_LUST, null, target)

/mob/living/proc/do_fartfuck(mob/living/target)
	var/message
	var/list/hell
	var/t_He = target.p_they()
	var/t_His = target.p_their()
	var/u_His = p_their()
	var/u_He = p_they()

	var/list/asscheeks = list("asscheeks", "buttcheeks", "ass buns", "booty pillows", "dumptruck spheres", "[pick(list("jiggly", "bouncy", "wobbly"))] buttocks")
	var/list/ass = list("ass", "butt", "dumptruck", "tush", "badonk", "booty", "rump")
	var/jiggle = "[t_His] [pick(asscheeks)] [pick(list("jiggle", "bounce", "bounce around", "wobble"))] like crazy!"
	var/list/stank = list("greasy", "rancid", "pungent", "rotten", "boiling hot", "wet", "nose-burning", "heavy", "dense", "thick", "stinky", "stenchy", "warm")
	var/list/stankhole = list("greasy", "stinky", "dirty", "gassy", "brapping", "noisy", "quaking", "musky")
	var/list/braps = list(
		"rips a [pick(list("massive", "fat", "engulfing", "breathtaking"))][pick(list(", [pick(stank)]", ""))] one",
		"[pick(list("", "wetly", "loudly"))] [pick(list("braps", "farts", "rips ass"))]",
		"lets out some of that [pick(stank)] [pick(list("gas", "flatulence", "anal hurricane"))]",
		"lets [u_His] shitter drop a [pick(list("large", "fat", "greasy"))] gas bomb",
		"allows [u_His] [pick(ass)] to rip an enormous, greasy gas cloud."
	)
	if(is_fucking(target, CUM_TARGET_ANUS))
		hell = list(
			"thrusts in and out of \the <b>[target]</b>'s [pick(stankhole)] pucker, making it [pick("fumigate <b>[src]</b>'s cock with farts", "push out an unholy amount of ass gas")].",
			"pounds \the <b>[target]</b>'s ass. [t_He] [pick(braps)]",
			"slams [u_His] hips up against \the <b>[target]</b>'s [pick(stankhole)] [pick(ass)] hard, causing a massive surge of [pick(list("farts", "butt methane", "brap", "ass gas", "shit winds", "thick flatulence"))] from [t_His] [pick(list("crack", "canyon"))][prob(50) ? ". [jiggle]" : ""]",
			"goes balls deep into \the <b>[target]</b>'s [pick(ass)] over and over again. [t_He] can't stop pumping out [pick("", "[pick(stank)] ")] [pick(list("farts", "butt methane", "brap", "ass gas", "shit winds", "thick flatulence"))] from his wobbling [pick(asscheeks)]")
	else
		hell = list(
			"can already smell the stench as [u_He] works [u_His] cock into \the <b>[target]</b>'s brap hole, being received by a long and warm backblast.",
			"grabs the base of [u_His] twitching cock and presses the tip into \the <b>[target]</b>'s asshole, acting like a valve that unearths impossible amounts of pure, [pick(stank)] flatulence.",
			"shoves their dick deep inside of \the <b>[target]</b>'s [pick(ass)], [t_He] [pick(braps)][pick("", ". [jiggle]")]")
		set_is_fucking(target, CUM_TARGET_ANUS, getorganslot(ORGAN_SLOT_PENIS) ? getorganslot(ORGAN_SLOT_PENIS) : null)

	message = "<span class='lewd'>\The <b>[src]</b> [pick(hell)]</span>"
	visible_message(message, ignored_mobs = get_unconsenting(unholy = TRUE))
	playlewdinteractionsound(target.loc, pick(GLOB.brap_noises), 50, 1, -1, ignored_mobs = get_unconsenting(unholy = TRUE))
	playlewdinteractionsound(target.loc, pick('modular_sand/sound/interactions/bang1.ogg',
						'modular_sand/sound/interactions/bang2.ogg',
						'modular_sand/sound/interactions/bang3.ogg',
						'modular_sand/sound/interactions/bang4.ogg',
						'modular_sand/sound/interactions/bang5.ogg',
						'modular_sand/sound/interactions/bang6.ogg'), 70, 1, -1)
	handle_post_sex(NORMAL_LUST, CUM_TARGET_ANUS, target)
	target.handle_post_sex(NORMAL_LUST, null, src)

/mob/living/proc/suck_fart(mob/living/target)
	var/message
	var/list/hell
	var/t_His = target.p_their()
	var/u_His = p_their()

	var/list/stank = list("greasy", "rancid", "pungent", "rotten", "boiling hot", "wet", "nose-burning", "heavy", "dense", "thick", "stinky", "stenchy", "warm")
	var/list/stankhole = list("greasy", "stinky", "dirty", "gassy", "brapping", "noisy", "quaking", "musky")

	if(is_fucking(target, GRINDING_FACE_WITH_ANUS))
		hell = list(
			"smooches and sucks \the <b>[target]</b>'s [pick(pick(stankhole) + " ", "")] pucker, gulping down a whole barrage of [pick(stank)] flatulence!",
			"pierces \the <b>[target]</b>'s [pick(pick(stankhole) + " ", "")] butthole with [u_His] tongue, making a [pick(stank)] burst out!",
			"sucks into \the <b>[target]</b>'s [pick(pick(stankhole) + " ", "")] asshole, gulping down [t_His] [pick(stank)] gas!"
		)
	else
		hell = list(
			"presses [u_His] face right into \the <b>[target]</b>'s [pick(list("musky ", "sweaty ", ""))] backside, spreading [t_His] butthole open to begin harvesting [t_His] [pick(stank) + " "] farts!",
			"uses [u_His] lips to spread \the <b>[target]</b>'s [pick(stankhole) + " "] butthole, starting to suck the flatulence out of it!"
		)
		set_is_fucking(target, GRINDING_FACE_WITH_ANUS, null)

	message = "<span class='lewd'>\The <b>[src]</b> [pick(hell)]</span>"
	visible_message(message, ignored_mobs = get_unconsenting(unholy = TRUE))
	playlewdinteractionsound(target.loc, pick(GLOB.brap_noises), 50, 1, -1, ignored_mobs = get_unconsenting(unholy = TRUE))
	playlewdinteractionsound(target.loc, 'modular_sand/sound/interactions/champ_fingering.ogg', 50, 1, -1, ignored_mobs = get_unconsenting(unholy = TRUE))
	target.handle_post_sex(NORMAL_LUST, null, src)

/mob/living/proc/do_faceshit(mob/living/carbon/target)
	var/message
	var/u_His = p_their()
	var/t_His = target.p_their()

	var/list/asscheeks = list("asscheeks", "buttcheeks", "ass buns", "booty pillows", "dumptruck spheres", "[pick(list("jiggly", "bouncy", "wobbly"))] buttocks")
	var/list/ass = list("ass", "butt", "dumptruck", "tush", "badonk", "booty", "rump")
	var/jiggle = "[u_His] [pick(asscheeks)] [pick(list("jiggle", "bounce", "bounce around", "wobble"))] like crazy!"
	var/list/stank = list("greasy", "rancid", "pungent", "rotten", "boiling hot", "wet", "nose-burning", "heavy", "dense", "thick", "stinky", "stenchy", "warm")
	var/list/stankhole = list("greasy", "stinky", "dirty", "gassy", "shitting", "noisy", "quaking", "musky", "messy", "shitcaked", "nasty")

	var/list/hell = list(
		"presses [u_His] [pick(stankhole)] [pick(ass)] into \the <b>[target]</b>'s face, coating it in a [pick(stank)] layer of brown",
		"makes sure \the <b>[target]</b>'s mouth is wide open, letting out a greasy, [pick(stank)] log of manure right into it. [jiggle]",
		"smothers \the <b>[target]</b>'s face in between [u_His] musky, dirty asscheeks, [pick(list("", "letting out a [pick(stank)] fart and"))] sliding a monster turd right into [t_His] mouth"
	)

	message = "<span class='lewd'>\The <b>[src]</b> [pick(hell)]</span>"
	visible_message(message, ignored_mobs = get_unconsenting(unholy = TRUE))
	playlewdinteractionsound(loc, pick(GLOB.brap_noises), 50, 1, -1, ignored_mobs = get_unconsenting(unholy = TRUE))
	if(!is_fucking(target, GRINDING_FACE_WITH_ANUS))
		set_is_fucking(target, GRINDING_FACE_WITH_ANUS, null)
	handle_post_sex(LOW_LUST, null, src)

/mob/living/proc/do_crotchshit(mob/living/carbon/target)
	var/message
	var/t_His = target.p_their()
	var/u_His = p_their()

	var/obj/item/organ/genital/brap_catcher = (target.has_penis(REQUIRE_EXPOSED) ? target.getorganslot(ORGAN_SLOT_PENIS) : (target.has_vagina(REQUIRE_EXPOSED) ? target.getorganslot(ORGAN_SLOT_VAGINA) : null))
	var/list/asscheeks = list("asscheeks", "buttcheeks", "ass buns", "booty pillows", "dumptruck spheres", "[pick(list("jiggly", "bouncy", "wobbly"))] buttocks")
	var/list/ass = list("ass", "butt", "dumptruck", "tush", "badonk", "booty", "rump")
	var/jiggle = "[u_His] [pick(asscheeks)] [pick(list("jiggle", "bounce", "bounce around", "wobble"))] like crazy!"
	var/list/stank = list("greasy", "rancid", "pungent", "rotten", "boiling hot", "wet", "nose-burning", "heavy", "dense", "thick", "stinky", "stenchy", "warm")
	var/list/stankhole = list("greasy", "stinky", "dirty", "gassy", "shitting", "noisy", "quaking", "musky", "messy", "shitcaked", "nasty")

	var/list/hell = list(
		"presses [u_His] [pick(stankhole)] [pick(asscheeks)] right against \the <b>[target]</b>'s crotch, unleashing pounds of warm crap all over [brap_catcher ? "[t_His] [brap_catcher]" : "it"] [prob(50) ? ". [jiggle]" : ""]",
		"shoves [u_His][pick(list("", " [pick(stank)],"))] shitting [pick(ass)] into \the <b>[target]</b>'s thighs and coats everything in between them with [pick("", "gas and ")] slick slop",
		"shits uncontrollably all over \the <b>[target]</b>'s [brap_catcher ? brap_catcher : "crotch"][prob(50) ? "" : ". [jiggle]"]"
	)

	message = "<span class='lewd'>\The <b>[src]</b>[pick(hell)]</span>"
	visible_message(message, ignored_mobs = get_unconsenting(unholy = TRUE))
	playlewdinteractionsound(loc, pick(GLOB.brap_noises), 50, 1, -1, ignored_mobs = get_unconsenting(unholy = TRUE))
	if(!target.is_fucking(src, CUM_TARGET_ANUS))
		target.set_is_fucking(src, CUM_TARGET_ANUS, brap_catcher)
	target.handle_post_sex(NORMAL_LUST, CUM_TARGET_ANUS, src)
	handle_post_sex(NORMAL_LUST, null, target)

/mob/living/proc/do_shitfuck(mob/living/carbon/target)
	var/message
	var/t_He = target.p_they()
	var/t_His = target.p_their()
	var/u_His = p_their()
	var/u_He = p_they()

	var/list/hell
	var/list/asscheeks = list("asscheeks", "buttcheeks", "ass buns", "booty pillows", "dumptruck spheres", "[pick(list("jiggly", "bouncy", "wobbly"))] buttocks")
	var/list/ass = list("ass", "butt", "dumptruck", "tush", "badonk", "booty", "rump")
	var/jiggle = "[t_His] [pick(asscheeks)] [pick(list("jiggle", "bounce", "bounce around", "wobble"))] like crazy!"
	var/list/stank = list("greasy", "rancid", "pungent", "rotten", "boiling hot", "wet", "nose-burning", "heavy", "dense", "thick", "stinky", "stenchy", "warm")
	var/list/stankhole = list("greasy", "stinky", "dirty", "gassy", "shitting", "noisy", "quaking", "musky", "messy", "shitcaked", "nasty")

	if(is_fucking(target, CUM_TARGET_ANUS))
		hell = list(
			"thrusts in and out of \the <b>[target]</b>'s [pick(stank)] shit-lubed pucker, making it squeak and expulse heavy gases and waste.",
			"pounds \the <b>[target]</b>'s ass. [t_He] just can't stop pumping out slop!",
			"slams [u_His] hips up against \the <b>[target]</b>'s [pick(stankhole)] [pick(ass)] hard, causing a massive surge of manure from [t_His] [pick(list("crack", "canyon"))][prob(50) ? ". [jiggle]" : ""]",
			"goes balls deep into \the <b>[target]</b>'s dirty [pick(ass)] over and over again. [u_His] cock comes completely coated brown from in between the bouncing [pick(asscheeks)]")
	else
		hell = list(
			"can already smell the stench as [u_He] works [u_His] cock into \the <b>[target]</b>'s dung hole, being received by warm, wet and nasty feeling all over it.",
			"grabs the base of [u_His] twitching cock and presses the tip into \the <b>[target]</b>'s asshole, immediately shoving it right into a fat and moisty log",
			"shoves  dick deep inside of \the <b>[target]</b>'s [pick(ass)], [t_He] releases a massive amount of mush to greet the rod[pick("", ". [jiggle]")]")
		set_is_fucking(target, CUM_TARGET_ANUS, getorganslot(ORGAN_SLOT_PENIS) ? getorganslot(ORGAN_SLOT_PENIS) : null)

	message = "<span class='lewd'>\The <b>[src]</b> [pick(hell)]</span>"
	visible_message(message, ignored_mobs = get_unconsenting(unholy = TRUE), ignored_mobs = get_unconsenting(unholy = TRUE))
	playlewdinteractionsound(target.loc, pick(GLOB.brap_noises), 70, 1, -1)
	playlewdinteractionsound(target.loc, pick('modular_sand/sound/interactions/bang1.ogg',
						'modular_sand/sound/interactions/bang2.ogg',
						'modular_sand/sound/interactions/bang3.ogg',
						'modular_sand/sound/interactions/bang4.ogg',
						'modular_sand/sound/interactions/bang5.ogg',
						'modular_sand/sound/interactions/bang6.ogg'), 70, 1, -1)
	handle_post_sex(NORMAL_LUST, CUM_TARGET_ANUS, target)
	target.handle_post_sex(NORMAL_LUST, null, src)

/mob/living/proc/suck_shit(mob/living/target)
	var/message
	var/list/hell
	var/t_His = target.p_their()
	var/u_His = p_their()

	var/list/stank = list("greasy", "rancid", "pungent", "rotten", "boiling hot", "wet", "nose-burning", "heavy", "dense", "thick", "stinky", "stenchy", "warm")
	var/list/stankhole = list("greasy", "stinky", "dirty", "gassy", "brapping", "noisy", "quaking", "musky")

	if(is_fucking(target, GRINDING_FACE_WITH_ANUS))
		hell = list(
			"smooches and sucks \the <b>[target]</b>'s [pick(pick(stankhole) + " ", "")] pucker, gulping down a whole log of [pick(stank)] shit!",
			"pierces \the <b>[target]</b>'s [pick(pick(stankhole) + " ", "")] butthole with [u_His] tongue, forcing them to evacuate a [pick(stank)] right down [u_His] throat!",
			"sucks into \the <b>[target]</b>'s [pick(pick(stankhole) + " ", "")] asshole, gulping down [t_His] [pick(stank)] scat!"
		)
	else
		hell = list(
			"presses [u_His] face right into \the <b>[target]</b>'s [pick(list("musky ", "sweaty ", ""))] backside, spreading [t_His] shithole open to begin harvesting [t_His] [pick(stank) + " "] manure!",
			"uses [u_His] lips to spread \the <b>[target]</b>'s [pick(stankhole) + " "] butthole, forcing him to take a massive dump on [u_His] mouth!"
		)
		set_is_fucking(target, GRINDING_FACE_WITH_ANUS, null)

	message = "<span class='lewd'>\The <b>[src]</b> [pick(hell)]</span>"
	visible_message(message, ignored_mobs = get_unconsenting(unholy = TRUE))
	playlewdinteractionsound(target.loc, pick(GLOB.brap_noises), 50, 1, -1, ignored_mobs = get_unconsenting(unholy = TRUE))
	playlewdinteractionsound(target.loc, 'modular_sand/sound/interactions/champ_fingering.ogg', 50, 1, -1, ignored_mobs = get_unconsenting(unholy = TRUE))
	target.handle_post_sex(NORMAL_LUST, null, src)

/mob/living/proc/piss_over(mob/living/target)
	var/message
	var/u_His = p_their()
	var/list/hell = list(
		"relieves [u_His] bladder all over \the <b>[target]</b>[pick(list("", "'s body"))]",
		"starts coating all of \the <b>[target]</b>'s body in warm piss",
		"lets out a moan of relief as yellow rain starts pouring over \the <b>[target]</b>"
	)

	message = "<span class='lewd'>\The <b>[src]</b> [pick(hell)]</span>"
	visible_message(message, ignored_mobs = get_unconsenting(unholy = TRUE))
	if(get_lust() < 10)
		add_lust(10)

/mob/living/carbon/proc/piss_mouth(mob/living/target)
	var/message
	var/pee_pee = (has_penis(REQUIRE_EXPOSED) ? getorganslot(ORGAN_SLOT_PENIS) : (has_vagina(REQUIRE_EXPOSED) ? getorganslot(ORGAN_SLOT_VAGINA) : null))
	var/u_His = p_their()
	var/t_Him = target.p_them()
	var/list/hell = list(
		"relieves [u_His] bladder inside \the <b>[target]</b>'s mouth [pick(list("filling it with [pick(list("warm", "salty"))] yellow goodness", "making [t_Him] taste all of that piss"))]",
		"coats the back of \the <b>[target]</b>'s throat with [u_His] golden treat",
		"lets out a moan of relief as yellow rain starts pouring in between \the <b>[target]</b>'s lips"
	)

	message = "<span class='lewd'>\The <b>[src]</b> [pick(hell)]</span>"
	visible_message(message, ignored_mobs = get_unconsenting(unholy = TRUE))
	if(!is_fucking(target, CUM_TARGET_MOUTH))
		set_is_fucking(target, CUM_TARGET_MOUTH, pee_pee)
	handle_post_sex(NORMAL_LUST, CUM_TARGET_MOUTH, target)
