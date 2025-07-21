_LINE_BREAK_ = 106
_PARAG_BREAK_ = 255
_EOD_ = 0
.macro TEXT (string, end_code=_EOD_)
.encoding "screencode", "mixed"
    .text string
    .byte end_code
.endmacro

;===================================================================================
; stats
;===================================================================================

			.word 0 ; safety pair of bytes for reading by POP B
_stats_game_stats:
			.word 386 ; data len to copy to ram
			.byte 224, 18 ; scr pos (y, x)
			TEXT("    Congratulations, hero! You were really", _LINE_BREAK_)
			TEXT("good in this epic quest! Time to celebrate", _LINE_BREAK_)
			TEXT("with a royal feast of popsicles watching a", _LINE_BREAK_)
			TEXT("lowdown on your epic journey below:", _PARAG_BREAK_)

			TEXT("Monsters defeated:", _LINE_BREAK_)
			TEXT("Items acquired:", _LINE_BREAK_)
			TEXT("Coins collected:", _LINE_BREAK_)
			TEXT("Containers opened:", _LINE_BREAK_)
			TEXT("Doors unlocked:", _LINE_BREAK_)
			TEXT("Breakables broken:", _LINE_BREAK_)
			TEXT("Secret rooms entered:", _LINE_BREAK_)
			TEXT("Total score:", _PARAG_BREAK_)

			TEXT("Keep your sword sharp and your heart brim-", _LINE_BREAK_)
			TEXT("ming with courage, for new quests!", )

;===================================================================================
; dialogs
;===================================================================================

			.word 0 ; safety pair of bytes for reading by POP B
_dialogs_no_health:
			.word 178 ; data len to copy to ram
			.byte 45, 16 ; scr pos (y, x)
			TEXT("Oh, not this! ..must save.. friend - said the", _LINE_BREAK_)
			TEXT("hero and fell into the deep, chilling darkness.", _LINE_BREAK_)
			TEXT("Seemed as if all hope was lost. But then,", _LINE_BREAK_)
			TEXT("miraculously, his eyes fluttered open.", )


			.word 0 ; safety pair of bytes for reading by POP B
_dialogs_knocked_his_home_door:
			.word 184 ; data len to copy to ram
			.byte 45, 16 ; scr pos (y, x)
			TEXT("I'm ditching this popsicle pie, right, but I'm", _LINE_BREAK_)
			TEXT("not done! I gotta track down my buddy Natias,", _LINE_BREAK_)
			TEXT("no doubts about it. He never vanishes without", _LINE_BREAK_)
			TEXT("a word. I'm getting all kinds of worried!", )


			.word 0 ; safety pair of bytes for reading by POP B
_dialogs_knocked_his_friend_door:
			.word 166 ; data len to copy to ram
			.byte 45, 16 ; scr pos (y, x)
			TEXT("Friend's mom: Natias ain't here now. He's left", _LINE_BREAK_)
			TEXT("early. Be a sweetie and fetch dried clothes", _LINE_BREAK_)
			TEXT("from the backyard, and I'll give you a", _LINE_BREAK_)
			TEXT("freshly baked popsicle pie, deal?", )


			.word 0 ; safety pair of bytes for reading by POP B
_dialogs_knocked_his_friend_door_no_clothes:
			.word 90 ; data len to copy to ram
			.byte 45, 16 ; scr pos (y, x)
			TEXT("Friend's mom: Oh, sugar, no clothes means", _LINE_BREAK_)
			TEXT("no pie, remember? We had a straight-up deal.", )


			.word 0 ; safety pair of bytes for reading by POP B
_dialogs_knocked_his_friend_door_clothes_returns:
			.word 154 ; data len to copy to ram
			.byte 45, 16 ; scr pos (y, x)
			TEXT("Friend's mom: Sweetie, you're the best", _LINE_BREAK_)
			TEXT("helper in the world! Here's a fresh-baked", _LINE_BREAK_)
			TEXT("popsicle pie, piping chill. Hurry and take", _LINE_BREAK_)
			TEXT("it home before it warms up!", )


			.word 0 ; safety pair of bytes for reading by POP B
_dialogs_hero_gets_sword:
			.word 176 ; data len to copy to ram
			.byte 45, 16 ; scr pos (y, x)
			TEXT("I don't believe my eyes, It is a legendary", _LINE_BREAK_)
			TEXT("sword, no doubt about it! Who would have", _LINE_BREAK_)
			TEXT("imagined my friend left it for me? This sharpy", _LINE_BREAK_)
			TEXT("little boy will free my friend in no time!", )


			.word 0 ; safety pair of bytes for reading by POP B
_dialogs_knocked_dungeon_entrance:
			.word 130 ; data len to copy to ram
			.byte 45, 16 ; scr pos (y, x)
			TEXT("Oh no! Is it only a demo? So unfair! But", _LINE_BREAK_)
			TEXT("this is not the end! I can hardly wait to", _LINE_BREAK_)
			TEXT("recount the entire story once it's complete!", )


			.word 0 ; safety pair of bytes for reading by POP B
_dialogs_hero_gets_spoon:
			.word 152 ; data len to copy to ram
			.byte 45, 16 ; scr pos (y, x)
			TEXT("A spoon??! No, the spoon! The most iconic", _LINE_BREAK_)
			TEXT("and ancient spoon ever designed, a masterpiece!", _LINE_BREAK_)
			TEXT("Popsicle pie missed you sooo much...", _LINE_BREAK_)
			TEXT("Oh no... it's cursed!", )


			.word 0 ; safety pair of bytes for reading by POP B
_dialogs_hero_use_pie:
			.word 136 ; data len to copy to ram
			.byte 45, 16 ; scr pos (y, x)
			TEXT("This popsicle pie is so delicious! I wish I had", _LINE_BREAK_)
			TEXT("my mouth big enough to swallow it all at", _LINE_BREAK_)
			TEXT("once. Until then, I definitely need a spoon.", )


			.word 0 ; safety pair of bytes for reading by POP B
_dialogs_hero_use_clothes:
			.word 76 ; data len to copy to ram
			.byte 45, 16 ; scr pos (y, x)
			TEXT("Deal's a deal! Promised to fetch and bring", _LINE_BREAK_)
			TEXT("the dry clothes, so get to it!", )


			.word 0 ; safety pair of bytes for reading by POP B
_dialogs_mom_first_hi:
			.word 160 ; data len to copy to ram
			.byte 45, 16 ; scr pos (y, x)
			TEXT("Mom: Hey sweetie! You're up bright and early-", _LINE_BREAK_)
			TEXT("up to your usual shenanigans, I bet! But hey,", _LINE_BREAK_)
			TEXT("don't forget to visit Uncle Bob, okay? He's", _LINE_BREAK_)
			TEXT("been asking for you!", )


			.word 0 ; safety pair of bytes for reading by POP B
_dialogs_bob_first_hi:
			.word 176 ; data len to copy to ram
			.byte 45, 16 ; scr pos (y, x)
			TEXT("Uncle Bob: My hero! Just in time! I need you", _LINE_BREAK_)
			TEXT("to shoo off those pesky crows from my field.", _LINE_BREAK_)
			TEXT("There's a scarecrow chillin' in the backyard-", _LINE_BREAK_)
			TEXT("go grab it and plant it like a champ!", )


			.word 0 ; safety pair of bytes for reading by POP B
_dialogs_bob_waits_scare:
			.word 94 ; data len to copy to ram
			.byte 45, 16 ; scr pos (y, x)
			TEXT("Uncle Bob: I am waiting you to shoo off", _LINE_BREAK_)
			TEXT("those pesky crows from my field.", _LINE_BREAK_)
			TEXT("TODO: update text", )

;===================================================================================
; storytelling
;===================================================================================

			.word 0 ; safety pair of bytes for reading by POP B
_storytelling_storytelling_home:
			.word 126 ; data len to copy to ram
			.byte 45, 16 ; scr pos (y, x)
			TEXT("Rad day for my morning jog! Legs are ready", _LINE_BREAK_)
			TEXT("for some serious adventuring action.", _LINE_BREAK_)
			TEXT("If it's all about collecting, count me in!", )


			.word 0 ; safety pair of bytes for reading by POP B
_storytelling_storytelling_farm_fence:
			.word 164 ; data len to copy to ram
			.byte 45, 16 ; scr pos (y, x)
			TEXT("Oh my glob, guess what? Mom's on a cabbage", _LINE_BREAK_)
			TEXT("quest, and you know what they say - no", _LINE_BREAK_)
			TEXT("cabbage left behind! Gonna scoop up those", _LINE_BREAK_)
			TEXT("leafy greens like a true adventurer!", )


			.word 0 ; safety pair of bytes for reading by POP B
_storytelling_storytelling_road_to_friends_home:
			.word 138 ; data len to copy to ram
			.byte 45, 16 ; scr pos (y, x)
			TEXT("Wait a minute! Who's the cheeky one", _LINE_BREAK_)
			TEXT("cluttering up the road? Gotta snag a hero", _LINE_BREAK_)
			TEXT("thingamajig to clear the path for some", _LINE_BREAK_)
			TEXT("righteous heroing!", )


			.word 0 ; safety pair of bytes for reading by POP B
_storytelling_storytelling_friends_home:
			.word 110 ; data len to copy to ram
			.byte 45, 16 ; scr pos (y, x)
			TEXT("Check it, my buddy's cave! He said he'd", _LINE_BREAK_)
			TEXT("be around today. Gotta jog his memory", _LINE_BREAK_)
			TEXT("'bout that promise, ya know?", )


			.word 0 ; safety pair of bytes for reading by POP B
_storytelling_storytelling_friends_backyard:
			.word 150 ; data len to copy to ram
			.byte 45, 16 ; scr pos (y, x)
			TEXT("Really??? It looks like a hidden lair in", _LINE_BREAK_)
			TEXT("the bushes! I'm gonna investigate my", _LINE_BREAK_)
			TEXT("friend's secret spot. Those bones at the", _LINE_BREAK_)
			TEXT("entrance are a spooky clue!", )


			.word 0 ; safety pair of bytes for reading by POP B
_storytelling_storytelling_friends_secret_place:
			.word 148 ; data len to copy to ram
			.byte 45, 16 ; scr pos (y, x)
			TEXT("Oh no, there are bones and skulls all over", _LINE_BREAK_)
			TEXT("the place! I worry my friend can be in a real", _LINE_BREAK_)
			TEXT("danger! I gonna find and rescue him no matter", _LINE_BREAK_)
			TEXT("the cost!", )


			.word 0 ; safety pair of bytes for reading by POP B
_storytelling_storytelling_crossroad:
			.word 168 ; data len to copy to ram
			.byte 45, 16 ; scr pos (y, x)
			TEXT("I'm shaken! A terrible char and the corpses", _LINE_BREAK_)
			TEXT("of our beloved villagers! It's clear who the", _LINE_BREAK_)
			TEXT("culprit is here! You better be trembling!", _LINE_BREAK_)
			TEXT("I'm going to teach you a lesson!!!", )


			.word 0 ; safety pair of bytes for reading by POP B
_storytelling_storytelling_loop:
			.word 90 ; data len to copy to ram
			.byte 45, 16 ; scr pos (y, x)
			TEXT("You better watch out, little rolling furry", _LINE_BREAK_)
			TEXT("burner, because there's no escaping from me!", )


			.word 0 ; safety pair of bytes for reading by POP B
_storytelling_storytelling_lost_coins:
			.word 174 ; data len to copy to ram
			.byte 45, 16 ; scr pos (y, x)
			TEXT("Wow, wow, wow!!! My intuition never fails me!", _LINE_BREAK_)
			TEXT("I just knew there had to be treasures on this", _LINE_BREAK_)
			TEXT("heroic journey! Everyone, look at my pockets,", _LINE_BREAK_)
			TEXT("coins are about to overflow them!", )


			.word 0 ; safety pair of bytes for reading by POP B
_storytelling_storytelling_farm_entrance:
			.word 158 ; data len to copy to ram
			.byte 45, 16 ; scr pos (y, x)
			TEXT("Every time I lay eyes on cabbage, I get all", _LINE_BREAK_)
			TEXT("hungry up in here. But you gotta watch out,", _LINE_BREAK_)
			TEXT("'cause if you munch too much, your tummy", _LINE_BREAK_)
			TEXT("might throw a grumble fit!", )


			.word 0 ; safety pair of bytes for reading by POP B
_storytelling_storytelling_farm_storage:
			.word 146 ; data len to copy to ram
			.byte 45, 16 ; scr pos (y, x)
			TEXT("Who's that dude on my road? Not cool", _LINE_BREAK_)
			TEXT("with his mega-spooky vibe. Lucky", _LINE_BREAK_)
			TEXT("for us, he's shieldless. Time to fuel", _LINE_BREAK_)
			TEXT("up with cabbages to overspook him!", )


			.word 0 ; safety pair of bytes for reading by POP B
_storytelling_storytelling_dugeon_entrance:
			.word 138 ; data len to copy to ram
			.byte 45, 16 ; scr pos (y, x)
			TEXT("Wily skeletons and a wall of fire - that's", _LINE_BREAK_)
			TEXT("a real hero's challenge! Gotta figure out", _LINE_BREAK_)
			TEXT("how to extinguish it before they surrender", _LINE_BREAK_)
			TEXT("to me!", )


			.word 0 ; safety pair of bytes for reading by POP B
_storytelling_hero_use_cabbage:
			.word 116 ; data len to copy to ram
			.byte 45, 16 ; scr pos (y, x)
			TEXT("Cabbages... so yummy-wummy! I can feel", _LINE_BREAK_)
			TEXT("myself getting all rested up and fresh!", _LINE_BREAK_)
			TEXT("But my tummy does little ghrrr...", )


			.word 0 ; safety pair of bytes for reading by POP B
_storytelling_hero_use_spoon:
			.word 182 ; data len to copy to ram
			.byte 45, 16 ; scr pos (y, x)
			TEXT("Finally, feasted on my favorite popsicle-pie!", _LINE_BREAK_)
			TEXT("Oh, what's this? Some snowflakes left behind.", _LINE_BREAK_)
			TEXT("I'll just pop'em in my pocket, you never know", _LINE_BREAK_)
			TEXT("what might come in handy on an adventure!", )


			.word 0 ; safety pair of bytes for reading by POP B
_storytelling_hero_freeze_char:
			.word 122 ; data len to copy to ram
			.byte 45, 16 ; scr pos (y, x)
			TEXT("Aha! So that's how it works. If you're all", _LINE_BREAK_)
			TEXT("spooky and scary, get a snowflake to the", _LINE_BREAK_)
			TEXT("noggin! It'll chill you out a bit!", )

