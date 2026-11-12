function scr_PullTrigger(_shooter){
    if (_shooter == 0) {
        // --- Player fires at Cowboy ---
        if (player_current_chamber == player_water_chamber) {
            // SUCCESS! Cowboy gets wet.
            cowboy_soaked = true;
            //audio_play_sound(snd_water_blast, 10, false);
        } else {
            // CLICK! Advance player cylinder
            //audio_play_sound(snd_dry_click, 10, false);
            player_current_chamber = (player_current_chamber + 1) % player_total_chambers;
        }
    } else {
        // --- Cowboy fires at Player ---
        if (cowboy_current_chamber == cowboy_water_chamber) {
            // SUCCESS! Player gets wet.
            player_soaked = true;
            //audio_play_sound(snd_water_blast, 10, false);
        } else {
            // CLICK! Advance cowboy cylinder
            //audio_play_sound(snd_dry_click, 10, false);
            cowboy_current_chamber = (cowboy_current_chamber + 1) % cowboy_total_chambers;
        }
    }
}