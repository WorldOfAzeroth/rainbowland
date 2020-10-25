
USE world;


-- CLEAN-UP
DELETE FROM creature_template WHERE entry IN (601099, 601100, 601101, 601102, 601103, 601104, 601105, 601106);
DELETE FROM creature WHERE guid >= 1979300 AND guid <= 1979327;
DELETE FROM npc_vendor WHERE entry >= 601099 AND entry <= 601116;


-- --------------------------------------------------------------------------------------
--	Rainbowland Items 601099 
-- --------------------------------------------------------------------------------------
SET
@Entry 		:= 601099,
@Model 		:= 14233, -- Ravak Grimtotem, Bounty Hunter
@Name 		:= "德瓦尔特·斯蒂尔",
@Title 		:= "积分相关业务",
@Icon 		:= "Buy",
@GossipMenu := 0,
@MinLevel 	:= 80,
@MaxLevel 	:= 80,
@Faction 	:= 35,
@NPCFlag 	:= 128, -- Vendor
@Scale		:= 1.0,
@Rank		:= 0,
@UnitClass  := 1,
@UnitFlags	:= 37376,
@UnitFlags2 := 2048,
@Type 		:= 7,
@TypeFlags 	:= 0,
@FlagsExtra := 2,
@AIName		:= "SmartAI",
@Script 	:= "";

-- NPC
DELETE FROM creature_template WHERE entry = @Entry;
INSERT INTO creature_template (entry, modelid1, name, subname, IconName, gossip_menu_id, minlevel, maxlevel, faction, npcflag, speed_walk, speed_run, scale, rank, unit_class, unit_flags, unit_flags2, type, type_flags, InhabitType, RegenHealth, flags_extra, AiName, ScriptName) VALUES
(@Entry, @Model, @Name, @Title, @Icon, @GossipMenu, @MinLevel, @MaxLevel, @Faction, @NPCFlag, 1, 1.14286, @Scale, @Rank, @UnitClass, @UnitFlags, @UnitFlags2, @Type, @TypeFlags, 3, 1, @FlagsExtra, @AIName, @Script);

INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`) VALUES 
(@Entry,0,23162,0,0,3000),
(@Entry,0,40772,0,0,3000),
(@Entry,0,44452,0,0,3000),
(@Entry,0,701003,0,0,3003),
(@Entry,0,701004,0,0,3001),
(@Entry,0,701005,0,0,3003),
(@Entry,0,701006,0,0,3001),
(@Entry,0,701007,0,0,3000),
(@Entry,0,701008,0,0,3000),
(@Entry,0,701010,0,0,3001),
(@Entry,0,701011,0,0,3001),
(@Entry,0,701012,0,0,3002),
(@Entry,0,701013,0,0,3002),
(@Entry,0,701014,0,0,3004),
(@Entry,0,701015,0,0,3004);




-- --------------------------------------------------------------------------------------
--	HEIRLOOM VENDOR - 601100
-- --------------------------------------------------------------------------------------
SET
@Entry 		:= 601100,
@Model 		:= 25900, -- Small Tyrion
@Name 		:= "布拉莫德·深井",
@Title 		:= "新手武器装备",
@Icon 		:= "Buy",
@GossipMenu := 0,
@MinLevel 	:= 80,
@MaxLevel 	:= 80,
@Faction 	:= 35,
@NPCFlag 	:= 128, -- 
@Scale		:= 1.0,
@Rank		:= 0,
@Type 		:= 7,
@TypeFlags 	:= 0,
@FlagsExtra := 2,
@AIName		:= "SmartAI",
@Script 	:= "";

-- NPC
DELETE FROM creature_template WHERE entry = @Entry;
INSERT INTO creature_template (entry, modelid1, name, subname, IconName, gossip_menu_id, minlevel, maxlevel, faction, npcflag, speed_walk, speed_run, scale, rank, unit_class, unit_flags, type, type_flags, InhabitType, RegenHealth, flags_extra, AiName, ScriptName) VALUES
(@Entry, @Model, @Name, @Title, @Icon, @GossipMenu, @MinLevel, @MaxLevel, @Faction, @NPCFlag, 1, 1.14286, @Scale, @Rank, 1, 2, @Type, @TypeFlags, 3, 1, @FlagsExtra, @AIName, @Script);

-- Items
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`) VALUES

-- 旅行者的背包
(@Entry, '0', '4500', '0', '0', '0'),
(@Entry, '0', '13321', '0', '0', '0'),
(@Entry, '0', '12325', '0', '0', '0'),
(@Entry, '0', '13332', '0', '0', '0'),
(@Entry, '0', '15290', '0', '0', '0'),

-- T3-信仰
(@Entry, '0', '22515', '0', '0', '0'),
(@Entry, '0', '22516', '0', '0', '0'),
(@Entry, '0', '22514', '0', '0', '0'),
(@Entry, '0', '22518', '0', '0', '0'),
(@Entry, '0', '22513', '0', '0', '0'),
(@Entry, '0', '22519', '0', '0', '0'),
(@Entry, '0', '22517', '0', '0', '0'),
(@Entry, '0', '23061', '0', '0', '0'),
(@Entry, '0', '22512', '0', '0', '0'),
-- T3-地穴追猎者
(@Entry, '0', '22439', '0', '0', '0'),
(@Entry, '0', '22440', '0', '0', '0'),
(@Entry, '0', '22438', '0', '0', '0'),
(@Entry, '0', '22442', '0', '0', '0'),
(@Entry, '0', '22437', '0', '0', '0'),
(@Entry, '0', '22443', '0', '0', '0'),
(@Entry, '0', '22441', '0', '0', '0'),
(@Entry, '0', '23067', '0', '0', '0'),
(@Entry, '0', '22436', '0', '0', '0'),
-- T3-救赎
(@Entry, '0', '22429', '0', '0', '0'),
(@Entry, '0', '22430', '0', '0', '0'),
(@Entry, '0', '22428', '0', '0', '0'),
(@Entry, '0', '22431', '0', '0', '0'),
(@Entry, '0', '22427', '0', '0', '0'),
(@Entry, '0', '22424', '0', '0', '0'),
(@Entry, '0', '22426', '0', '0', '0'),
(@Entry, '0', '23066', '0', '0', '0'),
(@Entry, '0', '22425', '0', '0', '0'),
-- T3-无畏
(@Entry, '0', '22419', '0', '0', '0'),
(@Entry, '0', '22420', '0', '0', '0'),
(@Entry, '0', '22418', '0', '0', '0'),
(@Entry, '0', '22422', '0', '0', '0'),
(@Entry, '0', '22417', '0', '0', '0'),
(@Entry, '0', '22423', '0', '0', '0'),
(@Entry, '0', '22421', '0', '0', '0'),
(@Entry, '0', '23059', '0', '0', '0'),
(@Entry, '0', '22416', '0', '0', '0'),
-- T3-梦游者
(@Entry, '0', '22491', '0', '0', '0'),
(@Entry, '0', '22492', '0', '0', '0'),
(@Entry, '0', '22490', '0', '0', '0'),
(@Entry, '0', '22494', '0', '0', '0'),
(@Entry, '0', '22489', '0', '0', '0'),
(@Entry, '0', '22495', '0', '0', '0'),
(@Entry, '0', '22493', '0', '0', '0'),
(@Entry, '0', '23064', '0', '0', '0'),
(@Entry, '0', '22488', '0', '0', '0'),
-- T3-瘟疫之心
(@Entry, '0', '22507', '0', '0', '0'),
(@Entry, '0', '22508', '0', '0', '0'),
(@Entry, '0', '22506', '0', '0', '0'),
(@Entry, '0', '22510', '0', '0', '0'),
(@Entry, '0', '22505', '0', '0', '0'),
(@Entry, '0', '22511', '0', '0', '0'),
(@Entry, '0', '22509', '0', '0', '0'),
(@Entry, '0', '23063', '0', '0', '0'),
(@Entry, '0', '22504', '0', '0', '0'),
-- T3-碎地者
(@Entry, '0', '22467', '0', '0', '0'),
(@Entry, '0', '22468', '0', '0', '0'),
(@Entry, '0', '22466', '0', '0', '0'),
(@Entry, '0', '22470', '0', '0', '0'),
(@Entry, '0', '22465', '0', '0', '0'),
(@Entry, '0', '22471', '0', '0', '0'),
(@Entry, '0', '22469', '0', '0', '0'),
(@Entry, '0', '23065', '0', '0', '0'),
(@Entry, '0', '22464', '0', '0', '0'),
-- T3-霜火
(@Entry, '0', '22499', '0', '0', '0'),
(@Entry, '0', '22500', '0', '0', '0'),
(@Entry, '0', '22498', '0', '0', '0'),
(@Entry, '0', '22502', '0', '0', '0'),
(@Entry, '0', '22497', '0', '0', '0'),
(@Entry, '0', '22503', '0', '0', '0'),
(@Entry, '0', '22501', '0', '0', '0'),
(@Entry, '0', '23062', '0', '0', '0'),
(@Entry, '0', '22496', '0', '0', '0'),
-- T3-骨镰
(@Entry, '0', '22479', '0', '0', '0'),
(@Entry, '0', '22480', '0', '0', '0'),
(@Entry, '0', '22478', '0', '0', '0'),
(@Entry, '0', '22482', '0', '0', '0'),
(@Entry, '0', '22477', '0', '0', '0'),
(@Entry, '0', '22483', '0', '0', '0'),
(@Entry, '0', '22481', '0', '0', '0'),
(@Entry, '0', '23060', '0', '0', '0'),
(@Entry, '0', '22476', '0', '0', '0'),



(@Entry, '0', '19367', '0', '0', '0'),  -- 巨龙之触
(@Entry, '0', '19371', '0', '0', '0'),  -- 龙魂坠饰
(@Entry, '0', '19376', '0', '0', '0'),  -- 阿基迪罗斯的清算之戒
(@Entry, '0', '19377', '0', '0', '0'),  -- 普瑞斯托的阴谋饰物
(@Entry, '0', '19382', '0', '0', '0'),  -- 纯源质指环
(@Entry, '0', '19383', '0', '0', '0'),  -- 屠龙大师勋章
(@Entry, '0', '19384', '0', '0', '0'),  -- 屠龙大师之戒
(@Entry, '0', '19397', '0', '0', '0'),  -- 黑石之戒
(@Entry, '0', '19403', '0', '0', '0'),  -- 专注指环
(@Entry, '0', '19432', '0', '0', '0'),  -- 源力之环
(@Entry, '0', '19434', '0', '0', '0'),  -- 黑暗统御指环

(@Entry, '0', '19348', '0', '0', '0'),  -- 红龙防护者
(@Entry, '0', '19349', '0', '0', '0'),  -- 源质壁垒
(@Entry, '0', '19378', '0', '0', '0'),  -- 龙王披风
(@Entry, '0', '19386', '0', '0', '0'),  -- 源质丝线披风
(@Entry, '0', '19398', '0', '0', '0'),  -- 火喉披风
(@Entry, '0', '19430', '0', '0', '0'),  -- 纯净思想斗篷
(@Entry, '0', '19436', '0', '0', '0'),  -- 飞龙披风

(@Entry, '0', '19435', '0', '0', '0'),  -- 精华收集者
(@Entry, '0', '19334', '0', '0', '0'),  -- 狂野之刃
(@Entry, '0', '19335', '0', '0', '0'),  -- 碎脊者
(@Entry, '0', '19346', '0', '0', '0'),  -- 龙牙之刃
(@Entry, '0', '19347', '0', '0', '0'),  -- 克洛玛古斯之爪
(@Entry, '0', '19350', '0', '0', '0'),  -- 击心者
(@Entry, '0', '19351', '0', '0', '0'),  -- 玛拉达斯，黑龙军团的符文之剑


(@Entry, '0', '19352', '0', '0', '0'),  -- 多彩之剑
(@Entry, '0', '19353', '0', '0', '0'),  -- 龙爪巨斧
(@Entry, '0', '19354', '0', '0', '0'),  -- 巨龙复仇者
(@Entry, '0', '19355', '0', '0', '0'),  -- 暗影之翼
(@Entry, '0', '19356', '0', '0', '0'),  -- 暗影烈焰法杖
(@Entry, '0', '19357', '0', '0', '0'),  -- 悲哀使者
(@Entry, '0', '19358', '0', '0', '0'),  -- 龙人之槌
(@Entry, '0', '19360', '0', '0', '0'),  -- 洛卡米尔·伊洛曼希斯
(@Entry, '0', '19361', '0', '0', '0'),  -- 埃瑟利苏尔，惩戒之弩
(@Entry, '0', '19362', '0', '0', '0'),  -- 末日之刃
(@Entry, '0', '19363', '0', '0', '0'),  -- 克鲁索洛克恩，混乱之刃
(@Entry, '0', '19364', '0', '0', '0'),  -- 兄弟会之剑
(@Entry, '0', '19365', '0', '0', '0'),  -- 黑龙之爪
(@Entry, '0', '19368', '0', '0', '0'),  -- 龙息手持火炮
(@Entry, '0', '701002', '0', '0', '0');


-- --------------------------------------------------------------------------------------
--	Legendary Items VENDOR
-- --------------------------------------------------------------------------------------

SET
@Entry 		:= 601101,
@Model 		:= 27163, -- Warmaster Molog
@Name 		:= "斯利姆·沙迪",
@Title 		:= "经典稀有坐骑",
@Icon 		:= "Buy",
@GossipMenu := 0,
@MinLevel 	:= 80,
@MaxLevel 	:= 80,
@Faction 	:= 35,
@NPCFlag 	:= 128, -- Vendor
@Scale		:= 1.0,
@Rank		:= 0,
@UnitClass  := 1,
@UnitFlags	:= 37376,
@UnitFlags2 := 2048,
@Type 		:= 7,
@TypeFlags 	:= 0,
@FlagsExtra := 2,
@AIName		:= "SmartAI",
@Script 	:= "";

-- NPC
DELETE FROM creature_template WHERE entry = @Entry;
INSERT INTO creature_template (entry, modelid1, name, subname, IconName, gossip_menu_id, minlevel, maxlevel, faction, npcflag, speed_walk, speed_run, scale, rank, unit_class, unit_flags, unit_flags2, type, type_flags, InhabitType, RegenHealth, flags_extra, AiName, ScriptName) VALUES
(@Entry, @Model, @Name, @Title, @Icon, @GossipMenu, @MinLevel, @MaxLevel, @Faction, @NPCFlag, 1, 1.14286, @Scale, @Rank, @UnitClass, @UnitFlags, @UnitFlags2, @Type, @TypeFlags, 3, 1, @FlagsExtra, @AIName, @Script);

-- NPC Items
DELETE FROM `npc_vendor` WHERE `entry` = @Entry;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`) VALUES
(@Entry,0,46017,0,0,3006),
(@Entry,0,49623,0,0,3030),
(@Entry,0,701560,0,0,3012),
(@Entry,0,701567,0,0,3006),
(@Entry,0,701574,0,0,3005),
(@Entry,0,701581,0,0,3005),
(@Entry,0,701588,0,0,3010),
(@Entry,0,701595,0,0,3010),
(@Entry,0,701602,0,0,3006),
(@Entry,0,701609,0,0,3006),
(@Entry,0,701616,0,0,3010),
(@Entry,0,701623,0,0,3006),
(@Entry,0,701630,0,0,3006),
(@Entry,0,701637,0,0,3005),
(@Entry,0,701644,0,0,3010),
(@Entry,0,701657,0,0,3030);



-- --------------------------------------------------------------------------------------
--	EXOTIC PET VENDOR - 601102
-- --------------------------------------------------------------------------------------
SET
@Entry 		:= 601102,
@Model 		:= 16801, -- Elven Reagent Seller
@Name 		:= "普拉达·阿玛尼",
@Title 		:= "经典稀有坐骑",
@Icon 		:= "Buy",
@GossipMenu := 0,
@MinLevel 	:= 80,
@MaxLevel 	:= 80,
@Faction 	:= 35,
@NPCFlag 	:= 128, -- Vendor
@Scale		:= 1.0,
@Rank		:= 0,
@Type 		:= 7,
@TypeFlags 	:= 0,
@FlagsExtra := 2,
@AIName		:= "SmartAI",
@Script 	:= "";

-- NPC
DELETE FROM creature_template WHERE entry = @Entry;
INSERT INTO creature_template (entry, modelid1, name, subname, IconName, gossip_menu_id, minlevel, maxlevel, faction, npcflag, speed_walk, speed_run, scale, rank, unit_class, unit_flags, type, type_flags, InhabitType, RegenHealth, flags_extra, AiName, ScriptName) VALUES
(@Entry, @Model, @Name, @Title, @Icon, @GossipMenu, @MinLevel, @MaxLevel, @Faction, @NPCFlag, 1, 1.14286, @Scale, @Rank, 1, 2, @Type, @TypeFlags, 3, 1, @FlagsExtra, @AIName, @Script);

-- NPC Items
DELETE FROM `npc_vendor` WHERE `entry` = @Entry;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`) VALUES
(@Entry,0,19902,0,0,3001), -- 迅捷祖利安猛虎
(@Entry,0,32317,0,0,3001), -- 红色骑乘虚空鳐
(@Entry,0,32319,0,0,3001), -- 蓝色骑乘虚空鳐
(@Entry,0,32458,0,0,3003), -- 奥的灰烬
(@Entry,0,32768,0,0,3001), -- 乌鸦之神的缰绳
(@Entry,0,33809,0,0,3001), -- 阿曼尼战熊
(@Entry,0,35513,0,0,3001), -- 迅捷白色陆行鸟
(@Entry,0,37012,0,0,3002), -- 无头骑士的缰绳
(@Entry,0,32862,0,0,3001), -- 红色灵翼幼龙的缰绳
(@Entry,0,32860,0,0,3001), -- 紫色灵翼幼龙的缰绳
(@Entry,0,32859,0,0,3001), -- 蓝色灵翼幼龙的缰绳
(@Entry,0,37676,0,0,3001), -- 复仇角斗士的虚空幼龙
(@Entry,0,41508,0,0,3001), -- 机械路霸
(@Entry,0,44413,0,0,3001), -- 机械师的摩托车
(@Entry,0,37828,0,0,3001), -- 大型美酒节科多兽,
(@Entry,0,44175,0,0,3001), -- 被感染的始祖幼龙的缰绳
(@Entry,0,45693,0,0,3003), -- 米米尔隆的头部
(@Entry,0,40777,0,0,3001), -- 北极熊挽具
(@Entry,0,45801,0,0,3001), -- 铁箍始祖幼龙的缰绳
(@Entry,0,45802,0,0,3001), -- 铁锈始祖幼龙的缰绳
(@Entry,0,46109,0,0,3001), -- 海龟
(@Entry,0,47840,0,0,3002), -- 无情角斗士的冰霜巨龙
(@Entry,0,49284,0,0,3003), -- 迅捷幽灵虎缰绳
(@Entry,0,49636,0,0,3001), -- 奥妮克希亚座龙缰绳
(@Entry,0,46171,0,0,3002), -- 狂怒角斗士的冰霜巨龙
(@Entry,0,49286,0,0,3001), -- X-51虚空火箭特别加强版
(@Entry,0,51954,0,0,3002), -- 浴血冰霜征服者缰绳
(@Entry,0,54811,0,0,3002); -- 星骓


-- --------------------------------------------------------------------------------------
--	POTION VENDOR 601103
-- --------------------------------------------------------------------------------------
SET
@Entry 		:= 601103,
@Model 		:= 12675, -- Tauren Female with Tabard
@Name 		:= "威姆·佩尔",
@Title 		:= "特色合剂药品",
@Icon 		:= "Buy",
@GossipMenu := 0,
@MinLevel 	:= 80,
@MaxLevel 	:= 80,
@Faction 	:= 35,
@NPCFlag 	:= 128, -- Vendor
@Scale		:= 1.0,
@Rank		:= 0,
@Type 		:= 7,
@TypeFlags 	:= 0,
@FlagsExtra := 2,
@AIName		:= "SmartAI",
@Script 	:= "";

-- NPC
DELETE FROM creature_template WHERE entry = @Entry;
INSERT INTO creature_template (entry, modelid1, name, subname, IconName, gossip_menu_id, minlevel, maxlevel, faction, npcflag, speed_walk, speed_run, scale, rank, unit_class, unit_flags, type, type_flags, InhabitType, RegenHealth, flags_extra, AiName, ScriptName) VALUES
(@Entry, @Model, @Name, @Title, @Icon, @GossipMenu, @MinLevel, @MaxLevel, @Faction, @NPCFlag, 1, 1.14286, @Scale, @Rank, 1, 2, @Type, @TypeFlags, 3, 1, @FlagsExtra, @AIName, @Script);

-- NPC Items
DELETE FROM `npc_vendor` WHERE `entry` = @Entry;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`) VALUES
(@Entry,0,43569,0,0,3001),
(@Entry,0,43570,0,0,3001);

-- --------------------------------------------------------------------------------------
--	 Legendary Items VENDOR 2
-- --------------------------------------------------------------------------------------
SET
@Entry 		:= 601104,
@Model 		:= 12675, -- Tauren Female with Tabard
@Name 		:= "皮娜·鲍什",
@Title 		:= "特色橙武升级",
@Icon 		:= "Buy",
@GossipMenu := 0,
@MinLevel 	:= 80,
@MaxLevel 	:= 80,
@Faction 	:= 35,
@NPCFlag 	:= 128, -- Vendor
@Scale		:= 1.0,
@Rank		:= 0,
@Type 		:= 7,
@TypeFlags 	:= 0,
@FlagsExtra := 2,
@AIName		:= "SmartAI",
@Script 	:= "";

-- NPC
DELETE FROM creature_template WHERE entry = @Entry;
INSERT INTO creature_template (entry, modelid1, name, subname, IconName, gossip_menu_id, minlevel, maxlevel, faction, npcflag, speed_walk, speed_run, scale, rank, unit_class, unit_flags, type, type_flags, InhabitType, RegenHealth, flags_extra, AiName, ScriptName) VALUES
(@Entry, @Model, @Name, @Title, @Icon, @GossipMenu, @MinLevel, @MaxLevel, @Faction, @NPCFlag, 1, 1.14286, @Scale, @Rank, 1, 2, @Type, @TypeFlags, 3, 1, @FlagsExtra, @AIName, @Script);

-- NPC Items
DELETE FROM `npc_vendor` WHERE `entry` = @Entry;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`) VALUES
(@Entry,0,701566,0,0,3040),
(@Entry,0,701573,0,0,3040),
(@Entry,0,701580,0,0,3040),
(@Entry,0,701587,0,0,3040),
(@Entry,0,701594,0,0,3040),
(@Entry,0,701601,0,0,3040),
(@Entry,0,701608,0,0,3040),
(@Entry,0,701615,0,0,3040),
(@Entry,0,701622,0,0,3040),
(@Entry,0,701629,0,0,3040),
(@Entry,0,701636,0,0,3040),
(@Entry,0,701643,0,0,3040),
(@Entry,0,701650,0,0,3040),
(@Entry,0,701656,0,0,3040),
(@Entry,0,701658,0,0,3040),
(@Entry,0,701659,0,0,3040);
-- --------------------------------------------------------------------------------------
-- Rainbowland wow MULTI-VENDOR
-- --------------------------------------------------------------------------------------
SET
@Entry 		:= 601045,
@Model 		:= 26414,
@Name 		:= "彩虹王国·萱妮",
@Title 		:= "引导者",
@Icon 		:= "Buy",
@GossipMenu := 60145,
@MinLevel 	:= 70,
@MaxLevel 	:= 70,
@Faction 	:= 35,
@NPCFlag 	:= 129, -- Gossip+QuestGiver, 128 Vendor
@Scale		:= 2,
@Rank		:= 0,
@UnitFlags	:= 512,
@UnitFlags2  := 2048,
@DynamicFlags:= 8,
@Type 		:= 7,
@TypeFlags 	:= 138412032,
@FlagsExtra := 2,
@AIName		:= "SmartAI",
@Script 	:= "";

-- NPC
DELETE FROM creature_template WHERE entry = @Entry;
INSERT INTO creature_template (entry, modelid1, name, subname, IconName, gossip_menu_id, minlevel, maxlevel, faction, npcflag, speed_walk, speed_run, scale, rank, unit_class, unit_flags, unit_flags2, dynamicflags, type, type_flags, InhabitType, RegenHealth, flags_extra, AiName, ScriptName) VALUES
(@Entry, @Model, @Name, @Title, @Icon, @GossipMenu, @MinLevel, @MaxLevel, @Faction, @NPCFlag, 1, 1.14286, @Scale, @Rank, 1, @UnitFlags, @UnitFlags2, @DynamicFlags, @Type, @TypeFlags, 3, 1, @FlagsExtra, @AIName, @Script);

DELETE FROM `gossip_menu_option` WHERE `MenuID` = @GossipMenu;
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionType`, `OptionNPCFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`) VALUES
(@GossipMenu, 0, 1, '|TInterface/ICONS/Inv_jewelcrafting_dragonseye05:30:30:-18|t积分相关业务', 3, 128, 601099, 0, 0, 0, ''),
(@GossipMenu, 1, 1, '|TInterface/ICONS/Inv_axe_09:30:30:-18|t新手武器装备', 3, 128, 601100, 0, 0, 0, ''),
(@GossipMenu, 2, 1, '|TInterface/ICONS/Inv_weapon_glave_01:30:30:-18|t可锻造的神器', 3, 128, 601101, 0, 0, 0, ''),
(@GossipMenu, 3, 1, '|TInterface/ICONS/Ability_hunter_pet_dragonhawk:30:30:-18|t经典稀有坐骑', 3, 128, 601102, 0, 0, 0, ''),
(@GossipMenu, 4, 1, '|TInterface/ICONS/Inv_alchemy_elixir_05:30:30:-18|t特色合剂药品', 3, 128, 601103, 0, 0, 0, ''),
(@GossipMenu, 5, 1, '|TInterface/ICONS/Inv_sword_92:30:30:-18|t锻造后的神器', 3, 128, 601104, 0, 0, 0, '');


-- NPC Text
DELETE FROM `npc_text` WHERE `ID`=@Entry;
INSERT INTO `npc_text` (`ID`, `text0_0`) VALUES (@Entry, '你好 $N. 欢迎来到彩虹王国。');

-- Gossip Menu
DELETE FROM `gossip_menu` WHERE `MenuID` = @GossipMenu;
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES (@GossipMenu, @Entry);

-- Creature Text
DELETE FROM `creature_text` WHERE `CreatureID` = @Entry;
INSERT INTO `creature_text` (`CreatureID`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `BroadcastTextID`, `TextRange`, `comment`) VALUES (@Entry, '0', '0', '我在这里,亲眼见证了无数玩家的成长与蜕变。', '12', '0', '100', '0', '0', '0', @Entry, '0', 'Speak');

-- Broadcast Text
DELETE FROM `broadcast_text` WHERE `ID` = @Entry;
INSERT INTO `broadcast_text` (`ID`, `Language`, `MaleText`, `FemaleText`, `EmoteID0`, `EmoteID1`, `EmoteID2`, `EmoteDelay0`, `EmoteDelay1`, `EmoteDelay2`, `SoundId`, `Unk1`, `Unk2`, `VerifiedBuild`) VALUES (@Entry, '0', '我是彩虹王国小萱，过来看看，这里有最全面的玩家服务。', '', '0', '0', '0', '0', '0', '0', '0', '0', '1', '12034');

-- Smart Scripts
DELETE FROM `smart_scripts` WHERE `entryorguid` = @Entry;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES (@Entry, '0', '0', '0', '1', '0', '100', '0', '45000', '90000', '120000', '600000', '1', '0', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '0', '0', '0', 'Speak');





SET @GUID := 1979300;

INSERT INTO `creature` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags`) VALUES 
 (@GUID+0, @ENTRY, 1, 1, 1, 0, 0, 1572.35, -4404.91, 7.49669, 5.40851, 300,0,0,5342,5342,0,0,0,0),
 (@GUID+1, @ENTRY, 0, 1, 1, 0, 0, -8832.81640, 644.565491, 94.829720, 5.220126, 300,0,0,5342,5342,0,0,0,0),
 (@GUID+2, @ENTRY, 530, 1, 1, 0, 0, 10354.4, -6367.97, 35.7119, 3.22221, 300,0,0,5342,5342,0,0,0,0),
 (@GUID+3, @ENTRY, 0, 1, 1, 0, 0, 1669.38, 1666.52, 120.719, 1.92908, 300,0,0,5342,5342,0,0,0,0),
 (@GUID+4, @ENTRY, 0, 1, 1, 0, 0, -6218.87, 326.577, 383.211, 2.95418, 300,0,0,5342,5342,0,0,0,0),
 (@GUID+5, @ENTRY, 0, 1, 1, 0, 0, -8922.25, -114.052, 82.7342, 4.2595, 300,0,0,5342,5342,0,0,0,0),
 (@GUID+6, @ENTRY, 1, 1, 1, 0, 0, -614.7, -4248.64, 38.956, 2.62005, 300,0,0,5342,5342,0,0,0,0),
 (@GUID+7, @ENTRY, 1, 1, 1, 0, 0, -2914.05, -265.317, 53.5998, 2.91931, 300,0,0,5342,5342,0,0,0,0),
 (@GUID+8, @ENTRY, 1, 1, 1, 0, 0, 10332, 825.7, 1326.36, 2.63574, 300,0,0,5342,5342,0,0,0,0),
 (@GUID+9, @ENTRY, 530, 1, 1, 0, 0, -3975.53, -13913.7, 99.0507, 5.91008, 300,0,0,5342,5342,0,0,0,0);



-- --------------------------------------------------------------------------------------
-- Rainbowland wow MULTI-VENDOR
-- --------------------------------------------------------------------------------------
SET
@Entry 		:= 601046,
@Model 		:= 4323,
@Name 		:= "彩虹王国·艾妮",
@Title 		:= "角色服务",
@Icon 		:= "Speak",
@GossipMenu := 0,
@MinLevel 	:= 80,
@MaxLevel 	:= 80,
@Faction 	:= 35,
@NPCFlag 	:= 1, -- Gossip+QuestGiver, 128 Vendor
@Scale		:= 2,
@Rank		:= 0,
@UnitFlags	:= 512,
@UnitFlags2  := 2048,
@DynamicFlags:= 8,
@Type 		:= 7,
@TypeFlags 	:= 138412032,
@FlagsExtra := 2,
@AIName		:= "SmartAI",
@Script 	:= "Npc_Services";

-- NPC
DELETE FROM creature_template WHERE entry = @Entry;
INSERT INTO creature_template (entry, modelid1, name, subname, IconName, gossip_menu_id, minlevel, maxlevel, faction, npcflag, speed_walk, speed_run, scale, unit_class, unit_flags, type, type_flags, InhabitType, RegenHealth, flags_extra, AiName, ScriptName) VALUES
(@Entry, @Model, @Name, @Title, @Icon, @GossipMenu, @MinLevel, @MaxLevel, @Faction, @NPCFlag, 1, 1.14286, @Scale, 1, 2, @Type, @TypeFlags, 3, 1, @FlagsExtra, @AIName, @Script);


-- --------------------------------------------------------------------------------------
--	Forge - 601015
-- --------------------------------------------------------------------------------------
SET
@Entry 		:= 601047,
@Model 		:= 7274,
@Name 		:= "彩虹王国·麦格娜",
@Title 		:= "神器锻造师",
@Icon 		:= "Speak",
@GossipMenu := 0,
@MinLevel 	:= 80,
@MaxLevel 	:= 80,
@Faction 	:= 35,
@NPCFlag 	:= 1,
@Scale		:= 1.8,
@Type 		:= 7,
@TypeFlags 	:= 0,
@FlagsExtra := 2,
@TEXT_ID    := 601082,
@AIName		:= "SmartAI",
@Script 	:= "npc_legendary_forge";

-- NPC
DELETE FROM creature_template WHERE entry = @Entry;
INSERT INTO creature_template (entry, modelid1, name, subname, IconName, gossip_menu_id, minlevel, maxlevel, faction, npcflag, speed_walk, speed_run, scale, unit_class, unit_flags, type, type_flags, InhabitType, RegenHealth, flags_extra, AiName, ScriptName) VALUES
(@Entry, @Model, @Name, @Title, @Icon, @GossipMenu, @MinLevel, @MaxLevel, @Faction, @NPCFlag, 1, 1.14286, @Scale, 1, 2, @Type, @TypeFlags, 3, 1, @FlagsExtra, @AIName, @Script);

-- NPC EQUIPPED
DELETE FROM `creature_equip_template` WHERE `CreatureID`=@Entry AND `ID`=1;
INSERT INTO `creature_equip_template` VALUES (@Entry, 1, 11343, 0, 0, 18019); -- Black/Purple Staff, None

-- NPC TEXT
DELETE FROM `npc_text` WHERE `ID`=@Entry;
INSERT INTO `npc_text` (`ID`, `text0_0`) VALUES (@Entry, '你好，$N。锻造你的神器，让它成为主宰艾泽拉斯的神兵利器！');

DELETE FROM `npc_text` WHERE `ID` IN  (@TEXT_ID);
INSERT INTO `npc_text` (`ID`, `text0_0`) VALUES
(@TEXT_ID, '在艾泽拉斯，只有那些经验最丰富的勇士才有足够的勇气与坚毅，挥动传奇神器迎战燃烧军团。随着你不断的对其进行锻造，就些神秘材料铸就的武器也会不断变强。你的锻造将会增升它的等级、外形、声音、以及战斗中的手感。不断地改进你的神器，让它成为战场上最合手的兵刃，在最绝望的时刻指引你所在的阵营前行吧。\r\n\n你身上没有携带可以锻造的传奇武器!');

-- --------------------------------------------------------------------------------------
--	Guild House - 601016
-- --------------------------------------------------------------------------------------
SET
@Entry 		:= 601048,
@Model 		:= 14947,
@Name 		:= "彩虹王国·艾露",
@Title 		:= "工会馆管理员",
@Icon 		:= "Speak",
@GossipMenu := 0,
@MinLevel 	:= 80,
@MaxLevel 	:= 80,
@Faction 	:= 35,
@NPCFlag 	:= 1,
@Scale		:= 2,
@Type 		:= 7,
@TypeFlags 	:= 0,
@FlagsExtra := 2,
@AIName		:= "SmartAI",
@Script 	:= "guildmaster";


-- NPC
DELETE FROM creature_template WHERE entry = @Entry;
INSERT INTO creature_template (entry, modelid1, name, subname, IconName, gossip_menu_id, minlevel, maxlevel, faction, npcflag, speed_walk, speed_run, scale, unit_class, unit_flags, type, type_flags, InhabitType, RegenHealth, flags_extra, AiName, ScriptName) VALUES
(@Entry, @Model, @Name, @Title, @Icon, @GossipMenu, @MinLevel, @MaxLevel, @Faction, @NPCFlag, 1, 1.14286, @Scale, 1, 2, @Type, @TypeFlags, 3, 1, @FlagsExtra, @AIName, @Script);



-- --------------------------------------------------------------------------------------
--	Battle Royal - 601059
-- --------------------------------------------------------------------------------------
SET
@Entry 		:= 601059,
@Model 		:= 28977,
@Name 		:= "亚历山大·麦昆",
@Title 		:= "混战引导者",
@Icon 		:= "Speak",
@GossipMenu := 0,
@MinLevel 	:= 80,
@MaxLevel 	:= 80,
@Faction 	:= 35,
@NPCFlag 	:= 1,
@Scale		:= 2,
@Type 		:= 7,
@TypeFlags 	:= 0,
@FlagsExtra := 2,
@AIName		:= "SmartAI",
@Script 	:= "npc_battle_royal_teleporter";

-- NPC
DELETE FROM creature_template WHERE entry = @Entry;
INSERT INTO creature_template (entry, modelid1, name, subname, IconName, gossip_menu_id, minlevel, maxlevel, faction, npcflag, speed_walk, speed_run, scale, unit_class, unit_flags, type, type_flags, InhabitType, RegenHealth, flags_extra, AiName, ScriptName) VALUES
(@Entry, @Model, @Name, @Title, @Icon, @GossipMenu, @MinLevel, @MaxLevel, @Faction, @NPCFlag, 1, 1.14286, @Scale, 1, 2, @Type, @TypeFlags, 3, 1, @FlagsExtra, @AIName, @Script);



-- --------------------------------------------------------------------------------------
--	Battle Royal - 601017
-- --------------------------------------------------------------------------------------
SET
@Entry 		:= 601060,
@Model 		:= 28227, -- 2306
@Name 		:= "彩虹王国·艾思",
@Title 		:= "任务引导者",
@Icon 		:= "Speak",
@GossipMenu := 0,
@MinLevel 	:= 80,
@MaxLevel 	:= 80,
@Faction 	:= 35,
@NPCFlag 	:= 1,
@Scale		:= 1,
@Type 		:= 7,
@TypeFlags 	:= 0,
@FlagsExtra := 2,
@AIName		:= "",
@Script 	:= "";

-- NPC
DELETE FROM creature_template WHERE entry = @Entry;
INSERT INTO creature_template (entry, modelid1, name, subname, IconName, gossip_menu_id, minlevel, maxlevel, faction, npcflag, speed_walk, speed_run, scale, unit_class, unit_flags, type, type_flags, InhabitType, RegenHealth, flags_extra, AiName, ScriptName) VALUES
(@Entry, @Model, @Name, @Title, @Icon, @GossipMenu, @MinLevel, @MaxLevel, @Faction, @NPCFlag, 1, 1.14286, @Scale, 1, 2, @Type, @TypeFlags, 3, 1, @FlagsExtra, @AIName, @Script);


-- --------------------------------------------------------------------------------------
--	Battle Royal - 601017
-- --------------------------------------------------------------------------------------
SET
@Entry 		:= 601061,
@Model 		:= 2043,
@Name 		:= "彩虹王国·凯莉",
@Title 		:= "幻化师",
@Icon 		:= "Speak",
@GossipMenu := 0,
@MinLevel 	:= 80,
@MaxLevel 	:= 80,
@Faction 	:= 35,
@NPCFlag 	:= 1,
@Scale		:= 2.0,
@Type 		:= 7,
@TypeFlags 	:= 0,
@FlagsExtra := 2,
@TEXT_ID    := 601083,
@STRING_ENTRY := 11100,
@AIName		:= "SmartAI",
@Script 	:= "npc_transmogrifier";

-- NPC
DELETE FROM creature_template WHERE entry IN(@Entry, 190010);
INSERT INTO creature_template (entry, modelid1, name, subname, IconName, gossip_menu_id, minlevel, maxlevel, faction, npcflag, speed_walk, speed_run, scale, unit_class, unit_flags, type, type_flags, InhabitType, RegenHealth, flags_extra, AiName, ScriptName) VALUES
(@Entry, @Model, @Name, @Title, @Icon, @GossipMenu, @MinLevel, @MaxLevel, @Faction, @NPCFlag, 1, 1.14286, @Scale, 1, 2, @Type, @TypeFlags, 3, 1, @FlagsExtra, @AIName, @Script);


DELETE FROM `npc_text` WHERE `ID` IN  (@TEXT_ID,@TEXT_ID+1);
INSERT INTO `npc_text` (`ID`, `text0_0`) VALUES
(@TEXT_ID, '幻化允许你在不改变装备属性的情况下改变装备的外观。\r\n幻化中使用的物品不再可以退款，也不再可以交易，只能和你绑定在一起。\r\n更新菜单会更新视图和价格。\r\n\r\n不是所有的东西都可以互相幻化的。\r\n限制包括但不限于:\r\n只有盔甲和武器可以幻化\r\n枪、弓和弩可以互相幻化\r\n鱼竿不能幻化\r\n您必须能够装备幻化在过程中使用的两件状备。\r\n\r\n只要你拥有它们，幻化效果就会留在你的装备上。\r\n如果你试图将装备放入公会银行或者邮寄给其他人，幻化效果将被移除。\r\n\r\n你也可以免费清除幻化效果。'),
(@TEXT_ID+1, '你可以保存你自己的幻化集。\r\n\r\n为了保存, 你首先需要幻化你的装备。\r\n当你进入设置管理菜单并保存设置菜单时，\r\n所有你幻化的物品效果都会显示出来，这样你就可以看到你保存了什么。\r\n如果您认为设置是好的，您可以点击保存设置并按您的意愿命名它。\r\n\r\n要使用幻化集，可以单击幻化集菜单中保存的幻化集，然后选择使用。\r\n如果幻化集对已经变形的装备进行了幻化，则旧的幻化效果将丢失。\r\n请注意，当你尝试使用一个幻化集合时，应用的变形限制与正常的变形相同。\r\n\r\n要删除一个幻化集，你可以进入幻化集菜单，选择删除幻化集。');

DELETE FROM `acore_string` WHERE `entry` IN  (@STRING_ENTRY+0,@STRING_ENTRY+1,@STRING_ENTRY+2,@STRING_ENTRY+3,@STRING_ENTRY+4,@STRING_ENTRY+5,@STRING_ENTRY+6,@STRING_ENTRY+7,@STRING_ENTRY+8,@STRING_ENTRY+9,@STRING_ENTRY+10);
INSERT INTO `acore_string` (`entry`, `content_default`) VALUES
(@STRING_ENTRY+0, '装备幻化成功。'),
(@STRING_ENTRY+1, '装备插槽是空的。'),
(@STRING_ENTRY+2, '选择了无效的装备。'),
(@STRING_ENTRY+3, '原装备不存在。'),
(@STRING_ENTRY+4, '目标装备不存在。'),
(@STRING_ENTRY+5, '你选择的装备无效。'),
(@STRING_ENTRY+6, '你没有足够的装备。'),
(@STRING_ENTRY+7, '你没有足够的代币。'),
(@STRING_ENTRY+8, '你所有的幻化效果已都被移除。'),
(@STRING_ENTRY+9, '没有对应的幻化效果。'),
(@STRING_ENTRY+10, '幻化集名称无效。');