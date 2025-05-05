void main(int num_casts)
{
	if(num_casts == 0) {
		print("Please specify a number of times to cast the trivial skills, such as \"trivialskills 10\" to cast each skill ten times.");
	}
	else {
		# Which trivial skills do we have, if any?
		skill [int] trivial_skills = {
			$skill[Seal Clubbing Frenzy],
			$skill[Patience of the Tortoise],
			$skill[Manicotti Meditation],
			$skill[Sauce Contemplation],
			$skill[Disco Aerobics],
			$skill[Moxie of the Mariachi]
		};
		int skill_total = 0;
		foreach trivial_skill in trivial_skills {
			if(have_skill(trivial_skills[trivial_skill])) {
				skill_total += 1;
			}
		}
		print("You have " + skill_total + " of the available trivial skills.");
		if(skill_total == 0) {
			print("You have none of the trivial skills. Perhaps you're running a special challenge path? Anyway, this script is kinda useless without those skills, so... Aborting!");
		}
		else {
			int mana_total;
			boolean reset_gear = false;
			boolean reset_weapon = false;
			mana_total = num_casts * skill_total;
			# Only do it if we have enough MP
			if(my_mp() >= mana_total) {
				# find and equip an April Shower Thoughts shield if you have one
				item weap = equipped_item($slot[weapon]);
				item offh = equipped_item($slot[off-hand]);
				if ((offh != $item[April Shower Thoughts shield]) && (item_amount($item[April Shower Thoughts shield]) > 0) && can_equip($item[April Shower Thoughts shield])) {
					if (weapon_hands(weap)>1) {
						equip($item[none], $slot[weapon]);
						reset_weapon = true;
					}
					equip($item[April Shower Thoughts shield], $slot[off-hand]);
					reset_gear = true;
				}
				foreach trivial_skill in trivial_skills {
					if(have_skill(trivial_skills[trivial_skill])) {
						use_skill(num_casts, trivial_skills[trivial_skill]);
					}
				}
				print("Cast each trivial skill " + num_casts + " times, spending " + mana_total + " MP in the process.");
				if (reset_gear) {
					# Go back to the original outfit
					if (reset_weapon) {
						equip(weap, $slot[weapon]);
					}
					equip(offh, $slot[off-hand]);
				}
			}
			else {
				print("Current MP is " + my_mp() + ", which is too low to cast each trivial skill " + num_casts + " times. Aborting!");
			}
		}
	}
}
