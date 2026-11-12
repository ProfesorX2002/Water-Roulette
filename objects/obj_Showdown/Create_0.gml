//set window size
window_set_size(1240, 720);

//enable audio loop
music = audio_play_sound(snd_Duel, 100, true);
audio_sound_loop(music, true);

// Game States
enum SHOWDOWN_STATE {
    START,
    SPINNING,
    READY_WAIT, // Tension building, waiting for the "SHOOT!" signal
    DUELING,    // The split-second window to pull the trigger
    GAME_OVER
}

current_state = SHOWDOWN_STATE.START;

// Roulette Mechanics
// --- Gun 0: Player ---
player_water_chamber = -1;
player_current_chamber = 0;
player_has_shot = false;
player_soaked = false;
player_total_chambers = 6;

// --- Gun 1: Opponent Cowboy ---
cowboy_water_chamber = -1;
cowboy_current_chamber = 0;
cowboy_has_shot = false;
cowboy_soaked = false;
cowboy_total_chambers = 6;

// Timers
state_timer = 0;
duel_timer = 0;