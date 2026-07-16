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
	GOLD_TILES,
	BALL_MULT,
	CLICK_MULT,
	BALL_WORTH,
	CLICK_WORTH,
	STEEL_BALL,
	PRISTINE_BALL,
	DIAMOND_TILES,
	GOLD_MULT,
	DIAMOND_MULT
}

const stat_map = {
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
	StatType.GOLD_TILES: "global_gold_tiles",
	StatType.BALL_MULT: "global_ball_mult",
	StatType.CLICK_MULT: "global_click_mult",
	StatType.BALL_WORTH: "global_ball_worth",
	StatType.CLICK_WORTH: "global_click_worth",
	StatType.STEEL_BALL: "global_steel_ball",
	StatType.PRISTINE_BALL: "global_pristine_ball",
	StatType.DIAMOND_TILES: "global_diamond_tiles",
	StatType.GOLD_MULT: "global_gold_mult",
	StatType.DIAMOND_MULT:"global_diamond_mult",
}

@export var stat : StatType
@export var value : float
@export_multiline var text : String
@export var texture : Texture2D
