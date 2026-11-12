draw_set_halign(fa_center);
draw_set_valign(fa_middle);

draw_set_color(c_white);

switch (current_state) {
    case SHOWDOWN_STATE.SPINNING:
        draw_text(room_width / 1.2, room_height / 2, "Spinning \ncylinders...");
        break;
        
    case SHOWDOWN_STATE.READY_WAIT:
        draw_text(room_width / 1.2, room_height / 2, "Steady... \nDon't squeeze yet...");
        break;
        
    case SHOWDOWN_STATE.DUELING:
        draw_text(room_width / 1.2, room_height / 2, "DRAW!!!\nMASH SPACEBAR!");
        break;
        
    case SHOWDOWN_STATE.GAME_OVER:
        var result_text = "";
        if (player_soaked && cowboy_soaked) {
            result_text = "MUTUAL DESTRUCTION!\nYou both \ngot soaked!";
        } else if (cowboy_soaked) {
            result_text = "VICTORY!\nYou drew faster \nand soaked him!";
        } else if (player_soaked) {
            result_text = "DEFEAT!\nThe cowboy \nblasted you first!";
        } else {
            result_text = "TIME'S UP!\nYou both \nchickened out.";
        }
        
		draw_text(room_width / 5.5, room_height / 1.85, "Programmer/Designer: \nKingOfHearts\nArtist: \nLuluGoddess\nMusic: \nCasualMalarkey");
		
        draw_text(room_width / 1.2, room_height / 2, result_text + "\nPress 'R' \nto Rematch");
        break;
}

draw_set_color(c_white);