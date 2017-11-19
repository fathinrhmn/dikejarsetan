var xx,yy,c1,c2,c3,c4;

// Apply gravity (and jumping)
y = y+grav;
grav+=gravdelta;
if( grav>=gravmax ) grav=gravmax;

/////////////////////
//    JUMP/FALL    //
/////////////////////

if( grav<0 ){							// If jumping check above player
	if( hp==3 ){
		sprite_index = sJump;
	} else if (hp==2){
		sprite_index = sJump1;
	} else {
		sprite_index = sJump11;
	}
    
} else {									// otherwise, falling so check UNDER the player
    if(jump){
		if( hp==3 ){
			sprite_index = sJump;
		} else if (hp==2){
			sprite_index = sJump1;
		} else {
			sprite_index = sJump11;
		}								// if coming down after jumping display the correct sprite

    } else if(fall){
		if( hp==3 ){
			sprite_index = sJump; 
		} else if (hp==2){
			sprite_index = sJump1; 
		} else {
			sprite_index = sJump11; 
		}						
           
    } else {								// if not already falling or jumping
		grav = 0;							// first stop falling (used for ladders)
		fall = true;						// flag that we are falling
	}
	// check the points at the bottom of the player character
	c1 = tilemap_get_at_pixel(oGame.map,x-(sprite_get_width(sprite_index)/2),y);	// left
	c2 = tilemap_get_at_pixel(oGame.map,x+(sprite_get_width(sprite_index)/2),y);	// right
	c3 = tilemap_get_at_pixel(oGame.map,x,y);										// center

	if( c1>=1 || c2>=1 || c3 >= 1){			// if they are intersecting with a tile
		if((c1 == 1) || (c2 == 1) || (c3 == 1) || (c1 == 3) || (c2 == 3) || (c3 == 3)){
			// if the tile we are intersecting with cannot be fallen through
			y = real(y&$ffffffc0);			// move the sprite to the top of the tile
			climbing = false;				// stop any climbing
			jump = false;					// stop any jumping
			fall = false;					// stop any falling
		}
		if((c3 == 2) || (c3 == 2)){			// if we are intersecting with a ladder
			can_climb = true;				// flag that we can climb
		}
	} else {								// if we are not intersecting any tiles
		climbing = false;					// flag that we cannot climb
	}
}    

/////////////////////
//     MOVING      //
/////////////////////

if(keyboard_check(vk_down)){
//keyboard_check(vk_left)				// moving left collisions
    dir=1;									// set the correct direction
	image_xscale = dir;						// make the sprite face the correct direction
	climbing = false;						// since we are moving left we are not climbing
	can_climb = false;						// and we cannot climb
    if(!jump && !fall){						// if we are not jumping or falling
		if( hp==3 ){
			sprite_index = sDuck;				// set the sprite to walking
		} else if (hp==2){
			sprite_index = sDuck1;				// set the sprite to walking
		} else {
			sprite_index = sDuck11;				// set the sprite to walking
		}
    }
    x=x+xspeed								// move the player right
    c2 = -1;
	c3 = -1;
	// check the points at the bottom of the sprite
    c1 = tilemap_get_at_pixel(oGame.map,x-(sprite_get_width(sprite_index)/2),y-1);				// left
    c3 = tilemap_get_at_pixel(oGame.map,x,y-1);													// center
    if( y&$3f>0 ) c2=tilemap_get_at_pixel(oGame.map,x-(sprite_get_width(sprite_index)/2),y+1);	// left below (only check if there is a tile below)
    if(c1 == 3) || (c2 == 3){																	// if we are intersecting with a box
		x = real(x&$ffffffc0)+(sprite_get_width(sprite_index)/2);								// stop the player from moving
    }
	if(c3 == 2){							// if we are intersecting with a ladder
		can_climb = true;					// flag that we can climb
	} else {								// if we are not a ladder
		can_climb = false;					// flag we cant climb
		image_speed = anim_speed;			// make sure the animations will play at correct speed
	}
	if(x < 0){								// the the player has moved off the edge of the screen
		x = room_width;						// wrap around to the other side of the screen
	}
}else if(true){			// moving right collisions (check with else so that both directions cant be triggered at the same time)
    dir=1;									// set the correct direction
	image_xscale = dir;						// make the sprte face the correct direction 
	climbing = false;						// set that we are not climbing
	can_climb = false;						// set that we cant climb
    if(!jump && !fall){						// if we are not jumping or falling
        if( hp=3 ){
			sprite_index = sWalk;				// set the sprite to walking
		} else if (hp=2){
			sprite_index = sWalk1;				// set the sprite to walking
		} else {
			sprite_index = sWalk11;				// set the sprite to walking
		}
    }
    x=x+xspeed;								// move the player right
    c2 = -1;
	c3 = -1;
	// check the points at the bottom of the sprite
    c1 = tilemap_get_at_pixel(oGame.map,x+(sprite_get_width(sprite_index)/2),y-1);				// right
	c3 = tilemap_get_at_pixel(oGame.map,x,y-1);													// center
    if( y&$3f>0 ) c2=tilemap_get_at_pixel(oGame.map,x+(sprite_get_width(sprite_index)/2),y+1);	// right below (only check if there is a tile below)
    if(c1 == 3) || (c2 == 3){																	// if we are intersecting with a box
			x = real(x&$ffffffc0)+oGame.tilesize-(sprite_get_width(sprite_index)/2);			// stop the player from moving
    }
	if(c3 == 2){							// if we are intersecting with a ladder
		can_climb = true;					// flag that we can climb
	} else {								// if we are not a ladder
		can_climb = false;					// flag we cant climb
		image_speed = anim_speed;			// make sure the animations will play at correct speed
	}
	if(x > room_width){						// the the player has moved off the edge of the screen
		x = 0;								// wrap around to the other side of the screen
	}
	
}




