extends Resource
class_name upgrade_stats

enum StatType {
	BALL_POWER,
	SPEED,
	SIZE,
	TILE_WORTH,
	MONEY_MULT,
	BALL_CRIT,
	BALL_CRIT_MULT,
	CLICK_POWER,
	CLICK_CRIT,
	CLICK_CRIT_MULT,
	RARE_TILES,
	BALL_MULT,
	CLICK_MULT,
	BALL_WORTH,
	CLICK_WORTH
}

var stat_map = {
	StatType.BALL_POWER: "global_ball_power",
	StatType.SPEED: "global_speed",
	StatType.SIZE: "global_size",
	StatType.TILE_WORTH: "global_tile_worth",
	StatType.MONEY_MULT: "global_money_mult",
	StatType.BALL_CRIT: "global_ball_crit",
	StatType.BALL_CRIT_MULT: "global_ball_crit_power",
	StatType.CLICK_POWER: "global_click_power",
	StatType.CLICK_CRIT: "global_click_crit",
	StatType.CLICK_CRIT_MULT: "global_click_crit_power",
	StatType.RARE_TILES: "global_rare_tiles",
	StatType.BALL_MULT: "global_ball_mult",
	StatType.CLICK_MULT: "global_click_mult",
	StatType.BALL_WORTH: "global_ball_worth",
	StatType.CLICK_WORTH: "global_click_worth"
}

@export var stat : StatType
@export var value : float
@export_multiline var text : String
@export var texture : Texture2D
