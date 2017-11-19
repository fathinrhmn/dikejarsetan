draw_set_font(fTahoma24);											// set the font to draw text with
draw_set_valign(fa_middle);											// use the middle to position vertically
draw_set_halign(fa_right);											// use the right to position horizontally
draw_set_colour(c_black);											// set the colour to draw text

if instance_exists(oPlayer)
{
	for(i=0;i<oPlayer.hp;i++){												// loop through the number of hearts we have
		draw_sprite(sHeart,0,50+(sprite_get_width(sHeart)*i),50);		// draw if we have them
	}
	
	draw_set_color(c_white);
	draw_text(window_get_width()/2, 50, "Score: " + string(oPlayer.myscore));
}

