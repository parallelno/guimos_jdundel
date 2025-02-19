LINE_BREAK = 106
PARAG_BREAK = 255
EOD = 0
.macro TEXT (string, end_code=EOD)
.encoding "screencode", "mixed"
    .text string
    .byte end_code
.endmacro

;===================================================================================
; main menu
;===================================================================================

			.word 0 ; safety pair of bytes for reading by POP B
_main_menu_settings:
			.word 34 ; data len to copy to ram
			TEXT("START GAME", LINE_BREAK)
			TEXT("OPTIONS", LINE_BREAK)
			TEXT("SCORES", LINE_BREAK)
			TEXT("CREDITS", )


			.word 0 ; safety pair of bytes for reading by POP B
_main_menu_license:
			.word 40 ; data len to copy to ram
			TEXT("2023. Developed by Fedotovskikh family", )

;===================================================================================
; scores screen
;===================================================================================

			.word 0 ; safety pair of bytes for reading by POP B
_scores_screen_score_title:
			.word 12 ; data len to copy to ram
			TEXT("SCORE BOARD", )


			.word 0 ; safety pair of bytes for reading by POP B
_scores_screen_buff:
			.word 34 ; data len to copy to ram
			TEXT("TEMPNAME .................. 65535", )

;===================================================================================
; options screen
;===================================================================================

			.word 0 ; safety pair of bytes for reading by POP B
_options_screen_setting_on:
			.word 4 ; data len to copy to ram
			TEXT("ON", )


			.word 0 ; safety pair of bytes for reading by POP B
_options_screen_setting_off:
			.word 4 ; data len to copy to ram
			TEXT("OFF", )


			.word 0 ; safety pair of bytes for reading by POP B
_options_screen_settings:
			.word 10 ; data len to copy to ram
			TEXT("Settings", )


			.word 0 ; safety pair of bytes for reading by POP B
_options_screen_settings_names:
			.word 240 ; data len to copy to ram
			TEXT("Music", LINE_BREAK)
			TEXT("SFX_", PARAG_BREAK)

			TEXT("Control Preset ...", LINE_BREAK)
			TEXT(" UP ..............................", LINE_BREAK)
			TEXT(" DOWN ......................", LINE_BREAK)
			TEXT(" LEFT ........................", LINE_BREAK)
			TEXT(" RIGHT .....................", LINE_BREAK)
			TEXT(" FIRE ..........................", LINE_BREAK)
			TEXT(" SELECT ..................", LINE_BREAK)
			TEXT(" RETURN ................_", PARAG_BREAK)


			.word 0 ; safety pair of bytes for reading by POP B
_options_screen_return:
			.word 24 ; data len to copy to ram
			TEXT("Return to the Main Menu", )


			.word 0 ; safety pair of bytes for reading by POP B
_options_screen_dots:
			.word 42 ; data len to copy to ram
			TEXT("........................................", )


			.word 0 ; safety pair of bytes for reading by POP B
_options_screen_change_settings:
			.word 16 ; data len to copy to ram
			TEXT("Change settings", )


			.word 0 ; safety pair of bytes for reading by POP B
_options_screen_control_preset_key:
			.word 6 ; data len to copy to ram
			TEXT("Keys", )


			.word 0 ; safety pair of bytes for reading by POP B
_options_screen_control_preset_joy:
			.word 6 ; data len to copy to ram
			TEXT("JoyP1", )


			.word 0 ; safety pair of bytes for reading by POP B
_options_screen_controls_keyboard:
			.word 46 ; data len to copy to ram
			TEXT("K UP", LINE_BREAK)
			TEXT("K DOWN", LINE_BREAK)
			TEXT("K LEFT", LINE_BREAK)
			TEXT("K RIGHT", LINE_BREAK)
			TEXT("K SPACE", LINE_BREAK)
			TEXT("K PS", LINE_BREAK)
			TEXT("K TAB", )


			.word 0 ; safety pair of bytes for reading by POP B
_options_screen_controls_joystic:
			.word 50 ; data len to copy to ram
			TEXT("J UP", LINE_BREAK)
			TEXT("J DOWN", LINE_BREAK)
			TEXT("J LEFT", LINE_BREAK)
			TEXT("J RIGHT", LINE_BREAK)
			TEXT("J FIRE1", LINE_BREAK)
			TEXT("J FIRE2", LINE_BREAK)
			TEXT("J TAB", )

;===================================================================================
; credits screen
;===================================================================================

			.word 0 ; safety pair of bytes for reading by POP B
_credits_screen_credits:
			.word 484 ; data len to copy to ram
			TEXT("    This game was created because I truly", LINE_BREAK)
			TEXT("believe in the awesomeness of the Soviet", LINE_BREAK)
			TEXT("PC Vector 06c that shaped my life._", PARAG_BREAK)

			TEXT("Code: Alex Fedotovskikh", LINE_BREAK)
			TEXT("Story and inspiration: Petr Fedotovskikh", LINE_BREAK)
			TEXT("Game mechanics: Ilia Fedotovskikh", LINE_BREAK)
			TEXT("Support and ideas: Fenia Fedotovskikh", LINE_BREAK)
			TEXT("Level design: the whole family!", LINE_BREAK)
			TEXT("Big thanks to my amazing family for", LINE_BREAK)
			TEXT("working hard to make it a reality!_", PARAG_BREAK)

			TEXT("Special thanks to zx-pk.ru community", LINE_BREAK)
			TEXT("and especially to ivagor, nzeemin, svofski,", LINE_BREAK)
			TEXT("and jerry for their contribution and help!", )

;===================================================================================
; stats
;===================================================================================

			.word 0 ; safety pair of bytes for reading by POP B
_stats_game_stats:
			.word 386 ; data len to copy to ram
			TEXT("    Congratulations, hero! You were really", LINE_BREAK)
			TEXT("good in this epic quest! Time to celebrate", LINE_BREAK)
			TEXT("with a royal feast of popsicles watching a", LINE_BREAK)
			TEXT("lowdown on your epic journey below:_", PARAG_BREAK)

			TEXT("Monsters defeated:", LINE_BREAK)
			TEXT("Items acquired:", LINE_BREAK)
			TEXT("Coins collected:", LINE_BREAK)
			TEXT("Containers opened:", LINE_BREAK)
			TEXT("Doors unlocked:", LINE_BREAK)
			TEXT("Breakables broken:", LINE_BREAK)
			TEXT("Secret rooms entered:", LINE_BREAK)
			TEXT("Total score:_", PARAG_BREAK)

			TEXT("Keep your sword sharp and your heart brim-", LINE_BREAK)
			TEXT("ming with courage, for new quests!", )

;===================================================================================
; dialogs
;===================================================================================

			.word 0 ; safety pair of bytes for reading by POP B
_dialogs_no_health:
			.word 176 ; data len to copy to ram
			TEXT("Oh, not this! ..must save.. friend - said the", LINE_BREAK)
			TEXT("hero and fell into the deep, chilling darkness.", LINE_BREAK)
			TEXT("Seemed as if all hope was lost. But then,", LINE_BREAK)
			TEXT("miraculously, his eyes fluttered open.", )


			.word 0 ; safety pair of bytes for reading by POP B
_dialogs_knocked_his_home_door:
			.word 182 ; data len to copy to ram
			TEXT("I'm ditching this popsicle pie, right, but I'm", LINE_BREAK)
			TEXT("not done! I gotta track down my buddy Natias,", LINE_BREAK)
			TEXT("no doubts about it. He never vanishes without", LINE_BREAK)
			TEXT("a word. I'm getting all kinds of worried!", )


			.word 0 ; safety pair of bytes for reading by POP B
_dialogs_knocked_his_friend_door:
			.word 164 ; data len to copy to ram
			TEXT("Friend's mom: Natias ain't here now. He's left", LINE_BREAK)
			TEXT("early. Be a sweetie and fetch dried clothes", LINE_BREAK)
			TEXT("from the backyard, and I'll give you a", LINE_BREAK)
			TEXT("freshly baked popsicle pie, deal?", )


			.word 0 ; safety pair of bytes for reading by POP B
_dialogs_knocked_his_friend_door_no_clothes:
			.word 88 ; data len to copy to ram
			TEXT("Friend's mom: Oh, sugar, no clothes means", LINE_BREAK)
			TEXT("no pie, remember? We had a straight-up deal.", )


			.word 0 ; safety pair of bytes for reading by POP B
_dialogs_knocked_his_friend_door_clothes_returns:
			.word 152 ; data len to copy to ram
			TEXT("Friend's mom: Sweetie, you're the best", LINE_BREAK)
			TEXT("helper in the world! Here's a fresh-baked", LINE_BREAK)
			TEXT("popsicle pie, piping chill. Hurry and take", LINE_BREAK)
			TEXT("it home before it warms up!", )


			.word 0 ; safety pair of bytes for reading by POP B
_dialogs_hero_gets_sword:
			.word 174 ; data len to copy to ram
			TEXT("I don't believe my eyes, It is a legendary", LINE_BREAK)
			TEXT("sword, no doubt about it! Who would have", LINE_BREAK)
			TEXT("imagined my friend left it for me? This sharpy", LINE_BREAK)
			TEXT("little boy will free my friend in no time!", )


			.word 0 ; safety pair of bytes for reading by POP B
_dialogs_knocked_dungeon_entrance:
			.word 128 ; data len to copy to ram
			TEXT("Oh no! Is it only a demo? So unfair! But", LINE_BREAK)
			TEXT("this is not the end! I can hardly wait to", LINE_BREAK)
			TEXT("recount the entire story once it's complete!", )


			.word 0 ; safety pair of bytes for reading by POP B
_dialogs_hero_gets_spoon:
			.word 150 ; data len to copy to ram
			TEXT("A spoon??! No, the spoon! The most iconic", LINE_BREAK)
			TEXT("and ancient spoon ever designed, a masterpiece!", LINE_BREAK)
			TEXT("Popsicle pie missed you sooo much...", LINE_BREAK)
			TEXT("Oh no... it's cursed!", )


			.word 0 ; safety pair of bytes for reading by POP B
_dialogs_hero_use_pie:
			.word 134 ; data len to copy to ram
			TEXT("This popsicle pie is so delicious! I wish I had", LINE_BREAK)
			TEXT("my mouth big enough to swallow it all at", LINE_BREAK)
			TEXT("once. Until then, I definitely need a spoon.", )


			.word 0 ; safety pair of bytes for reading by POP B
_dialogs_hero_use_clothes:
			.word 74 ; data len to copy to ram
			TEXT("Deal's a deal! Promised to fetch and bring", LINE_BREAK)
			TEXT("the dry clothes, so get to it!", )

;===================================================================================
; storytelling
;===================================================================================

			.word 0 ; safety pair of bytes for reading by POP B
_storytelling_storytelling_home:
			.word 124 ; data len to copy to ram
			TEXT("Rad day for my morning jog! Legs are ready", LINE_BREAK)
			TEXT("for some serious adventuring action.", LINE_BREAK)
			TEXT("If it's all about collecting, count me in!", )


			.word 0 ; safety pair of bytes for reading by POP B
_storytelling_storytelling_farm_fence:
			.word 162 ; data len to copy to ram
			TEXT("Oh my glob, guess what? Mom's on a cabbage", LINE_BREAK)
			TEXT("quest, and you know what they say - no", LINE_BREAK)
			TEXT("cabbage left behind! Gonna scoop up those", LINE_BREAK)
			TEXT("leafy greens like a true adventurer!", )


			.word 0 ; safety pair of bytes for reading by POP B
_storytelling_storytelling_road_to_friends_home:
			.word 136 ; data len to copy to ram
			TEXT("Wait a minute! Who's the cheeky one", LINE_BREAK)
			TEXT("cluttering up the road? Gotta snag a hero", LINE_BREAK)
			TEXT("thingamajig to clear the path for some", LINE_BREAK)
			TEXT("righteous heroing!", )


			.word 0 ; safety pair of bytes for reading by POP B
_storytelling_storytelling_friends_home:
			.word 108 ; data len to copy to ram
			TEXT("Check it, my buddy's cave! He said he'd", LINE_BREAK)
			TEXT("be around today. Gotta jog his memory", LINE_BREAK)
			TEXT("'bout that promise, ya know?", )


			.word 0 ; safety pair of bytes for reading by POP B
_storytelling_storytelling_friends_backyard:
			.word 148 ; data len to copy to ram
			TEXT("Really??? It looks like a hidden lair in", LINE_BREAK)
			TEXT("the bushes! I'm gonna investigate my", LINE_BREAK)
			TEXT("friend's secret spot. Those bones at the", LINE_BREAK)
			TEXT("entrance are a spooky clue!", )


			.word 0 ; safety pair of bytes for reading by POP B
_storytelling_storytelling_friends_secret_place:
			.word 146 ; data len to copy to ram
			TEXT("Oh no, there are bones and skulls all over", LINE_BREAK)
			TEXT("the place! I worry my friend can be in a real", LINE_BREAK)
			TEXT("danger! I gonna find and rescue him no matter", LINE_BREAK)
			TEXT("the cost!", )


			.word 0 ; safety pair of bytes for reading by POP B
_storytelling_storytelling_crossroad:
			.word 170 ; data len to copy to ram
			TEXT("I'm shaken! A terrible monster and the corpses", LINE_BREAK)
			TEXT("of our beloved villagers! It's clear who the", LINE_BREAK)
			TEXT("culprit is here! You better be trembling!", LINE_BREAK)
			TEXT("I'm going to teach you a lesson!!!", )


			.word 0 ; safety pair of bytes for reading by POP B
_storytelling_storytelling_loop:
			.word 88 ; data len to copy to ram
			TEXT("You better watch out, little rolling furry", LINE_BREAK)
			TEXT("burner, because there's no escaping from me!", )


			.word 0 ; safety pair of bytes for reading by POP B
_storytelling_storytelling_lost_coins:
			.word 172 ; data len to copy to ram
			TEXT("Wow, wow, wow!!! My intuition never fails me!", LINE_BREAK)
			TEXT("I just knew there had to be treasures on this", LINE_BREAK)
			TEXT("heroic journey! Everyone, look at my pockets,", LINE_BREAK)
			TEXT("coins are about to overflow them!", )


			.word 0 ; safety pair of bytes for reading by POP B
_storytelling_storytelling_farm_entrance:
			.word 156 ; data len to copy to ram
			TEXT("Every time I lay eyes on cabbage, I get all", LINE_BREAK)
			TEXT("hungry up in here. But you gotta watch out,", LINE_BREAK)
			TEXT("'cause if you munch too much, your tummy", LINE_BREAK)
			TEXT("might throw a grumble fit!", )


			.word 0 ; safety pair of bytes for reading by POP B
_storytelling_storytelling_farm_storage:
			.word 144 ; data len to copy to ram
			TEXT("Who's that dude on my road? Not cool", LINE_BREAK)
			TEXT("with his mega-spooky vibe. Lucky", LINE_BREAK)
			TEXT("for us, he's shieldless. Time to fuel", LINE_BREAK)
			TEXT("up with cabbages to overspook him!", )


			.word 0 ; safety pair of bytes for reading by POP B
_storytelling_storytelling_dugeon_entrance:
			.word 136 ; data len to copy to ram
			TEXT("Wily skeletons and a wall of fire - that's", LINE_BREAK)
			TEXT("a real hero's challenge! Gotta figure out", LINE_BREAK)
			TEXT("how to extinguish it before they surrender", LINE_BREAK)
			TEXT("to me!", )


			.word 0 ; safety pair of bytes for reading by POP B
_storytelling_hero_use_cabbage:
			.word 114 ; data len to copy to ram
			TEXT("Cabbages... so yummy-wummy! I can feel", LINE_BREAK)
			TEXT("myself getting all rested up and fresh!", LINE_BREAK)
			TEXT("But my tummy does little ghrrr...", )


			.word 0 ; safety pair of bytes for reading by POP B
_storytelling_hero_use_spoon:
			.word 180 ; data len to copy to ram
			TEXT("Finally, feasted on my favorite popsicle-pie!", LINE_BREAK)
			TEXT("Oh, what's this? Some snowflakes left behind.", LINE_BREAK)
			TEXT("I'll just pop'em in my pocket, you never know", LINE_BREAK)
			TEXT("what might come in handy on an adventure!", )


			.word 0 ; safety pair of bytes for reading by POP B
_storytelling_hero_freeze_monster:
			.word 120 ; data len to copy to ram
			TEXT("Aha! So that's how it works. If you're all", LINE_BREAK)
			TEXT("spooky and scary, get a snowflake to the", LINE_BREAK)
			TEXT("noggin! It'll chill you out a bit!", )

