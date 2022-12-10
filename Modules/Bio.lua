local addonName, addon = ...
addon = LibStub("AceAddon-3.0"):GetAddon(addonName)
--_G[addonName] = {}
addon.Frame = LibStub("AceGUI-3.0")

-- /dump C_UIWidgetManager.GetStatusBarWidgetVisualizationInfo(4220)
local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local currentVigor = 0
local maxVigor = 0
local currentCharge = 0
local iconWidth, iconHeight = 30, 30
local DragonFlyingZones = {2022, 2023, 2024, 2025, 2107, 2112}
local DragonFlyingSpells = {368896, 368899, 360954, 368901}
local Ticker
local VigorFrame
local MaxVigorAvailable = 6
local hasPlayed = {["max"]=true,["empty"]=false}
local currentDragon = nil

local dragonNames = {"Adalinda","Anastasia","Belinda","Chumana","Chusi","Dalinda","Hydra","Kaida","Kaliyah","Kayda","Khaleesi","Malinda","Medus","Melusine","Ryoko","Tanis","Tiamat","Wyvern","Vyara","Zafira","Apalala","Apep","Attor","Cadmus","Chua","Dracul","Drago","Drake","Fraener","George","Longwei","Nithe","Ormr","Quetzalcoatl","Ryuu","Shesha","Slayer","Tatsuya","Veles","Viper","Arrow","Azar","Blaze","Boruta","Brande","Chance","Danbala","Devlin","Ember","Iseul","Kenna","Kirin","Knucker","Orochi","Pachua","Scylla","Shenron","Syrax","Sol","Valryon","Arman","Arya","Daenerys","Diaval","Draco","Elliot","Errol","Eragon","Eustace","Falkor","Figment","Haku","Ladon","Maleficent","Mushu","Pendragon","Rhaegal","Saphira","Thorn","Vritra","Aiden","Aine","Alev","Alina","Brenna","Brenton","Edna","Eirwen","Egan","Idris","Kai","Katla","Kimba","Lumi","Nieves","Nuri","Orinda","Reese","Tanwen","Tyson",}
local titles = {"Mother of Stones","Father of Bones","Sister of Caverns","the Elder Slurm","Raja of Tombs","the Mighty Head","the Headless One","Kingbearer","Stormbringer","the Oncoming Storm","the Accented One","the End of All Things and The Darkness in the Earthern Light","Jupiter's Comet","the Nice One","the Lovely Soothsayer","the Benevolent Crown","the Atomic Foot","the Bottle to End all Bottles","the Final Solution","the First Lamprey","the Stormfury","Tidebreaker","Wind-reaver","the Inferno Incarnate","Stoneshatter","the Endless Roar","the First Flame","Will-Breaker","the Umbra Ascendant","Bringer of the Gloaming","the Apex","Shade-Walker","the Frostflame","the Dweller in the Deep","the Unknowable","the Hunger Unending","the Devastator","the End-Bringer","the Ravager","the Reaper","the Scaled Eternity","the Evening Star","Stone-Melter","the Empire's Judgment","the Arbiter of Fate","the Mountain-Carver","the World-Maw"}
local colors = {"White","Yellow","Blue","Red","Green","Black","Brown","Azure","Ivory","Teal","Silver","Purple","Navy blue","Pea green","Gray","Orange","Maroon","Charcoal","Aquamarine","Coral","Fuchsia","Wheat","Lime","Crimson","Khaki","Hot pink","Magenta","Olden","Plum","Olive","Cyan","Infra-red","Ultra-violet","Colorblind",}
local likes = {"Rain","Trees","Beaches","Cool breezes","Fresh air","Animals","Butterflies","Cricket sounds","Flowers","Nature","Sun","Poems","Hot baths","Bonfires","Fall weather","Candy","Chocolate","Cake","Presents","Jewelry","Warm blankets","Music","Heroes","Puppies","Kittens","Coffee","Tea","Hugs","Kisses","Holding hands","Affection","Coziness","Quiet","Calm","Peace","Recognition","Praise","Success","Acts of kindness","Shopping","Spending time with friends","Journaling","Watching a show","Aquariums","Museums","Live music","Zoos","Singing","Dancing","Acting","Massages","Traveling","Learning new things","Cold showers","Long"," hot showers","Watching","Sleeping in","Eating ","Being smiled at","Being greeted","Clean sheets.","Fresh laundry","Warm towels","Cooking in the kitchen","Family","Community","Fulfillment","A good joke","Laughter","Comedy","Fresh breath","Crusty","Hot bread",}
local dislikes = {"Extreme hot","Extreme cold","Large groups","Being alone","Skipping meals","Being late","Boredom","Sharp objects","Loud noises","Bright lights","Water","Seafood","Natural disasters","Heights","Bugs","Rejection","Clowns","Scorn","Criticism","Greed","Anger","Darkness","Snobs","Runny nose","Whining","Getting lost","Being ignored","Itchy skin","Hatred","Awkwardness","Arrogance","Rudeness","Lying","Unreliable","Oppression","Malice","Gossip","Ignorance","Tiredness","Burning food","Politics","Know it alls","Violence","Fighting","Falling","Foul odor","Screaming","Clutter","Headaches","Unwanted attention","Allergies","Bird poop","Stomach aches","Getting poked with a sword","People staring at you",}
local age = 10000
local mood = {"Surprised","Stressed","Mad","Loved","Lonely","Weird","Uncomfortable","Touched","Tired","Thankful","Sympathetic","Smart","Sleepy","Silly","Pleased","Pessimistic","Sick","Shocked","Satisfied","Sad","Rushed","Restless","Relieved","Relaxed","Rejuvenated","Rejected","Refreshed","Recumbent","Quixotic","Predatory","Peaceful","Optimistic","Okay","Numb","Giggly","Giddy","Not specified","Nerdy","Infuriated","Indifferent","Indescribable","Naughty","Morose","Moody","Mischievous","Mellow","Melancholy","Listless","Lethargic","Lazy","Jubilant","Jealous","Irritated","Irate","Impressed","Hyper","Hungry","Hot","Hopeful","High","Happy","Guilty","Grumpy","Groggy","Grateful","Dorky","Ditzy","Discontent","Good","Gloomy","Geeky","Full","Frustrated","Flirty","Exhausted","Excited","Enraged","Energetic","Anxious","Annoyed","Angry","Ecstatic","Drunk","Drained","Disappointed","Dirty","Devious","Determined","Depressed","Dark","Cynical","Curious","Alone","Aggravated","Accomplished","Accepted","Crushed","Crazy","Crappy","Cranky","Content","Confused","Complacent","Cold","Chipper","Cheerful","Calm","Bouncy","Bored","Blissful","Blank","Blah","Bittersweet","Bewildered","Awake","Ashamed","Apathetic","Amused","Exanimate","Envious","Enthralled",}

function addon:BuildDragon()
	local dragon = {
	name = dragonNames[ math.random( #dragonNames ) ],
	title = titles[ math.random( #titles ) ],
	color = colors[ math.random( #colors ) ],
	likes = likes[ math.random( #likes ) ],
	dislikes = dislikes[ math.random( #dislikes ) ],
	age =  math.random(500,900 ) + 10000,
	mood = mood[ math.random( #mood ) ],
	quote = "Weeee",
	mounted = 0,
	}
	return dragon
end

function addon:GetMood()
	local mood = mood[ math.random( #mood ) ]

	return mood
end