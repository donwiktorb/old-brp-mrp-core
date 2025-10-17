
Config.Props = {}

Config.Animations = {

	{
        name = 'Wspólne',
        label = '🤝 Wspólne',
        items = {
            {label = "Przytul 1", type = "syncAnim", data = {lib = "mp_ped_interaction", anim = "kisses_guy_a", car = 0, loop = 0, e = "przytul", offset = 1.1}},
            {label = "Slap", type = "syncAnim", data = {lib = "melee@unarmed@streamed_variations", anim = "plyr_takedown_front_slap", car = 0, loop = 0, e = "slap", offset = 1.1}, data2 = {lib = "melee@unarmed@streamed_variations", anim = "victim_takedown_front_slap", car = 0, loop = 0, e = "slapped"}},

        }
    },

    {
        name = 'Wyraz twarzy',
        label = '😘 Wyraz twarzy',
        items = {
		    {label = "Neutralny", type = "faceexpression", data = {anim = "mood_Normal_1", e = "neutralny"}},
		    {label = "Szczęśliwy", type = "faceexpression", data = {anim = "mood_Happy_1", e = "szczesliwy"}},
		    {label = "Zły", type = "faceexpression", data = {anim = "mood_Angry_1", e = "zly"}},		
		    {label = "Podejrzliwy", type = "faceexpression", data = {anim = "mood_Aiming_1", e = "podejrzliwy"}},
		    {label = "Ból", type = "faceexpression", data = {anim = "mood_Injured_1", e = "bol"}},
		    {label = "Zdenerwowany", type = "faceexpression", data = {anim = "mood_stressed_1", e = "zdenerwowany"}},
		    {label = "Zadowolony", type = "faceexpression", data = {anim = "mood_smug_1", e = "zadowolony"}},
		    {label = "Podpity", type = "faceexpression", data = {anim = "mood_drunk_1", e = "podpity"}},
		    {label = "Zszokowany", type = "faceexpression", data = {anim = "shocked_1", e = "zszokowany"}},
		    {label = "Zamknięte oczy", type = "faceexpression", data = {anim = "mood_sleeping_1", e = "oczy"}},
		    {label = "Przeżuwanie", type = "faceexpression", data = {anim = "eating_1", e = "zucie"}},
        }
    },
	
    {
      name  = 'Style chodzenia',
      label = '🚶‍♂️ Style chodzenia',
      items = {
          {label = "Normalny [K]", type = "walkstyle", data = {lib = "move_f@generic", anim = "move_f@generic"}},
          {label = "Normalny [M]", type = "walkstyle", data = {lib = "move_m@generic", anim = "move_m@generic"}},
          {label = "Pewniak [K]", type = "walkstyle", data = {lib = "move_f@heels@d", anim = "move_f@heels@d"}},
          {label = "Pewniak [M]", type = "walkstyle", data = {lib = "move_m@confident", anim = "move_m@confident"}},
          {label = "Gruby [K]", type = "walkstyle", data = {lib = "move_f@fat@a", anim = "move_f@fat@a"}},
          {label = "Gruby [M]", type = "walkstyle", data = {lib = "move_m@fat@a", anim = "move_m@fat@a"}},
		  {label = "Policjant 1", type = "walkstyle", data = {lib = "move_m@business@c", anim = "move_m@business@c"}},
		  {label = "Policjant 2", type = "walkstyle", data = {lib = "move_m@business@b", anim = "move_m@business@b"}},
		  {label = "Starość", type = "walkstyle", data = {lib = "move_heist_lester", anim = "move_heist_lester"}},
          {label = "Poszkodowany [K]", type = "walkstyle", data = {lib = "move_f@injured", anim = "move_f@injured"}},
          {label = "Poszkodowany [M]", type = "walkstyle", data = {lib = "move_m@injured", anim = "move_m@injured"}},
          {label = "Zuchwały [K]", type = "walkstyle", data = {lib = "move_f@sassy", anim = "move_f@sassy"}},
          {label = "Zuchwały [M]", type = "walkstyle", data = {lib = "move_m@sassy", anim = "move_m@sassy"}},
          {label = "Smutny", type = "walkstyle", data = {lib = "move_m@depressed@a", anim = "move_m@depressed@a"}},
          {label = "Biznes", type = "walkstyle", data = {lib = "move_m@business@a", anim = "move_m@business@a"}},
          {label = "Odważny", type = "walkstyle", data = {lib = "move_m@brave@a", anim = "move_m@brave@a"}},
          {label = "Luzak", type = "walkstyle", data = {lib = "move_m@casual@e", anim = "move_m@casual@e"}},
          {label = "Hipster", type = "walkstyle", data = {lib = "move_m@hipster@a", anim = "move_m@hipster@a"}},
          {label = "Smutny", type = "walkstyle", data = {lib = "move_m@sad@a", anim = "move_m@sad@a"}},
          {label = "Siłacz", type = "walkstyle", data = {lib = "move_m@muscle@a", anim = "move_m@muscle@a"}},
          {label = "Gangster 1", type = "walkstyle", data = {lib = "move_m@gangster@generic", anim = "move_m@gangster@generic"}},
          {label = "Gangster 2", type = "walkstyle", data = {lib = "move_m@money", anim = "move_m@money"}},
          {label = "Bezdomny", type = "walkstyle", data = {lib = "move_m@hobo@a", anim = "move_m@hobo@a"}},
          {label = "Pijany 1", type = "walkstyle", data = {lib = "move_m@buzzed", anim = "move_m@buzzed"}},
          {label = "Pijany 2", type = "walkstyle", data = {lib = "move_m@drunk@moderatedrunk", anim = "move_m@drunk@moderatedrunk"}},
          {label = "Pijany 3", type = "walkstyle", data = {lib = "move_m@drunk@verydrunk", anim = "move_m@drunk@verydrunk"}},
          {label = "W pośpiechu 1", type = "walkstyle", data = {lib = "move_m@hurry_butch@b", anim = "move_m@hurry_butch@b"}},
          {label = "W pośpiechu 2", type = "walkstyle", data = {lib = "move_m@hurry@b", anim = "move_m@hurry@b"}},
          {label = "Szybki", type = "walkstyle", data = {lib = "move_m@quick", anim = "move_m@quick"}},
      }
   },
   
	{
        name = 'Przywitanie',
        label = '🙋‍♂️ Przywitanie',
        items = {
            {label = "Siemka [R][P]", type = "anim", data = {lib = "gestures@m@standing@casual", anim = "gesture_hello", car = 1, loop = 56, e = "siema"}},
            {label = "Hej - pomachanie ręką [R]", type = "anim", data = {lib = "missmic4premiere", anim = "wave_a", car = 0, loop = 56, e = "hej"}},
            {label = "Salut 1 - luźny [R]", type = "anim", data = {lib = "anim@mp_player_intcelebrationmale@salute", anim = "salute", car = 0, loop = 56, e = "salut"}},
			{label = "Salut 2 - wojskowy [P]", type = "anim", data = {lib = "anim@mp_player_intincarsalutestd@ds@", anim = "enter", car = 1, loop = 2, e = "salut2"}},
        }
    },
	
	{
        name = 'Reakcje',
        label = '😮 Reakcje',
        items = {
	     	{label = "Facepalm 1 [R][P]", type = "anim", data = {lib = "anim@mp_player_intcelebrationmale@face_palm", anim = "face_palm", car = 1, loop = 56, e = "facepalm"}},      
	     	{label = "Facepalm 2 [R][P]", type = "anim", data = {lib = "anim@mp_player_intupperface_palm", anim = "enter", car = 1, loop = 50, e = "facepalm2"}},   			
	     	{label = "Nie wierze [R][P]", type = "anim", data = {lib = "anim@mp_player_intcelebrationfemale@face_palm", anim = "face_palm", car = 1, loop = 56, e = "niewierze"}},
			{label = "Złapanie się za głowę [R]", type = "anim", data = {lib = "mini@dartsoutro", anim = "darts_outro_01_guy2", car = 0, loop = 56, e = "zaglowe"}},			
		    {label = "Tak [R][P]", type = "anim", data = {lib = "gestures@f@standing@casual", anim = "gesture_pleased", car = 1, loop = 57, e = "tak"}},
            {label = "Nie [R][P]", type = "anim", data = {lib = "gestures@f@standing@casual", anim = "gesture_head_no", car = 1, loop = 57, e = "nie"}},
	     	{label = "Nie ma mowy [R]", type = "anim", data = {lib = "gestures@f@standing@casual", anim = "gesture_no_way", car = 0, loop = 56, e = "niemamowy"}},
            {label = "Wzruszenie ramionami [R][P]", type = "anim", data = {lib = "gestures@f@standing@casual", anim = "gesture_shrug_hard", car = 1, loop = 56, e = "wzruszenie"}},
		    {label = "Muka", type = "anim", data = {lib = "anim@mp_player_intselfiedock", anim = "idle_a", car = 0, loop = 50, e = "muka"}}, 
		    {label = "Pukanie", type = "anim", data = {lib = "timetable@jimmy@doorknock@", anim = "knockdoor_idle", car = 0, loop = 50, e = "pukanie"}}, 
			{label = "Chodź tu [R][P]", type = "anim", data = {lib = "gestures@f@standing@casual", anim = "gesture_come_here_soft", car = 1, loop = 57, e = "chodz"}},
            {label = "Co? [R][P]", type = "anim", data = {lib = "gestures@f@standing@casual", anim = "gesture_what_hard", car = 1, loop = 56, e = "co"}},
            {label = "Szlag! [R][P]", type = "anim", data = {lib = "gestures@f@standing@casual", anim = "gesture_damn", car = 1, loop = 56, e = "szlag"}},
			{label = "Cicho! [R][P]", type = "anim", data = {lib = "anim@mp_player_intuppershush", anim = "idle_a_fp", car = 1, loop = 58, e = "cicho"}},	           
		    {label = "Halo! [R]", type = "anim", data = {lib = "friends@frj@ig_1", anim = "wave_d", car = 0, loop = 56, e = "halo"}},
		    {label = "Tu jestem! [R]", type = "anim", data = {lib = "friends@frj@ig_1", anim = "wave_c", car = 0, loop = 56, e = "tujestem"}},
			{label = "To nie ja", type = "anim", data = {lib = "anim@arena@celeb@flat@solo@no_props@", anim = "taunt_b_player_a", car = 0, loop = 0, e = "tonieja"}},		
            {label = "Przepraszam", type = "anim", data = {lib = "anim@arena@celeb@flat@solo@no_props@", anim = "wow_a_player_b", car = 0, loop = 0, e = "przepraszam"}},		  
		    {label = "Kciuki w górę 1 [R][P]", type = "anim", data = {lib = "anim@mp_player_intincarthumbs_upbodhi@ps@", anim = "enter", car = 1, loop = 58, e = "kciuk1"}},
			{label = "Kciuki w górę 2 [R][P]", type = "anim", data = {lib = "anim@mp_player_intupperthumbs_up", anim = "idle_a", car = 1, loop = 58, e = "kciuk2"}},
			{label = "Kciuki w górę 3 [R][P]", type = "anim", data = {lib = "anim@mp_player_intselfiethumbs_up", anim = "idle_a", car = 1, loop = 58, e = "kciuk3"}},
			{label = "Kciuk w dół", type = "anim", data = {lib = "anim@arena@celeb@flat@solo@no_props@", anim = "thumbs_down_a_player_b", car = 0, loop = 0, e = "kciuk4"}},
            {label = "Kciuk jednak w dół", type = "anim", data = {lib = "anim@arena@celeb@flat@solo@no_props@", anim = "thumbs_down_a_player_a", car = 0, loop = 0, e = "kciuk5"}},			   
            {label = "Uspokój się [R]", type = "anim", data = {lib = "gestures@f@standing@casual", anim = "gesture_easy_now", car = 0, loop = 56, e = "spokojnie"}},   
            {label = "Piąteczka [R]", type = "anim", data = {lib = "anim@arena@celeb@flat@paired@no_props@", anim = "high_five_c_player_b", car = 0, loop = 50, e = "piateczka"}},
            {label = "Brawa 1", type = "anim", data = {lib = "anim@arena@celeb@flat@solo@no_props@", anim = "angry_clap_a_player_a", car = 0, loop = 0, e = "brawa"}},
            {label = "Brawa 2", type = "anim", data = {lib = "anim@arena@celeb@flat@solo@no_props@", anim = "angry_clap_b_player_a", car = 0, loop = 0, e = "brawa2"}},
            {label = "Brawa 3", type = "anim", data = {lib = "anim@arena@celeb@flat@solo@no_props@", anim = "angry_clap_b_player_b", car = 0, loop = 0, e = "brawa3"}},
            {label = "Cieszynka 1 [R]", type = "anim", data = {lib = "anim@arena@celeb@flat@solo@no_props@", anim = "jump_a_player_a", car = 0, loop = 50, e = "cieszynka"}},
            {label = "Cieszynka 2 - skok przez kozła", type = "anim", data = {lib = "anim@arena@celeb@flat@solo@no_props@", anim = "jump_b_player_a", car = 0, loop = 0, e = "cieszynka2"}},
            {label = "Cieszynka 3 - szpagat", type = "anim", data = {lib = "anim@arena@celeb@flat@solo@no_props@", anim = "jump_c_player_a", car = 0, loop = 0, e = "cieszynka3"}},
            {label = "Cieszynka 4 - podskok", type = "anim", data = {lib = "anim@arena@celeb@flat@solo@no_props@", anim = "jump_d_player_a", car = 0, loop = 0, e = "cieszynka4"}},	
            {label = "Śmiech 1", type = "anim", data = {lib = "anim@arena@celeb@flat@paired@no_props@", anim = "laugh_a_player_b", car = 0, loop = 0, e = "smiech1"}},
			{label = "Śmiech 2", type = "anim", data = {lib = "anim@arena@celeb@flat@solo@no_props@", anim = "giggle_a_player_b", car = 0, loop = 50, e = "smiech2"}},	
			{label = "Zwycięzca 1 [R]", type = "anim", data = {lib = "anim@arena@celeb@podium@no_prop@", anim = "dance_b_1st", car = 0, loop = 50, e = "zwyciezca"}},
            {label = "Zwycięzca 2 [R]", type = "anim", data = {lib = "anim@arena@celeb@podium@no_prop@", anim = "make_noise_a_1st", car = 0, loop = 50, e = "zwyciezca2"}},
            {label = "Udawanie śmierci ", type = "anim", data = {lib = "anim@arena@celeb@flat@solo@no_props@", anim = "pageant_a_player_b", car = 0, loop = 0, e = "udawanie"}},
            {label = "Wślizg na kolanach", type = "anim", data = {lib = "anim@arena@celeb@flat@solo@no_props@", anim = "slide_a_player_a", car = 0, loop = 0, e = "wslizg"}},           
		    {label = "Zamyślenie 1 [R]", type = "anim", data = {lib = "anim@arena@celeb@podium@no_prop@", anim = "dance_b_3rd", car = 0, loop = 56, e = "zamyslenie"}},
            {label = "Zamyślenie 2 [R]", type = "anim", data = {lib = "anim@arena@celeb@podium@no_prop@", anim = "make_noise_a_2nd", car = 0, loop = 56, e = "zamyslenie2"}},
            {label = "Znak Gangu 1", type = "anim", data = {lib = "mp_player_int_uppergang_sign_b", anim = "mp_player_int_gang_sign_b", car = 0, loop = 56, e = "znakgangu1"}},
            {label = "Znak Gangu 2", type = "anim", data = {lib = "mp_player_int_uppergang_sign_a", anim = "mp_player_int_gang_sign_a", car = 0, loop = 56, e = "znakgangu2"}},
            {label = "Gwizdanie 1", type = "anim", data = {lib = "taxi_hail", anim = "hail_taxi", car = 0, loop = 56, e = "gwizdanie1"}},
            {label = "Gwizdanie 2", type = "anim", data = {lib = "rcmnigel1c", anim = "hailing_whistle_waive_a", car = 0, loop = 56, e = "gwizdanie2"}},
        }
    },
	
	{
        name = 'Postawa',
        label = '👩🏾 Postawa',
        items = {
            {label = "Ochroniarz 1", type = "scenario", data = {anim = "WORLD_HUMAN_GUARD_STAND", car = 0, loop = 0, e = "ochroniarz"}},
            {label = "Ochroniarz 2 [R]", type = "anim", data = {lib = "amb@world_human_stand_guard@male@base", anim = "base", car = 0, loop = 51, e = "ochroniarz2"}},
			{label = "Ochroniarz 3 [R] - zatrzymaj się", type = "anim", data = {lib = "mini@strip_club@idles@bouncer@stop", anim = "stop", car = 0, loop = 56, e = "ochroniarz3"}},
		    {label = "Policjant 1", type = "scenario", data = {anim = "WORLD_HUMAN_COP_IDLES", car = 0, loop = 1, e = "policjant"}},
			{label = "Policjant 2 [R]", type = "anim", data = {lib = "amb@world_human_cop_idles@male@base", anim = "base", car = 0, loop = 51, e = "policjant2"}},
			{label = "Policjant 3 [R]", type = "anim", data = {lib = "amb@world_human_cop_idles@female@base", anim = "base", car = 0, loop = 51, e = "policjant3"}},
			{label = "Opieranie o barierkę 1 - przód", type = "anim", data = {lib = "amb@prop_human_bum_shopping_cart@male@base", anim = "base", car = 0, loop = 1, e = "opieranie"}},
			{label = "Opieranie o barierkę 2 - z tyłu", type = "anim", data = {lib = "anim@amb@clubhouse@bar@bartender@", anim = "base_bartender", car = 0, loop = 1, e = "opieranie2"}},
			{label = "Opieranie o stół 1 - przód", type = "anim", data = {lib = "anim@amb@clubhouse@bar@drink@base", anim = "idle_a", car = 0, loop = 1, e = "opieranie3"}},
            {label = "Opieranie o stół 2 - przód", type = "anim", data = {lib = "anim@amb@board_room@diagram_blueprints@", anim = "base_amy_skater_01", car = 1, loop = 1, e = "opieranie4"}},
            {label = "Opieranie ściana 1 - nogi na ziemi", type = "anim", data = {lib = "amb@world_human_leaning@male@wall@back@hands_together@base", anim = "base", car = 0, loop = 1, e = "opieranie5"}},
            {label = "Opieranie ściana 2 - noga w górze", type = "anim", data = {lib = "amb@world_human_leaning@male@wall@back@foot_up@base", anim = "base", car = 0, loop = 1, e = "opieranie6"}},
            {label = "Opieranie ściana 3 - nogi na krzyż", type = "anim", data = {lib = "amb@world_human_leaning@male@wall@back@legs_crossed@base", anim = "base", car = 0, loop = 1, e = "opieranie7"}},	
            {label = "Siedzienie 1 - na krześle 1", type = "scenario", data = {anim = "PROP_HUMAN_SEAT_CHAIR_MP_PLAYER", e = "siedzenie1"}},	
		    {label = "Siedzienie 2 - na krześle 2", type = "anim", data = {lib = "timetable@ron@ig_5_p3", anim = "ig_5_p3_base", car = 0, loop = 47, e = "siedzenie2"}},	
		    {label = "Siedzienie 3 - na krześle 3", type = "anim", data = {lib = "timetable@reunited@ig_10", anim = "base_amanda", car = 0, loop = 47, e = "siedzenie3"}},	
			{label = "Siedzienie 4 - na krześle 4", type = "anim", data = {lib = "timetable@maid@couch@", anim = "base", car = 0, loop = 47, e = "siedzenie4"}},
            {label = "Siedzienie 5 - na kanapie", type = "anim", data = {lib = "timetable@ron@ig_3_couch", anim = "base", car = 0, loop = 47, e = "siedzenie5"}},			
		    {label = "Siedzienie 6 - na ziemi 1", type = "anim", data = {lib = "anim@heists@fleeca_bank@ig_7_jetski_owner", anim = "owner_idle", car = 0, loop = 47, e = "siedzenie6"}},
			{label = "Siedzienie 7 - na ziemi 2", type = "anim", data = {lib = "amb@world_human_stupor@male@idle_a", anim = "idle_a", car = 0, loop = 0, e = "siedzenie7"}},
			{label = "Siedzienie 8 - na ziemi 3", type = "anim", data = {lib = "timetable@jimmy@mics3_ig_15@", anim = "mics3_15_base_jimmy", car = 0, loop = 47, e = "siedzenie8"}},
            {label = "Siedzienie 9 - smutny", type = "anim", data = {lib = "anim@amb@nightclub@lazlow@lo_alone@", anim = "lowalone_base_laz", car = 0, loop = 47, e = "siedzenie9"}},						
            {label = "Siedzienie 10 - na menela", type = "scenario", data = {anim = "WORLD_HUMAN_PICNIC", car = 0, loop = 47, e = "siedzenie10"}},
			{label = "Rece Z Tylu", type = "anim", data = {lib = "anim@miss@low@fin@vagos@", anim = "idle_ped06", car = 0, loop = 51, e = "raczki"}},
			{label = "Leżenie 1 - na brzuchu", type = "scenario", data = {anim = "WORLD_HUMAN_SUNBATHE", car = 0, loop = 1, e = "lezenie"}},
            {label = "Leżenie 2 - na plecach", type = "scenario", data = {anim = "WORLD_HUMAN_SUNBATHE_BACK", car = 0, loop = 0, e = "lezenie2"}},
            {label = "Leżenie 3 - na kanapie", type = "anim", data = {lib = "timetable@ron@ig_3_couch", anim = "laying", car = 0, loop = 1, e = "lezenie3"}},
            {label = "Leżenie 4 - lewy bok", type = "anim", data = {lib = "amb@world_human_bum_slumped@male@laying_on_left_side@base", anim = "base", car = 0, loop = 1, e = "lezenie4"}},
            {label = "Leżenie 5 - prawy bok", type = "anim", data = {lib = "amb@world_human_bum_slumped@male@laying_on_right_side@base", anim = "base", car = 0, loop = 1, e = "lezenie5"}},
            {label = "Wypadek 1 - lewy bok", type = "anim", data = {lib = "missheist_jewel", anim = "gassed_npc_customer4", car = 0, loop = 1, e = "wypadek"}},
            {label = "Wypadek 2 - prawy bok", type = "anim", data = {lib = "missheist_jewel", anim = "gassed_npc_guard", car = 0, loop = 1, e = "wypadek2"}},
            {label = "Niecierpliwosc", type = "anim", data = {lib = "oddjobs@taxi@", anim = "base", car = 0, loop = 1, e = "niecierpliwosc"}},
            {label = "Rozmowa 1 - założone ręce", type = "anim", data = {lib = "amb@world_human_hang_out_street@male_c@base", anim = "base", car = 0, loop = 1, e = "rozmowa"}},
            {label = "Rozmowa 2 - założone ręce", type = "anim", data = {lib = "amb@world_human_hang_out_street@female_arms_crossed@idle_a", anim = "idle_a", car = 0, loop = 0, e = "rozmowa2"}},
            {label = "Rozmowa 3 - trzymana lewa ręka", type = "anim", data = {lib = "amb@world_human_hang_out_street@female_hold_arm@idle_a", anim = "idle_b", car = 0, loop = 0, e = "rozmowa3"}},
			{label = "Założone ręce 1 [R][P]", type = "anim", data = {lib = "mini@hookers_sp", anim = "idle_reject_loop_c", car = 1, loop = 57, e = "rece"}},
			{label = "Założone ręce 2 [R][P]", type = "anim", data = {lib = "anim@amb@nightclub@peds@", anim = "rcmme_amanda1_stand_loop_cop", car = 1, loop = 51, e = "rece2"}},
            {label = "Założone ręce 3 [R][P]", type = "anim", data = {lib = "amb@world_human_hang_out_street@female_arms_crossed@base", anim = "base", car = 1, loop =51, e = "rece3"}},
            {label = "Ręce na biodrach [R]", type = "anim", data = {lib = "anim@arena@celeb@podium@no_prop@", anim = "regal_c_3rd", car = 0, loop = 50, e = "rece4"}},
            {label = "Ręka na biodrze [R]", type = "anim", data = {lib = "anim@arena@celeb@podium@no_prop@", anim = "shrug_off_a_1st", car = 0, loop = 50, e = "rece5"}},
            {label = "Obejmowanie 1 - lewo [R]", type = "anim", data = {lib = "anim@arena@celeb@flat@paired@no_props@", anim = "this_guy_b_player_a", car = 0, loop = 50, e = "obejmowanie"}},
            {label = "Obejmowanie 2 - prawo [R]", type = "anim", data = {lib = "anim@arena@celeb@flat@paired@no_props@", anim = "this_guy_b_player_b", car = 0, loop = 50, e = "obejmowanie2"}},
            {label = "Poddanie się 1 - na kolanach", type = "anim", data = {lib = "random@arrests@busted", anim = "idle_a", car = 0, loop = 1, e = "poddanie"}},
            {label = "Poddanie się 2 [R]", type = "anim", data = {lib = "anim@move_hostages@male", anim = "male_idle", car = 0, loop = 51, e = "poddanie2"}},
            {label = "Poddanie się 3 [R]", type = "anim", data = {lib = "anim@move_hostages@female", anim = "female_idle", car = 0, loop = 51, e = "poddanie3"}},
			{label = "Przykucywanie", type = "anim", data = {lib = "random@arrests", anim = "kneeling_arrest_idle", car = 0, loop = 47, e = "przykuc"}},
			{label = "Medytacja 1", type = "anim", data = {lib = "rcmcollect_paperleadinout@", anim = "meditiate_idle", car = 0, loop = 47, e = "medytacja1"}},
			{label = "Medytacja 2", type = "anim", data = {lib = "rcmepsilonism3", anim = "ep_3_rcm_marnie_meditating", car = 0, loop = 47, e = "medytacja2"}},
			{label = "Medytacja 3", type = "anim", data = {lib = "rcmepsilonism3", anim = "base_loop", car = 0, loop = 47, e = "medytacja3"}},
			{label = "Czołganie", type = "anim", data = {lib = "move_injured_ground", anim = "front_loop", car = 0, loop = 47, e = "czolganie"}},
        }
    },
	
    {
        name = 'Czynności',
        label = '🤺 Czynności',
        items = {
        	{label = "Telefon 1 - zdjęcie", type = "scenario", data = {anim = "world_human_tourist_mobile", car = 0, loop = 0, e = "telefon"}},
            {label = "Telefon 2 - nagrywanie", type = "scenario", data = {anim = "WORLD_HUMAN_MOBILE_FILM_SHOCKING", car = 0, loop = 0, e = "telefon2"}},
         	{label = "Telefon 3 - dzwonienie [R]", type = "anim",
             prop = function()
                local telefon2 = CreateObject(GetHashKey('prop_amb_phone'), 1.0, 1.0, 1.0, 1, 1, 0)
                AttachEntityToEntity(telefon2, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1, 1, 0, 0, 2, 1)
                table.insert(Config.Props, telefon2)
      
             end
             
            ,data = {lib = "cellphone@", anim = "cellphone_text_to_call", car = 0, loop = 58, e = "telefon3"}},
         	{label = "Telefon 4 - pisanie [R]", type = "anim", 
            prop = function() 
                local telefon = CreateObject(GetHashKey('prop_amb_phone'), GetEntityCoords(PlayerPedId()), true)-- creates object
                AttachEntityToEntity(telefon, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 28422), -0.01, -0.005, 0.0, -10.0, 8.0, 0.0, 1, 0, 0, 0, 0, 1)
               
                table.insert(Config.Props, telefon)
            end,data = {lib = "amb@world_human_stand_mobile@male@text@base", anim = "base", car = 0, loop = 51, e = "telefon4"}},
            {label = "Fotka - wyimaginowany aparat [P]", type = "anim", data = {lib = "anim@mp_player_intincarphotographylow@ds@", anim = "idle_a", car = 1, loop = 1, e = "fotka"}},
            {label = "Dokument z portfela",  type = "anim",prop = function() 
                local portfel = CreateObject(GetHashKey('prop_ld_wallet_01'), GetEntityCoords(PlayerPedId()), true)-- creates object
                AttachEntityToEntity(portfel, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 0x49D9), 0.17, 0.0, 0.019, -120.0, 0.0, 0.0, 1, 0, 0, 0, 0, 1)
                table.insert(Config.Props, portfel)
                local dowod = CreateObject(GetHashKey('prop_michael_sec_id'), GetEntityCoords(PlayerPedId()), true)-- creates object
                AttachEntityToEntity(dowod, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 0xDEAD), 0.150, 0.045, -0.015, 0.0, 0.0, 180.0, 1, 0, 0, 0, 0, 1)
                table.insert(Config.Props, dowod)                
            end, data = {lib = "random@atmrobberygen", anim = "a_atm_mugging", car = 0, loop = 0, e = "dokument"}},
			{label = "Aparat [R]", type = "anim", prop = function() 
                local aparat = CreateObject(GetHashKey('prop_pap_camera_01'), GetEntityCoords(PlayerPedId()), true)-- creates object
                AttachEntityToEntity(aparat, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 0xE5F2), 0.1, -0.05, 0.0, -10.0, 50.0, 5.0, 1, 0, 0, 0, 0, 1)
                table.insert(Config.Props, aparat)
            end, data = {lib = "amb@world_human_paparazzi@male@idle_a", anim = "idle_c", car = 1, loop = 51, e = "aparat"}},
         	{label = "Kawa [R]", type = "anim", prop = function() 
                local kawa = CreateObject(GetHashKey('p_amb_coffeecup_01'), 1.0, 1.0, 1.0, 1, 1, 0)
                AttachEntityToEntity(kawa, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.14, 0.015, -0.03, -80.0, 0.0, -20.0, 1, 1, 0, 1, 1, 1)
                table.insert(Config.Props, kawa)
            end, data = {lib = "amb@world_human_drinking@coffee@male@idle_a", anim = "idle_c", car = 0, loop = 51, e = "kawa"}},
            {label = "Walizka 1 - skórzana [R]",prop = function() 
                local walizka = CreateObject(GetHashKey('prop_ld_case_01'), 1.0, 1.0, 1.0, 1, 1, 0)
                AttachEntityToEntity(walizka, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.13, 0.0, -0.02, -90.0, 0.0, 90.0, 1, 1, 0, 1, 1, 1)
                table.insert(Config.Props, walizka)
            end,  type = "anim", data = {lib = "rcmepsilonism8", anim = "bag_handler_idle_a", car = 0, loop = 57, e = "walizka"}}, 
            {label = "Walizka 2 - metalowa [R]",prop = function() 
                local walizka2 = CreateObject(GetHashKey('hei_p_attache_case_shut'), 1.0, 1.0, 1.0, 1, 1, 0)
                AttachEntityToEntity(walizka2, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.13, 0.0, 0.0, 0.0, 0.0, -90.0, 1, 1, 0, 1, 1, 1)
                table.insert(Config.Props, walizka2)
            end, type = "anim", data = {lib = "rcmepsilonism8", anim = "bag_handler_idle_a", car = 0, loop = 57, e = "walizka2"}}, 
            {label = "Walizka 3 - turystyczna[R]",prop = function() 
                local walizka3 = CreateObject(GetHashKey('prop_ld_suitcase_01'), 1.0, 1.0, 1.0, 1, 1, 0)
                AttachEntityToEntity(walizka3, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.36, 0.0, -0.02, -90.0, 0.0, 90.0, 1, 1, 0, 1, 1, 1)
                table.insert(Config.Props, walizka3)
            end, type = "anim", data = {lib = "rcmepsilonism8", anim = "bag_handler_idle_a", car = 0, loop = 57, e = "walizka3"}}, 
            {label = "Walizka 4 - na kółkach [R]", prop = function() 
                local walizka4 = CreateObject(GetHashKey('prop_suitcase_03'), 1.0, 1.0, 1.0, 1, 1, 0)
                AttachEntityToEntity(walizka4, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.36, -0.45, -0.05, -50.0, -60.0, 15.0, 1, 1, 0, 1, 1, 1)
                table.insert(Config.Props, walizka4)
            end, type = "anim", data = {lib = "anim@heists@narcotics@trash", anim = "walk", car = 0, loop = 58, e = "walizka4"}},
            {label = "Tłumaczenie [R]", type = "anim", data = {lib = "misscarsteal4@actor", anim = "actor_berating_assistant", car = 1, loop = 56, e = "tlumaczenie"}},
            {label = "Zerkanie na zegarek [R]", type = "anim", data = {lib = "oddjobs@taxi@", anim = "idle_a", car = 0, loop = 56, e = "zegarek"}},
            {label = "Czyszczenie 1 - mycie ścierką", type = "scenario", data = {anim = "world_human_maid_clean", car = 0, loop = 0, e = "mycie"}},
			{label = "Czyszczenie 2 - mycie maski auta", type = "anim", data = {lib = "switch@franklin@cleaning_car", anim = "001946_01_gc_fras_v2_ig_5_base", car = 0, loop = 1, e = "mycie2"}},
			{label = "Branie prysznica 1", type = "anim", data = {lib = "mp_safehouseshower@female@", anim = "shower_idle_a", car = 0, loop = 1, e = "prysznic"}},
			{label = "Branie prysznica 2", type = "anim", data = {lib = "mp_safehouseshower@male@", anim = "male_shower_idle_a", car = 0, loop = 1, e = "prysznic2"}},
			{label = "Branie prysznica 3", type = "anim", data = {lib = "mp_safehouseshower@male@", anim = "male_shower_idle_d", car = 0, loop = 1, e = "prysznic3"}},
			{label = "Sięganie do schowka w aucie [P]", type = "anim", data = {lib = "rcmme_amanda1", anim = "drive_mic", car = 2, loop = 56, e = "schowek"}},
		    {label = "Włamywanie do sejfu", type = "anim", data = {lib = "mini@safe_cracking", anim = "dial_turn_anti_normal", car = 0, loop = 0, e = "sejf"}},
			{label = "Pakowanie do torby", type = "anim", data = {lib = "anim@heists@ornate_bank@grab_cash", anim = "grab", car = 0, loop = 1, e = "torba"}},
            {label = "Celowanie 1", type = "anim", data = {lib = "rcmjosh4", anim = "josh_leadout_cop2", car = 0, loop = 56, e = "celowanie1"}},
            {label = "Celowanie 2", type = "anim", data = {lib = "random@countryside_gang_fight", anim = "biker_02_stickup_loop", car = 0, loop = 56, e = "celowanie2"}},
			{label = "Celowanie 3", type = "anim", data = {lib = "random@atmrobberygen", anim = "b_atm_mugging", car = 0, loop = 56, e = "celowanie3"}},
            {label = "Kabura", type = "anim", data = {lib = "reaction@intimidation@cop@unarmed", anim = "intro", car = 0, loop = 50, e = "kabura"}},
            {label = "Oddawaj pieniądze", type = "anim", data = {lib = "mini@prostitutespimp_demands_money", anim = "pimp_demands_money_pimp", car = 0, loop = 0, e = "oddawaj"}},
            {label = "Samobójstwo", type = "anim", data = {lib = "mp_suicide", anim = "pistol", car = 0, loop = 2, e = "samobojstwo"}},
			{label = "Spider Man", type = "anim", data = {lib = "missexile3", anim = "ex03_train_roof_idle", car = 0, loop = 12, e = "spiderman"}},
			{label = "Samolot", type = "anim", data = {lib = "missfbi1", anim = "ledge_loop", car = 0, loop = 51, e = "samolot"}},
			{label = "Kontrola umysłu 1", type = "anim", data = {lib = "rcmbarry", anim = "mind_control_b_loop", car = 0, loop = 51, e = "kontrolaumyslu1"}},
			{label = "Kontrola umysłu 2", type = "anim", data = {lib = "rcmbarry", anim = "bar_1_attack_idle_aln", car = 0, loop = 51, e = "kontrolaumyslu2"}},
        }
    },
	
    {
        name = 'Chamskie',
        label = '🖕 Chamskie',
        items = {
			{label = "Mów do ręki [R]", type = "anim", data = {lib = "mini@prostitutestalk", anim = "street_argue_f_a", car = 0, loop = 56}},           
		    {label = "Środkowy palec 1 [R]", type = "anim", data = {lib = "anim@arena@celeb@podium@no_prop@", anim = "flip_off_a_1st", car = 0, loop = 56, e = "palec"}},
            {label = "Środkowy palec 2 [R]", type = "anim", data = {lib = "anim@arena@celeb@podium@no_prop@", anim = "flip_off_b_1st", car = 0, loop = 56, e = "palec2"}},
            {label = "Środkowy palec 3 [R]", type = "anim", data = {lib = "anim@mp_player_intselfiethe_bird", anim = "idle_a", car = 0, loop = 56, e = "palec3"}},
            {label = "Środkowy palec 4 [R]", type = "anim", data = {lib = "anim@mp_player_intupperfinger", anim = "idle_a_fp", car = 0, loop = 56, e = "palec4"}},
			{label = "Pokazywanie środkowych palców [R]", type = "anim", data = {lib = "mp_player_int_upperfinger", anim = "mp_player_int_finger_01_enter", car = 0, loop = 58, e = "palec5"}},
			{label = "Sarkastyczne klaskanie 1 [R]", type = "anim", data = {lib = "anim@mp_player_intcelebrationfemale@slow_clap", anim = "slow_clap", car = 0, loop = 56, e = "klaskanie"}},
            {label = "Sarkastyczne klaskanie 2 [R]", type = "anim", data = {lib = "anim@mp_player_intcelebrationmale@slow_clap", anim = "slow_clap", car = 0, loop = 56, e = "klaskanie2"}},
            {label = "Sarkastyczne klaskanie 3 [R]", type = "anim", data = {lib = "anim@mp_player_intupperslow_clap", anim = "idle_a", car = 0, loop = 57, e = "klaskanie3"}},
			{label = "Sarkastyczne klaskanie 4", type = "anim", data = {lib = "anim@arena@celeb@podium@no_prop@", anim = "regal_b_3rd", car = 0, loop = 0, e = "klaskanie4"}},  
			{label = "Dokowanie", type = "anim", data = {lib = "anim@mp_player_intcelebrationfemale@air_shagging", anim = "air_shagging", car = 0, loop = 0, e = "dokowanie"}},
			{label = "Gest walenia [R][P]", type = "anim", data = {lib = "anim@mp_player_intupperdock", anim = "idle_a", car = 1, loop = 57, e = "walenie"}},
			{label = "Walenie konia 1 [P]", type = "anim", data = {lib = "anim@mp_player_intincarwanklow@ps@", anim = "idle_a", car = 1, loop = 1, e = "walenie2"}},
            {label = "Walenie konia 2 - na kogoś", type = "anim", data = {lib = "anim@mp_player_intcelebrationmale@wank", anim = "wank", car = 0, loop = 0, e = "walenie3"}},           
		    {label = "Drapanie sie po kroczu [R]", type = "anim", data = {lib = "mp_player_int_uppergrab_crotch", anim = "mp_player_int_grab_crotch", car = 0, loop = 57, e = "drapanie"}},
            {label = "Drapanie się po dupie", type = "anim", data = {lib = "anim@mp_corona_idles@male_a@idle_a", anim = "idle_e", car = 0, loop = 0, e = "drapanie2"}},
            {label = "Dłubanie w nosie - strzał gilem [R]", type = "anim", data = {lib = "anim@mp_player_intuppernose_pick", anim = "exit", car = 0, loop = 56, e = "dlubanie"}},
            {label = "Dłubanie w nosie 2 - oscentacyjne", type = "anim", data = {lib = "anim@mp_player_intcelebrationfemale@nose_pick", anim = "nose_pick", car = 0, loop = 0, e = "dlubanie2"}},
            {label = "Ten z tyłu śmierdzi", type = "anim", data = {lib = "anim@arena@celeb@flat@solo@no_props@", anim = "taunt_c_player_b", car = 0, loop = 0, e = "smierdzi"}},
		    {label = "No dawaj! [R]", type = "anim", data = {lib = "gestures@f@standing@casual", anim = "gesture_bring_it_on", car = 0, loop = 56, e = "dawaj"}},
			{label = "Gotowość na bójkę [R][P]", type = "anim", data = {lib = "anim@mp_player_intupperknuckle_crunch", anim = "idle_a", car = 1, loop = 56, e = "bojka"}},
            {label = "Gotowość na bójkę 2 [R][P]", type = "anim", data = {lib = "anim@mp_player_intcelebrationmale@knuckle_crunch", anim = "knuckle_crunch", car = 1, loop = 56, e = "bojka2"}},           
		    {label = "Spoliczkowanie [R]", type = "anim", data = {lib = "anim@arena@celeb@podium@no_prop@", anim = "air_slap_a_1st", car = 0, loop = 56, e = "policzek"}},
		    {label = "klaun 1", type = "anim", data = {lib = "rcm_barry2", anim = "clown_idle_0", car = 0, loop = 56, e = "klaun1"}},
	        {label = "klaun 2", type = "anim", data = {lib = "rcm_barry2", anim = "clown_idle_1", car = 0, loop = 56, e = "klaun2"}},
	        {label = "klaun 3", type = "anim", data = {lib = "rcm_barry2", anim = "clown_idle_2", car = 0, loop = 56, e = "klaun3"}},
	        {label = "klaun 4", type = "anim", data = {lib = "rcm_barry2", anim = "clown_idle_3", car = 0, loop = 56, e = "klaun4"}},
	        {label = "klaun 5", type = "anim", data = {lib = "rcm_barry2", anim = "clown_idle_5", car = 0, loop = 56, e = "klaun5"}},
	        {label = "klaun 6", type = "anim", data = {lib = "rcm_barry2", anim = "clown_idle_6", car = 0, loop = 56, e = "klaun6"}},
        }
    },
	
    {
        name = 'Impreza',
        label = '🕺 Impreza',
        items = {
            {label = "DJ", type = "anim", data = {lib = "mini@strip_club@idles@dj@idle_02", anim = "idle_02", car = 0, loop = 1, e = "dj"}},
			{label = "Oglądanie występu", type = "anim", data = {lib = "amb@world_human_strip_watch_stand@male_a@base", anim = "base", car = 0, loop = 1, e = "ogladanie"}},
            {label = "Gest 1: Ręce w górze", type = "anim", data = {lib = "mp_player_int_uppergang_sign_a", anim = "mp_player_int_gang_sign_a", car = 1, loop = 57, e = "gest"}},
            {label = "Gest 2: Znak V", type = "anim", data = {lib = "mp_player_int_upperv_sign", anim = "mp_player_int_v_sign", car = 1, loop = 57, e = "gest2"}},     
			{label = "Ukłon", type = "anim", data = {lib = "anim@arena@celeb@podium@no_prop@", anim = "regal_c_1st", car = 0, loop = 0, e = "uklon"}},
			{label = "Bycie pijanym", type = "anim", data = {lib = "amb@world_human_bum_standing@drunk@idle_a", anim = "idle_a", car = 0, loop = 1, e = "pijany"}},
		    {label = "Udawanie gry na gitarze", type = "anim", data = {lib = "anim@mp_player_intcelebrationmale@air_guitar", anim = "air_guitar", car = 0, loop = 0, e = "gitara"}},
			{label = "Rock'n roll 1 [R]", type = "anim", data = {lib = "mp_player_int_upperrock", anim = "mp_player_int_rock_enter", car = 0, loop = 56, e = "rock"}},
            {label = "Rock'n roll 2 [R]", type = "anim", data = {lib = "mp_player_introck", anim = "mp_player_int_rock", car = 0, loop = 56, e = "rock2"}},           
		    {label = "Rzucanie hajsem", type = "anim", data = {lib = "anim@arena@celeb@flat@solo@props@", anim = "make_it_rain_b_player_b", car = 0, loop = 0, e = "hajs"}},
            {label = "Śmiech", type = "anim", data = {lib = "anim@arena@celeb@flat@solo@no_props@", anim = "taunt_e_player_b", car = 0, loop = 0, e = "smiech"}},
			{label = "Pozowanie - manekin", type = "scenario", data = {anim = "WORLD_HUMAN_HUMAN_STATUE", car = 0, loop = 1, e = "manekin"}},
            {label = "Wymiotowanie w aucie [P]", type = "anim", data = {lib = "oddjobs@taxi@tie", anim = "vomit_outside", car = 2, loop = 0, e = "wymioty"}},
        }
    },

    {
        name = 'Tańce',
        label = '🕺 Tańce',
        items = {
			{label = "Taniec A - baza", type = "anim", data = {lib = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", anim = "high_center", car = 0, loop = 1}},
			{label = "Taniec A - ręce w dół", type = "anim", data = {lib = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", anim = "high_center_down", car = 0, loop = 1}},
			{label = "Taniec A - ręce w górę", type = "anim", data = {lib = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", anim = "high_center_up", car = 0, loop = 1}},
			{label = "Taniec A - ręce w lewo", type = "anim", data = {lib = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", anim = "high_left", car = 0, loop = 1}},
			{label = "Taniec A - ręce w prawo", type = "anim", data = {lib = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", anim = "high_right", car = 0, loop = 1}},			
			{label = "Taniec A - lewa w górę", type = "anim", data = {lib = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", anim = "high_left_up", car = 0, loop = 1}},
			{label = "Taniec A - prawa w górę", type = "anim", data = {lib = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", anim = "high_right_up", car = 0, loop = 1}},
			{label = "Taniec B - baza", type = "anim", data = {lib = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", anim = "low_center", car = 0, loop = 1}},
			{label = "Taniec B - ręce w górę lewo", type = "anim", data = {lib = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", anim = "low_left_up", car = 0, loop = 1}},
			{label = "Taniec B - ręce w górę w prawo", type = "anim", data = {lib = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", anim = "low_right_up", car = 0, loop = 1}},
			{label = "Taniec B - ręce w lewo", type = "anim", data = {lib = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", anim = "low_left", car = 0, loop = 1}},
			{label = "Taniec B - ręce w prawo", type = "anim", data = {lib = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", anim = "low_right", car = 0, loop = 1}},
			{label = "Taniec C - baza", type = "anim", data = {lib = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", anim = "med_center", car = 0, loop = 1}},
			{label = "Taniec C - ręce w górę w lewo", type = "anim", data = {lib = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", anim = "med_left_up", car = 0, loop = 1}},
			{label = "Taniec C - ręce w górę w prawo", type = "anim", data = {lib = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", anim = "med_right_up", car = 0, loop = 1}},
			{label = "Taniec C - ręce w lewo", type = "anim", data = {lib = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", anim = "med_left", car = 0, loop = 1}},
			{label = "Taniec C - ręce w prawo", type = "anim", data = {lib = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", anim = "med_right", car = 0, loop = 1}},
			{label = "Taniec D - baza", type = "anim", data = {lib = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", anim = "high_center_down", car = 0, loop = 1}},
			{label = "Taniec D - ręce w dół klaskanie", type = "anim", data = {lib = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", anim = "high_center_down", car = 0, loop = 1}},
			{label = "Taniec D - ręce w górę", type = "anim", data = {lib = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", anim = "high_center_up", car = 0, loop = 1}},
			{label = "Taniec D - ręce w lewo", type = "anim", data = {lib = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", anim = "high_left_down", car = 0, loop = 1}},
			{label = "Taniec D - ręce w prawo", type = "anim", data = {lib = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", anim = "high_right_down", car = 0, loop = 1}},
			{label = "Taniec D - lewa w górę", type = "anim", data = {lib = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", anim = "high_left_up", car = 0, loop = 1}},
			{label = "Taniec D - prawa w górę", type = "anim", data = {lib = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", anim = "high_right_up", car = 0, loop = 1}},
			{label = "Taniec E - baza", type = "anim", data = {lib = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", anim = "low_center", car = 0, loop = 1}},
			{label = "Taniec E - baza smutas", type = "anim", data = {lib = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", anim = "low_center_down", car = 0, loop = 1}},
			{label = "Taniec E - lewy palec", type = "anim", data = {lib = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", anim = "low_left", car = 0, loop = 1}},
			{label = "Taniec E - prawy palec", type = "anim", data = {lib = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", anim = "low_right", car = 0, loop = 1}},
			{label = "Taniec F - baza", type = "anim", data = {lib = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", anim = "med_center", car = 0, loop = 1}},
			{label = "Taniec F - baza pochylona", type = "anim", data = {lib = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", anim = "med_center_down", car = 0, loop = 1}},
			{label = "Taniec F - ręce w górę w lewo", type = "anim", data = {lib = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", anim = "med_left_up", car = 0, loop = 1}},
			{label = "Taniec F - ręce w górę w prawo", type = "anim", data = {lib = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", anim = "med_right_up", car = 0, loop = 1}},
			{label = "Taniec F - ręce w dół w lewo", type = "anim", data = {lib = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", anim = "med_left_down", car = 0, loop = 1}},
			{label = "Taniec F - ręce w dół w prawo", type = "anim", data = {lib = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", anim = "med_right_down", car = 0, loop = 1}},
            {label = "Taniec 1 - macarena", type = "anim", data = {lib = "misschinese2_crystalmazemcs1_cs", anim = "dance_loop_tao", car = 0, loop = 1, e = "taniec"}},           
            {label = "Taniec 2 - wczuwanie się", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v1_female^1", car = 0, loop = 1, e = "taniec2"}},
            {label = "Taniec 3 - delikatny", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v1_female^3", car = 0, loop = 1, e = "taniec3"}},
            {label = "Taniec 4 - klubowy", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v1_female^6", car = 0, loop = 1, e = "taniec4"}},
            {label = "Taniec 5 - pływająca ręka", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_09_v1_female^1", car = 0, loop = 1, e = "taniec5"}},
            {label = "Taniec 6 - słuchawki", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_09_v1_female^1", car = 0, loop = 1, e = "taniec6"}},
            {label = "Taniec 7 - radosny", type = "anim", data = {lib = "anim@amb@nightclub@lazlow@hi_podium@", anim = "danceidle_hi_11_turnaround_laz", car = 0, loop = 1, e = "taniec7"}},
            {label = "Taniec 8 - klepanie", type = "anim", data = {lib = "anim@amb@nightclub@lazlow@hi_podium@", anim = "danceidle_hi_17_smackthat_laz", car = 0, loop = 1, e = "taniec8"}},
            {label = "Taniec 9 - chodźcie tu", type = "anim", data = {lib = "anim@amb@nightclub@lazlow@hi_podium@", anim = "danceidle_mi_13_enticing_laz", car = 0, loop = 1, e = "taniec9"}},
            {label = "Taniec 10 - stepowanie", type = "anim", data = {lib = "special_ped@mountain_dancer@monologue_3@monologue_3a", anim = "mnt_dnc_buttwag", car = 0, loop = 1, e = "taniec10"}},
			{label = "Taniec Konia", type = "anim", 
            prop = function()
                local kon = CreateObject(GetHashKey('ba_prop_battle_hobby_horse'), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
                AttachEntityToEntity(kon, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1, 1, 0, 1, 1, 1)
                table.insert(Config.Props, kon)
            end,
            data = {lib = "anim@amb@nightclub@lazlow@hi_dancefloor@", anim = "dancecrowd_li_11_hu_shimmy_laz", car = 0, loop = 1, e = "taniec11"}},
        }
    },

    {
        name = 'Sport',
        label = '🤸‍♂️ Sport',
        items = {
            {label = "Jogging [R]", type = "anim", data = {lib = "move_m@jogger", anim = "run", car = 0, loop = 33, e = "jogging"}},
            {label = "Trucht [R]", type = "anim", data = {lib = "move_m@jog@", anim = "run", car = 0, loop = 33, e = "trucht"}},
            {label = "Bieganie w miejscu", type = "anim", data = {lib = "amb@world_human_jog_standing@male@idle_a", anim = "idle_a", car = 0, loop = 33, e = "trucht"}},
            {label = "Powerwalk [R]", type = "anim", data = {lib = "amb@world_human_power_walker@female@base", anim = "base", car = 0, loop = 33, e = "powerwalk"}},
            {label = "Napinanie mięśni", type = "anim", data = {lib = "amb@world_human_muscle_flex@arms_at_side@base", anim = "base", car = 0, loop = 1, e = "napinanie"}},
            {label = "Pompki", type = "anim", data = {lib = "amb@world_human_push_ups@male@base", anim = "base", car = 0, loop = 1, e = "pompki"}},
            {label = "Brzuszki", type = "animangle",angle=180, data = {lib = "amb@world_human_sit_ups@male@base", anim = "base", car = 0, loop = 1, e = "brzuszki"}},
            {label = "Pajacyki", type = "animangle",angle=180, data = {lib = "timetable@reunited@ig_2", anim = "jimmy_getknocked", car = 0, loop = 1, e = "pajacyki"}},
            {label = "Salto w tył", type = "anim", data = {lib = "anim@arena@celeb@flat@solo@no_props@", anim = "flip_a_player_a", car = 0, loop = 0, e = "salto"}},
            {label = "Capoeira", type = "anim", data = {lib = "anim@arena@celeb@flat@solo@no_props@", anim = "cap_a_player_a", car = 0, loop = 0, e = "capoeira"}},
			{label = "Podciąganie", type = "anim", data = {lib = "Scenario", anim = "PROP_HUMAN_MUSCLE_CHIN_UPS", car = 0, loop = 0, e = "podciaganie"}},
			{label = "Rozciąganie 1", type = "anim", data = {lib = "mini@triathlon", anim = "idle_d", car = 0, loop = 0, e = "rozciaganie1"}},
			{label = "Rozciąganie 2", type = "anim", data = {lib = "mini@triathlon", anim = "idle_e", car = 0, loop = 0, e = "rozciaganie2"}},
			{label = "Rozciąganie 3", type = "anim", data = {lib = "rcmfanatic1maryann_stretchidle_b", anim = "idle_e", car = 0, loop = 0, e = "rozciaganie3"}},
			{label = "Rozciąganie 4", type = "anim", data = {lib = "mini@triathlon", anim = "idle_f", car = 0, loop = 0, e = "rozciaganie4"}},
            {label = "Yoga 1 - przygotowanie", type = "anim", data = {lib = "amb@world_human_yoga@male@base", anim = "base", car = 0, loop = 1, e = "yoga"}},
            {label = "Yoga 2 - rozciąganie się", type = "anim", data = {lib = "amb@world_human_yoga@female@base", anim = "base_b", car = 0, loop = 1, e = "yoga2"}},
            {label = "Yoga 3 - stanie na rękach", type = "anim", data = {lib = "amb@world_human_yoga@female@base", anim = "base_c", car = 0, loop = 1, e = "yoga3"}},
            {label = "Napinanie mięśni", type = "anim", data = {lib = "Scenario", anim = "WORLD_HUMAN_MUSCLE_FLEX", car = 0, loop = 0, e = "napinaniemięśni"}},
            {label = "Baseball 1 - kij", type = "anim", data = {lib = "anim@arena@celeb@flat@solo@no_props@", anim = "slugger_a_player_a", car = 0, loop = 0, e = "baseball"}},
            {label = "Baseball 2 - rzut piłką", type = "anim", data = {lib = "anim@arena@celeb@flat@paired@no_props@", anim = "baseball_a_player_a", car = 0, loop = 0, e = "baseball2"}},
            {label = "Baseball 3 - rzut piłką", type = "anim", data = {lib = "anim@arena@celeb@flat@paired@no_props@", anim = "baseball_a_player_b", car = 0, loop = 0, e = "baseball3"}},
        }
    },

    {
        name = 'Romanse',
        label = '❤️ Romanse',
        items = {
            {label = "Przytul 1", type = "anim", data = {lib = "mp_ped_interaction", anim = "kisses_guy_a", car = 0, loop = 0, e = "przytul"}},
            {label = "Przytul 2", type = "anim", data = {lib = "mp_ped_interaction", anim = "kisses_guy_b", car = 0, loop = 0, e = "przytul2"}},  
            {label = "Przytul 3", type = "anim", data = {lib = "mp_ped_interaction", anim = "hugs_guy_a", car = 0, loop = 0, e = "przytul3"}},  			
            {label = "Całus 1 [R][P]", type = "anim", data = {lib = "anim@mp_player_intselfieblow_kiss", anim = "exit", car = 1, loop = 56, e = "calus"}},
            {label = "Całus 2", type = "anim", data = {lib = "mini@hookers_sp", anim = "idle_a", car = 0, loop = 0, e = "calus2"}},
            {label = "Całus 3 [R]", type = "anim", data = {lib = "anim@mp_player_intcelebrationfemale@blow_kiss", anim = "blow_kiss", car = 0, loop = 56, e = "calus3"}},
            {label = "Uroczo [R][P]", type = "anim", data = {lib = "mini@hookers_spcokehead", anim = "idle_reject_loop_a", car = 1, loop = 58, e = "uroczo"}},
			{label = "Zawstydzenie", type = "anim", data = {lib = "anim@arena@celeb@podium@no_prop@", anim = "regal_a_3rd", car = 0, loop = 0}},     
            {label = "Taniec erotyczny 3", type = "anim", data = {lib = "mini@strip_club@private_dance@part3", anim = "priv_dance_p3", car = 0, loop = 1, e = "erotyczny3"}},
            {label = "Twerk", type = "anim", data = {lib = "switch@trevor@mocks_lapdance", anim = "001443_01_trvs_28_idle_stripper", car = 0, loop = 1, e = "erotyczny3"}},			
		    {label = "Uwodzenie", type = "anim", data = {lib = "mini@strip_club@idles@stripper", anim = "stripper_idle_02", car = 0, loop = 1, e = "uwodzenie"}},
            {label = "Eksponowanie wdzięków - przód", type = "anim", data = {lib = "mini@hookers_sp", anim = "ilde_b", car = 0, loop = 1, e = "wdzieki"}},
            {label = "Eksponowanie wdzięków - tył", type = "anim", data = {lib = "mini@hookers_sp", anim = "ilde_c", car = 0, loop = 1, e = "wdzieki2"}},
            {label = "Zmysłowy taniec", type = "anim", data = {lib = "anim@amb@nightclub@lazlow@hi_podium@", anim = "danceidle_li_15_sexygrind_laz", car = 0, loop = 1, e = "zmyslowy"}},
            {label = "Taniec erotyczny 1", type = "anim", data = {lib = "mini@strip_club@lap_dance@ld_girl_a_song_a_p1", anim = "ld_girl_a_song_a_p1_f", car = 0, loop = 1, e = "erotyczny"}},
            {label = "Taniec erotyczny 2", type = "anim", data = {lib = "mini@strip_club@private_dance@part2", anim = "priv_dance_p2", car = 0, loop = 1, e = "erotyczny2"}},
            {label = "Taniec erotyczny 3", type = "anim", data = {lib = "mini@strip_club@private_dance@part3", anim = "priv_dance_p3", car = 0, loop = 1, e = "erotyczny3"}},
        }
    },

    {
        name = 'Praca',
        label = '🧑 Praca',
        items = {
            {label = "Karton [R]", prop = function()
                local karton = CreateObject(GetHashKey('v_serv_abox_04'), 1.0, 1.0, 1.0, 1, 1, 0)
                AttachEntityToEntity(karton, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 28422), 0.0, -0.08, -0.17, 0, 0, 90.0, 1, 1, 0, 1, 1, 1)
                table.insert(Config.Props, karton)
            end, type = "anim", data = {lib = "anim@heists@box_carry@", anim = "idle", car = 0, loop = 57, e = "karton"}},
			{label = "Wiertarka [R]", prop = function()
                local wiertarka = CreateObject(GetHashKey('prop_tool_drill'), 1.0, 1.0, 1.0, 1, 1, 0)
                AttachEntityToEntity(wiertarka, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.1, 0.04, -0.03, -90.0, 180.0, 0.0, 1, 1, 0, 1, 1, 1)
                table.insert(Config.Props, wiertarka)
            end, type = "anim", data = {lib = "anim@heists@fleeca_bank@drilling", anim = "drill_straight_start", car = 0, loop = 57, e = "wiertarka"}},
            {label = "Skrzynka 1 - z narzędziami [R]", prop = function()
                local toolbox = CreateObject(GetHashKey('prop_tool_box_04'), 1.0, 1.0, 1.0, 1, 1, 0)
                AttachEntityToEntity(toolbox, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.43, 0.0, -0.02, -90.0, 0.0, 90.0, 1, 1, 0, 1, 1, 1)
                table.insert(Config.Props, toolbox)
            end, type = "anim", data = {lib = "rcmepsilonism8", anim = "bag_handler_idle_a", car = 0, loop = 57, e = "skrzynka"}},
            {label = "Skrzynka 2 - z narzędziami [R]", prop = function()
                local toolbox2 = CreateObject(GetHashKey('prop_tool_box_02'), 1.0, 1.0, 1.0, 1, 1, 0)
                AttachEntityToEntity(toolbox2, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.53, 0.0, -0.02, -90.0, 0.0, 90.0, 1, 1, 0, 1, 1, 1)
                table.insert(Config.Props, toolbox2)
            end, type = "anim", data = {lib = "rcmepsilonism8", anim = "bag_handler_idle_a", car = 0, loop = 57, e = "skrzynka2"}},    
            {label = "Mechanik 1 - maska", type = "anim", data = {lib = "mini@repair", anim = "fixing_a_ped", car = 0, loop = 1, e = "mechanik"}},
            {label = "Mechanik 2 - maska", type = "anim", data = {lib = "mini@repair", anim = "fixing_a_player", car = 0, loop = 1, e = "mechanik2"}},
            {label = "Mechanik 3 - pod autem", type = "animangle",angle=180, data = {lib = "amb@world_human_vehicle_mechanic@male@base", anim = "base", car = 0, loop = 1, e = "mechanik3"}},
            {label = "Mechanik 4 - wyjście spod auta", type = "anim", data = {lib = "amb@world_human_vehicle_mechanic@male@exit", anim = "exit", car = 0, loop = 0, e = "mechanik4"}},
            {label = "Taxi 1 - rozmowa z klientem [P]", type = "anim", data = {lib = "oddjobs@taxi@driver", anim = "leanover_idle", car = 2, loop = 1, e = "taxi"}},
            {label = "Taxi 2 - podawanie rachunku [P]", type = "anim", data = {lib = "oddjobs@taxi@cyi", anim = "std_hand_off_ps_passenger", car = 2, loop = 0, e = "taxi2"}},
            {label = "Łowienie wędką", type = "scenario", data = {anim = "WORLD_HUMAN_STAND_FISHING", car = 0, loop = 1, e = "wedka"}},
		    {label = "Uderzanie młotkiem", type = "scenario", data = {anim = "WORLD_HUMAN_HAMMERING", car = 0, loop = 0, e = "mlotek"}},
			{label = "Spawanie", type = "scenario", data = {anim = "WORLD_HUMAN_WELDING", car = 0, loop = 1, e = "spawanie"}},
            {label = "Pisanie na komputerze", type = "anim", data = {lib = "anim@heists@prison_heistig1_p1_guard_checks_bus", anim = "loop", car = 0, loop = 1, e = "komputer"}},
            {label = "Barman - polewanie kolejki", type = "anim", data = {lib = "mini@drinking", anim = "shots_barman_b", car = 0, loop = 0, e = "barman"}},
            {label = "Ładowanie towaru", type = "anim", data = {lib = "mp_am_hold_up", anim = "purchase_beerbox_shopkeeper", car = 0, loop = 0, e = "towar"}},
            {label = "Kopanie w ziemi 1", prop = function()
                local lopata = CreateObject(GetHashKey('prop_ld_shovel'), GetEntityCoords(PlayerPedId()), true, false, false)
                AttachEntityToEntity(lopata, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0, 0, 0, 0, 2, 1)
                table.insert(Config.Props, lopata)
            end, type = "anim", data = {lib = "random@burial", car = 0, e = "kopanie"}},
			{label = "Kopanie w ziemi 2 - klękanie", type = "scenario", data = {anim = "world_human_gardener_plant", car = 0, loop = 0, e = "kopanie2"}},
			{label = "Patrzenie w notatki",prop = function()
                local clipboard = CreateObject(GetHashKey('p_amb_clipboard_01'), GetEntityCoords(PlayerPedId()), true)-- creates object
                AttachEntityToEntity(clipboard, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 0x8CBD), 0.1, 0.015, 0.12, 45.0, -130.0, 180.0, 1, 0, 0, 0, 0, 1)
                table.insert(Config.Props, clipboard)
            end, type = "anim", data = {lib = "amb@world_human_clipboard@male@idle_a", anim = "idle_c", car = 0, loop = 51, e = "notatki"}},
        }
    },

    {
        name = 'Frakcje',
        label = '🚔 Frakcje',
        items = {
            {label = "Sprawdzanie stanu 1 - klękanie", type = "scenario", data = {anim = "CODE_HUMAN_MEDIC_KNEEL", car = 0, loop = 0, e = "stan"}},
            {label = "Sprawdzanie stanu 2 - uciskanie", type = "anim", data = {lib = "anim@heists@narcotics@funding@gang_idle", anim = "gang_chatting_idle01", car = 0, loop = 1, e = "stan2"}},	
            {label = "Łykanie tabletki [R]", type = "anim", data = {lib = "mp_suicide", anim = "pill", car = 1, loop = 56, e = "tabletka"}},			
		    {label = "Ból w klatce piersiowej", type = "animangle",angle=180, data = {lib = "anim@heists@prison_heistig_5_p1_rashkovsky_idle", anim = "idle", car = 0, loop = 1, e = "klatka"}},
            {label = "Ból nogi", type = "anim", data = {lib = "missfbi5ig_0", anim = "lyinginpain_loop_steve", car = 0, loop = 1, e = "noga"}},
            {label = "Drgawki", type = "anim", data = {lib = "missheistfbi3b_ig8_2", anim = "cpr_loop_victim", car = 0, loop = 1, e = "dragwki"}},
         	{label = "Omdlenie 1 - prawy bok", type = "anim", data = {lib = "dam_ko@shot", anim = "ko_shot_head", car = 0, loop = 2, e = "omdlenie"}},
            {label = "Omdlenie 2 - na plecy", type = "anim", data = {lib = "anim@gangops@hostage@", anim = "perp_success", car = 0, loop = 2, e = "omdlenie2"}},
            {label = "Omdlenie 3 - leżąc", type = "anim", data = {lib = "mini@cpr@char_b@cpr_def", anim = "cpr_intro", car = 0, loop = 2, e = "omdlenie3"}},
			{label = "Ocknięcie 1 - ponowne omdlenie", type = "anim", data = {lib = "missfam5_blackout", anim = "pass_out", car = 0, loop = 2, e = "ockniecie"}},
			{label = "Ocknięcie 2 - wymiotowanie", type = "animo", data = {lib = "missfam5_blackout", anim = "vomit", car = 0, loop = 0, e = "ockniecie2"}},
			{label = "Ocknięcie 3 - szybko", type = "anim", data = {lib = "safe@trevor@ig_8", anim = "ig_8_wake_up_front_player", car = 0, loop = 0, e = "ockniecie3"}},
			{label = "Ocknięcie 4 - powoli", type = "anim", data = {lib = "safe@trevor@ig_8", anim = "ig_8_wake_up_right_player", car = 0, loop = 0, e = "ockniecie4"}},
            {label = "Brak przytomności 1", type = "anim", data = {lib = "mini@cpr@char_b@cpr_def", anim = "cpr_pumpchest_idle", car = 0, loop = 1, e = "nieprzytomnosc"}},
			{label = "Brak przytomności 2", type = "anim", data = {lib = "missprologueig_6", anim = "lying_dead_brad", car = 0, loop = 1, e = "nieprzytomnosc2"}},
            {label = "Brak przytomności 3", type = "anim", data = {lib = "missprologueig_6", anim = "lying_dead_player0", car = 0, loop = 1, e = "nieprzytomnosc3"}},
			{label = "Brak przytomności 4 - na brzuchu", type = "animangle", angle=90,  data = {lib = "missarmenian2", anim = "drunk_loop", car = 0, loop = 1, e = "nieprzytomnosc4"}},
            {label = "RKO 1 - uciskanie", type = "anim", data = {lib = "mini@cpr@char_a@cpr_str", anim = "cpr_pumpchest", car = 0, loop = 1, e = "rko"}},
            {label = "RKO 2 - wdechy", type = "anim", data = {lib = "mini@cpr@char_a@cpr_str", anim = "cpr_kol", car = 0, loop = 1, e = "rko2"}},
			{label = "Operacja / trumna", type = "anim", data = {lib = "anim@gangops@morgue@table@", anim = "ko_back", car = 0, loop = 1, e = "operacja"}},
            {label = "Wzywanie SOS - rękoma [R]", type = "anim", data = {lib = "random@gang_intimidation@", anim = "001445_01_gangintimidation_1_female_wave_loop", car = 0, loop = 51, e = "sos"}},
            {label = "Sprawdzanie dowodów", type = "anim", data = {lib = "amb@code_human_police_investigate@idle_b", anim = "idle_f", car = 0, loop = 0, e = "dowody"}},
			{label = "Kierowanie ruchem", prop = function()
                local parkingwand = CreateObject(GetHashKey('prop_parking_wand_01'), GetEntityCoords(PlayerPedId()), true)-- creates object
                AttachEntityToEntity(parkingwand, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 0xDEAD), 0.1, 0.0, -0.03, 65.0, 100.0, 130.0, 1, 0, 0, 0, 0, 1)
                table.insert(Config.Props, parkingwand)
            end, type = "anim", data = {lib = "amb@world_human_car_park_attendant@male@base", anim = "base", car = 0, loop = 1, e = "kierowanie"}},
			{label = "Notes", prop = function()
                local notes = CreateObject(GetHashKey('prop_notepad_02'), GetEntityCoords(PlayerPedId()), true)-- creates object
                AttachEntityToEntity(notes, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 0x49D9), 0.15, 0.03, 0.0, -42.0, 0.0, 0.0, 1, 0, 0, 0, 0, 1)
                table.insert(Config.Props, notes)

                local pen = CreateObject(GetHashKey('prop_pencil_01'), GetEntityCoords(PlayerPedId()), true)-- creates object
                AttachEntityToEntity(pen, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 0xFA10), 0.04, -0.02, 0.01, 90.0, -125.0, -180.0, 1, 0, 0, 0, 0, 1)
                table.insert(Config.Props, pen)
            end, type = "anim", data = {lib = "amb@medic@standing@timeofdeath@base", anim = "base", car = 1, loop = 51, e = "notes"}},
			{label = "Odznaka", type = "anim", data = {lib = "fbi_5b_mcs_1-0", anim = "prop_fib_badge-0", car = 0, loop = 0, e = "odznaka"}},
        }
    },

    {
        name = 'pegi21',
        label = '❤️ PEGI 21',
        items = {
            {label = " Oral", type = "anim", data = {lib = "misscarsteal2pimpsex", anim = "pimpsex_punter", car = 0, loop = 0, e = ""}},
            {label = " Oral 2", type = "anim", data = {lib = "misscarsteal2pimpsex", anim = "pimpsex_hooker", car = 0, loop = 0, e = ""}},  
            {label = "Seks na stojąco", type = "anim", data = {lib = "misscarsteal2pimpsex", anim = "shagloop_pimp", car = 0, loop = 0, e = ""}},  			
            {label = "Anal", type = "anim", data = {lib = "rcmpaparazzo_2", anim = "shag_loop_a", car = 0, loop = 56, e = ""}},   
            {label = "Anal 2", type = "anim", data = {lib = "rcmpaparazzo_2", anim = "shag_loop_poppy", car = 0, loop = 56, e = ""}},   
            {label = "Anal 3", type = "anim", data = {lib = "timetable@trevor@skull_loving_bear", anim = "skull_loving_bear", car = 0, loop = 56, e = ""}},   
        }
    },
}
