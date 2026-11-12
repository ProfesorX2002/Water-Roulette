switch (current_state) {
    
    case SHOWDOWN_STATE.START:
        // Reset flags
        player_has_shot = false;
        player_soaked = false;
        cowboy_has_shot = false;
        cowboy_soaked = false;
        obj_Chamber.sprite_index = spr_Chamber;
		obj_Player.sprite_index = spr_Player;
		obj_Cowboy.sprite_index = spr_Cowboy;
		obj_Player.image_index = 0;
		obj_Cowboy.image_index = 0;
		obj_Player.image_speed = 0;
		obj_Cowboy.image_speed = 0;
		
        // Randomize the water chamber for BOTH individual guns
        player_water_chamber = irandom(player_total_chambers - 1);
        cowboy_water_chamber = irandom(cowboy_total_chambers - 1);
        
        current_state = SHOWDOWN_STATE.SPINNING;
        state_timer = room_speed * 2; // 2 seconds of spinning cylinder sounds
        break;
        
    case SHOWDOWN_STATE.SPINNING:
        state_timer--;
        if (state_timer <= 0) {
            // Randomly stop both cylinders
            player_current_chamber = irandom(player_total_chambers - 1);
            cowboy_current_chamber = irandom(cowboy_total_chambers - 1);
            
			//spin chamber, set sprite
			obj_Chamber.image_speed = 1;
			
            // Move to the tense waiting phase
            current_state = SHOWDOWN_STATE.READY_WAIT;
            // Random delay before the signal to shoot (between 2 and 5 seconds)
            state_timer = room_speed * random_range(2, 5); 
        }
        break;
        
    case SHOWDOWN_STATE.READY_WAIT:
        // TENSE SILENCE. If the player shoots early, they misfire/fail!
        if (keyboard_check_pressed(vk_space)) {
            // Penalty: Player jams their gun or gets a 1-second delay
            //audio_play_sound(snd_dry_click, 10, false);
        }
        
		obj_Player.image_speed = 0.35;
		obj_Cowboy.image_speed = 0.35;
		
		if (obj_Player.image_index >= obj_Player.image_number - 1) {
            obj_Player.image_index = obj_Player.image_number - 1;
            obj_Player.image_speed = 0;
        }
		
        if (obj_Cowboy.image_index >= obj_Cowboy.image_number - 1) {
            obj_Cowboy.image_index = obj_Cowboy.image_number - 1;
            obj_Cowboy.image_speed = 0;
        }
		
        state_timer--;
        if (state_timer <= 0) {
            current_state = SHOWDOWN_STATE.DUELING;
            duel_timer = room_speed * 3; // 3 seconds to resolve the duel
            
            // Determine a random reaction time for the AI Cowboy (e.g., 0.2 to 0.7 seconds)
            cowboy_reaction_time = room_speed * random_range(0.2, 0.7);
        }
        break;
        
    case SHOWDOWN_STATE.DUELING:
        duel_timer--;
        cowboy_reaction_time--;
        
        // --- 1. Handle Player Input (Mash Spacebar to cycle and shoot!) ---
        if (keyboard_check_pressed(vk_space)) {
            scr_PullTrigger(0); // 0 = Player fires at Cowboy
        }
        
        // --- 2. Handle AI Cowboy Input ---
        if (cowboy_reaction_time <= 0 && !cowboy_soaked && !player_soaked) {
            scr_PullTrigger(1); // 1 = Cowboy fires at Player
            // Reset reaction time for his NEXT shot if he misses (e.g., fires every 0.4 seconds)
            cowboy_reaction_time = room_speed * 0.4; 
        }
        
        // --- 3. Check Win/Loss Conditions ---
        if (player_soaked || cowboy_soaked || duel_timer <= 0) {
            current_state = SHOWDOWN_STATE.GAME_OVER;
			
		if (cowboy_soaked) {
                obj_Cowboy.sprite_index = spr_CowboyDeath;
                obj_Cowboy.image_index = 0;
                obj_Cowboy.image_speed = 0.5;
                obj_Chamber.sprite_index = spr_Empty;
                obj_Chamber.image_speed = 0;
            } 
            else if (player_soaked) {
                obj_Player.sprite_index = spr_PlayerDeath;
                obj_Player.image_index = 0;
                obj_Player.image_speed = 0.5;
                obj_Chamber.image_speed = 0;
            }
        }
        break;
        
    case SHOWDOWN_STATE.GAME_OVER:
        // --- Freeze animations on their final frame ---
        if (cowboy_soaked) {
            if (obj_Cowboy.image_index >= obj_Cowboy.image_number - 1) {
                obj_Cowboy.image_index = obj_Cowboy.image_number - 1;
                obj_Cowboy.image_speed = 0;
            }
        }
        else if (player_soaked) {
            if (obj_Player.image_index >= obj_Player.image_number - 1) {
                obj_Player.image_index = obj_Player.image_number - 1;
                obj_Player.image_speed = 0;
            }
        }
        
        // Restart game
        if (keyboard_check_pressed(ord("R"))) {
            current_state = SHOWDOWN_STATE.START;
        }
        break;
}