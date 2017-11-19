/// Init
tilesize = 64;															// size of tiles
map = layer_tilemap_get_id("Collisions");								// this will be the layer we use for collisions
hills = layer_get_all_elements("Hills");								// all the hill sprites
clouds = layer_get_all_elements("Clouds");	// all the cloud sprites

audio_play_sound(backgroundSound,1,true)								//background sound