/*
-- ################################################################################### --
--  ____    __                                         ____
-- /\  _`\ /\ \__                  __                 /\  _`\
-- \ \,\L\_\ \ ,_\  __  __     __ /\_\     __      ___\ \ \/\_\    ___   _ __    __
--  \/_\__ \\ \ \/ /\ \/\ \  /'_ `\/\ \  /'__`\  /' _ `\ \ \/_/_  / __`\/\`'__\/'__`\
--    /\ \L\ \ \ \_\ \ \_\ \/\ \L\ \ \ \/\ \L\.\_/\ \/\ \ \ \L\ \/\ \L\ \ \ \//\  __/
--    \ `\____\ \__\\/`____ \ \____ \ \_\ \__/.\_\ \_\ \_\ \____/\ \____/\ \_\\ \____\
--     \/_____/\/__/ `/___/> \/___L\ \/_/\/__/\/_/\/_/\/_/\/___/  \/___/  \/_/ \/____/
--                      /\___/ /\____/
--                      \/__/  \_/__/          http://stygianthebest.github.io
--
-- ################################################################################### --
--
-- WORLD: POCKET PORTAL
--
-- Creates a personal teleporter that can be carried by the player.
--
-- This Trinity script has been around for a number of years, and during my port I found
-- the NPC would never despawn. The only reference I could find had a 'Teleporter Despawn'
-- that did not work. I have added the missing Smart Script data flags that fix it. I
-- don't see how it would have worked on Trinity without this missing data either, so it
-- has likely been fucked up for years!
--
-- ################################################################################### --
*/

USE world;

-- --------------------------------------------------------------------------------------
-- Pocket Portal
-- --------------------------------------------------------------------------------------

SET @ENTRY		:= 128; 	-- CREATURE_TEMPLATE ID
SET @SOURCETYPE	:= 0; 		-- 0 = CREATURE
SET @SSID		:= 200; 	-- SCRIPT ID
SET @LINK		:= 0; 		-- LINKED SCRIPT (EXECUTES AFTER)
SET @EVENTTYPE	:= 25; 		-- 25 = SMART_EVENT_RESET (After spawn, respawn, etc.)
SET @ACTIONTYPE := 41; 		-- 41 = SMART_ACTION_FORCE_DESPAWN
SET @APARM1		:= 15000; 	-- Milliseconds until despawn occurs
SET @TTYPE		:= 19;  	-- 19 - SMART_TARGET_CLOSEST_CREATURE
SET @TPARM1		:= 128; 	-- SMART_TARGET CREATURE ID
SET @MODEL      := 29133;
SET @SCALE	    := 0.1;
SET @TEXT_ID    := 300000;
SET @GOSSIP_MENU:= 50000;
SET @NOTE		:= "Personal Teleporter Despawn";

-- --------------------------------------------------------------------------------------
-- Teleporter Item
-- --------------------------------------------------------------------------------------

DELETE FROM gossip_menu WHERE menuid BETWEEN @GOSSIP_MENU AND @GOSSIP_MENU+8;
DELETE FROM npc_text WHERE ID BETWEEN @TEXT_ID AND @TEXT_ID+4;
DELETE FROM gossip_menu_option WHERE menuid BETWEEN @GOSSIP_MENU AND @GOSSIP_MENU+8;
DELETE FROM smart_scripts WHERE entryorguid = @ENTRY AND source_type = 0;
DELETE FROM conditions WHERE (SourceTypeOrReferenceId = 15 OR SourceTypeOrReferenceId = 14) AND SourceGroup BETWEEN @GOSSIP_MENU AND @GOSSIP_MENU+8;
DELETE from creature WHERE ID = @ENTRY;
DELETE FROM `creature_template` WHERE (`entry`= @ENTRY);
DELETE FROM `smart_scripts` WHERE (`entryorguid`=@ENTRY) AND (`source_type`=@SOURCETYPE) AND (`id` = @SSID);
DELETE FROM `smart_scripts` WHERE (`entryorguid`= @ENTRY) AND (`source_type`= @SOURCETYPE) AND (`event_type`= 62);

/*
TrinityCore Portal Master
By Rochet2
Downloaded from http://rochet2.github.io/
Bugs and contact with E-mail: Rochet2@post.com
*/

SET
@ENTRY          := 190000,
@NAME           := "世界传送",
@SUBNAME        := "",
@MODEL          := 21572,

@AURA           := "30540", -- "35766" = casting

@TEXT_ID        := 300000,
@GOSSIP_MENU    := 50000,

@RUNE           := 194394;

-- Deleting code

DELETE FROM creature_template WHERE entry = @ENTRY;
DELETE FROM creature_template_addon WHERE Entry = @ENTRY ;
DELETE FROM gossip_menu WHERE menuid BETWEEN @GOSSIP_MENU AND @GOSSIP_MENU+8;
DELETE FROM npc_text WHERE ID BETWEEN @TEXT_ID AND @TEXT_ID+4;
DELETE FROM gossip_menu_option WHERE menuid BETWEEN @GOSSIP_MENU AND @GOSSIP_MENU+8;
DELETE FROM smart_scripts WHERE entryorguid = @ENTRY AND source_type = 0;
DELETE FROM conditions WHERE (SourceTypeOrReferenceId = 15 OR SourceTypeOrReferenceId = 14) AND SourceGroup BETWEEN @GOSSIP_MENU AND @GOSSIP_MENU+8;
DELETE from creature WHERE ID = @ENTRY;
DELETE from gameobject WHERE ID = @RUNE AND guid >= 200000;

-- Teleporter

INSERT INTO creature_template (entry, modelid1, name, subname, IconName, gossip_menu_id, minlevel, maxlevel, faction, npcflag, speed_walk, speed_run, scale, rank, unit_class, unit_flags, type, type_flags, RegenHealth, flags_extra, AiName) VALUES
(@ENTRY, @MODEL, @NAME, @SUBNAME, "Directions", @GOSSIP_MENU, 71, 71, 35, 3, 1, 1.14286, 1.25, 1, 1, 2, 7, 138936390, 1, 2, "SmartAI");

-- Teleporter aura

INSERT INTO creature_template_addon (entry, mount, bytes1, bytes2, emote, path_id, auras) VALUES (@ENTRY, 0, 0, 0, 0, 0, @AURA);

-- Gossip header text link to menus

INSERT INTO gossip_menu (menuid, textid) VALUES
(@GOSSIP_MENU+4, @TEXT_ID+3),
(@GOSSIP_MENU+3, @TEXT_ID+2),
(@GOSSIP_MENU+2, @TEXT_ID+2),
(@GOSSIP_MENU+1, @TEXT_ID+2),
(@GOSSIP_MENU+8, @TEXT_ID+4),
(@GOSSIP_MENU+7, @TEXT_ID+4),
(@GOSSIP_MENU+6, @TEXT_ID+4),
(@GOSSIP_MENU+5, @TEXT_ID+4),
(@GOSSIP_MENU, @TEXT_ID+1),
(@GOSSIP_MENU, @TEXT_ID);

-- Gossip header texts
INSERT INTO npc_text (ID, text0_0, em0_1) VALUES(@TEXT_ID+4, "$B你要去哪儿?$B", 0),
(@TEXT_ID+3, "$B请谨慎选择副本.$B", 0),
(@TEXT_ID+2, "$B去探索一下地下城吗?$B", 0),
(@TEXT_ID+1, "$B 为了联盟!$B", 6),
(@TEXT_ID,  "$B 为了部落!$B", 6);

-- Conditions for gossip option and menu factions

INSERT INTO conditions (SourceTypeOrReferenceId, SourceGroup, SourceEntry, ConditionTypeOrReference, ConditionValue1, Comment) VALUES
(15, @GOSSIP_MENU, 1, 6, 469, "Stormwind"),
(15, @GOSSIP_MENU+5, 2, 6, 469, "Dun Morogh"),
(15, @GOSSIP_MENU+5, 3, 6, 67, "Tirisfal Glades"),
(15, @GOSSIP_MENU+5, 4, 6, 67, "Ghostlands"),
(15, @GOSSIP_MENU+5, 5, 6, 469, "Loch modan"),
(15, @GOSSIP_MENU+5, 6, 6, 67, "Silverpine Forest"),
(15, @GOSSIP_MENU+5, 7, 6, 469, "Westfall"),
(15, @GOSSIP_MENU+5, 8, 6, 469, "Redridge mountains"),
(15, @GOSSIP_MENU+5, 9, 6, 469, "Duskwood"),
(15, @GOSSIP_MENU+5, 11, 6, 469, "Wetlands"),
(15, @GOSSIP_MENU+6, 0, 6, 469, "Azuremyst Isle"),
(15, @GOSSIP_MENU+6, 1, 6, 469, "Teldrassil"),
(15, @GOSSIP_MENU+6, 2, 6, 67, "Durotar"),
(15, @GOSSIP_MENU+6, 3, 6, 67, "Mulgore"),
(15, @GOSSIP_MENU+6, 4, 6, 469, "Bloodmyst Isle"),
(15, @GOSSIP_MENU+6, 5, 6, 469, "Darkshore"),
(15, @GOSSIP_MENU+6, 6, 6, 67, "The Barrens"),
(15, @GOSSIP_MENU+5, 1, 6, 67, "Eversong Woods"),
(15, @GOSSIP_MENU+5, 0, 6, 469, "Elwynn Forest"),
(15, @GOSSIP_MENU+4, 22, 6, 67, "Zul'Aman"),
(15, @GOSSIP_MENU, 2, 6, 67, "Orgrimmar"),
(15, @GOSSIP_MENU, 3, 6, 469, "Darnassus"),
(15, @GOSSIP_MENU, 4, 6, 469, "Ironforge"),
(15, @GOSSIP_MENU, 5, 6, 469, "Exodar"),
(15, @GOSSIP_MENU, 6, 6, 67, "Thunder bluff"),
(15, @GOSSIP_MENU, 7, 6, 67, "Undercity"),
(15, @GOSSIP_MENU, 8, 6, 67, "Silvermoon city"),
(15, @GOSSIP_MENU+1, 0, 6, 469, "Gnomeregan"),
(15, @GOSSIP_MENU+1, 1, 6, 469, "The Deadmines"),
(15, @GOSSIP_MENU+1, 2, 6, 469, "The Stockade"),
(15, @GOSSIP_MENU+1, 3, 6, 67, "Ragefire Chasm"),
(15, @GOSSIP_MENU+1, 4, 6, 67, "Razorfen Downs"),
(15, @GOSSIP_MENU+1, 5, 6, 67, "Razorfen Kraul"),
(15, @GOSSIP_MENU+1, 6, 6, 67, "Scarlet Monastery"),
(15, @GOSSIP_MENU+1, 7, 6, 67, "Shadowfang Keep"),
(15, @GOSSIP_MENU+1, 8, 6, 67, "Wailing Caverns"),
(15, @GOSSIP_MENU+6, 9, 6, 67, "Thousand Needles"),
(14, @GOSSIP_MENU, @TEXT_ID+1, 6, 469, "For the Alliance"),
(14, @GOSSIP_MENU, @TEXT_ID, 6, 67, "For the Horde");

-- Conditions for gossip option levels

INSERT INTO conditions (SourceTypeOrReferenceId, SourceGroup, SourceEntry, ConditionTypeOrReference, ConditionValue1, ConditionValue2, ConditionValue3, Comment) VALUES
(15, @GOSSIP_MENU+8, 9, 27, 77, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+8, 8, 27, 77, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+8, 7, 27, 77, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+8, 6, 27, 77, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+8, 5, 27, 76, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+8, 4, 27, 74, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+8, 3, 27, 73, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+8, 2, 27, 71, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+8, 1, 27, 68, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+8, 0, 27, 68, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+7, 6, 27, 67, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+7, 5, 27, 67, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+7, 4, 27, 65, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+7, 3, 27, 64, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+7, 2, 27, 62, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+7, 1, 27, 60, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+7, 0, 27, 58, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+6, 18, 27, 55, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+6, 17, 27, 55, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+6, 16, 27, 48, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+6, 15, 27, 48, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+6, 14, 27, 45, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+6, 13, 27, 40, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+6, 12, 27, 40, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+6, 11, 27, 35, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+6, 10, 27, 30, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+6, 9, 27, 25, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+6, 8, 27, 18, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+6, 7, 27, 15, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+6, 6, 27, 10, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+6, 5, 27, 10, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+6, 4, 27, 15, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+5, 23, 27, 70, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+5, 22, 27, 53, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+5, 21, 27, 51, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+5, 20, 27, 50, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+5, 19, 27, 45, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+5, 18, 27, 43, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+5, 17, 27, 40, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+5, 16, 27, 35, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+5, 15, 27, 35, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+5, 14, 27, 30, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+5, 13, 27, 30, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+5, 12, 27, 30, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+5, 11, 27, 20, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+5, 10, 27, 20, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+5, 9, 27, 18, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+5, 8, 27, 15, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+5, 7, 27, 10, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+5, 6, 27, 10, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+5, 5, 27, 10, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+5, 4, 27, 10, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+4, 22, 27, 70, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+4, 21, 27, 57, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+4, 19, 27, 80, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+4, 18, 27, 80, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+4, 17, 27, 80, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+4, 16, 27, 80, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+4, 15, 27, 60, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+4, 14, 27, 67, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+4, 13, 27, 70, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+4, 12, 27, 60, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+4, 11, 27, 80, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+4, 10, 27, 80, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+4, 9, 27, 60, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+4, 8, 27, 70, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+4, 7, 27, 80, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+4, 6, 27, 70, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+4, 5, 27, 70, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+4, 4, 27, 80, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+4, 3, 27, 70, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+4, 2, 27, 70, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+4, 1, 27, 60, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+4, 0, 27, 70, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+3, 11, 27, 75, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+3, 10, 27, 69, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+3, 9, 27, 77, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+3, 8, 27, 79, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+3, 7, 27, 75, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+3, 6, 27, 71, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+3, 5, 27, 79, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+3, 4, 27, 71, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+3, 3, 27, 74, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+3, 2, 27, 79, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+3, 1, 27, 79, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+3, 0, 27, 73, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+2, 5, 27, 70, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+2, 4, 27, 70, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+2, 3, 27, 59, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+2, 2, 27, 62, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+2, 1, 27, 66, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+2, 0, 27, 64, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+1, 18, 27, 35, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+1, 17, 27, 37, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+1, 16, 27, 47, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+1, 15, 27, 55, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+1, 14, 27, 55, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+1, 13, 27, 45, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+1, 12, 27, 55, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+1, 11, 27, 57, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+1, 10, 27, 53, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+1, 9, 27, 21, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+1, 8, 27, 17, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+1, 7, 27, 18, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+1, 6, 27, 32, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+1, 5, 27, 24, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+1, 4, 27, 34, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+1, 3, 27, 15, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+1, 2, 27, 22, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+1, 1, 27, 17, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU+1, 0, 27, 25, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU, 20, 27, 57, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU, 19, 27, 69, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU, 18, 27, 59, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU, 17, 27, 15, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU, 16, 27, 68, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU, 15, 27, 58, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU, 12, 27, 30, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU, 11, 27, 30, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU, 10, 27, 57, 3, 0, "Portal Master - Level req"),
(15, @GOSSIP_MENU, 9, 27, 67, 3, 0, "Portal Master - Level req");

-- Gossip options:

INSERT INTO gossip_menu_option (menuid, optionid, optionicon, optiontext, optiontype, optionnpcflag, actionmenuid, actionpoiid, boxcoded, boxmoney, boxtext) VALUES
(@GOSSIP_MENU, 1, 2, "暴风城", 1, 1, @GOSSIP_MENU, 0, 0, 0, "你确定要去暴风城吗?"),
(@GOSSIP_MENU, 2, 2, "奥格瑞玛", 1, 1, @GOSSIP_MENU, 0, 0, 0, "你确定要去奥格瑞玛吗?"),
(@GOSSIP_MENU, 3, 2, "达纳苏斯", 1, 1, @GOSSIP_MENU, 0, 0, 0, "你确定要去达纳苏斯吗?"),
(@GOSSIP_MENU, 4, 2, "铁炉堡", 1, 1, @GOSSIP_MENU, 0, 0, 0, "你确定要去铁炉堡吗?"),
(@GOSSIP_MENU, 5, 2, "埃索达", 1, 1, @GOSSIP_MENU, 0, 0, 0, "你确定要去埃索达吗?"),
(@GOSSIP_MENU, 6, 2, "雷霆崖", 1, 1, @GOSSIP_MENU, 0, 0, 0, "你确定要去雷霆崖吗?"),
(@GOSSIP_MENU, 7, 2, "幽暗城", 1, 1, @GOSSIP_MENU, 0, 0, 0, "你确定要去幽暗城吗?"),
(@GOSSIP_MENU, 8, 2, "银月城", 1, 1, @GOSSIP_MENU, 0, 0, 0, "你确定要去银月城吗?"),
(@GOSSIP_MENU, 9, 2, "达拉然", 1, 1, @GOSSIP_MENU, 0, 0, 0, "你确定要去达拉然吗?"),
(@GOSSIP_MENU, 10, 2, "沙塔斯城", 1, 1, @GOSSIP_MENU, 0, 0, 0, "你确定要去沙塔斯城吗?"),
(@GOSSIP_MENU, 11, 2, "藏宝海湾", 1, 1, @GOSSIP_MENU, 0, 0, 0, "你确定要去藏宝海湾吗?"),
(@GOSSIP_MENU, 12, 2, "古拉巴什竞技场", 1, 1, @GOSSIP_MENU, 0, 0, 0, "你确定要去古拉巴什竞技场吗?"),
(@GOSSIP_MENU, 13, 3, "东部王国", 1, 1, @GOSSIP_MENU+5, 0, 0, 0, NULL),
(@GOSSIP_MENU, 14, 3, "卡利姆多", 1, 1, @GOSSIP_MENU+6, 0, 0, 0, NULL),
(@GOSSIP_MENU, 15, 3, "外域", 1, 1, @GOSSIP_MENU+7, 0, 0, 0, NULL),
(@GOSSIP_MENU, 16, 3, "诺森德", 1, 1, @GOSSIP_MENU+8, 0, 0, 0, NULL),
(@GOSSIP_MENU, 17, 9, "初级副本", 1, 1, @GOSSIP_MENU+1, 0, 0, 0, NULL),
(@GOSSIP_MENU, 18, 9, "中级副本", 1, 1, @GOSSIP_MENU+2, 0, 0, 0, NULL),
(@GOSSIP_MENU, 19, 9, "高级副本", 1, 1, @GOSSIP_MENU+3, 0, 0, 0, NULL),
(@GOSSIP_MENU, 20, 9, "团队副本", 1, 1, @GOSSIP_MENU+4, 0, 0, 0, NULL),
(@GOSSIP_MENU+1, 0, 2, "诺莫瑞根", 1, 1, 0, 0, 0, 0, "你确定要去 诺莫瑞根吗?"),
(@GOSSIP_MENU+1, 1, 2, "死亡矿井", 1, 1, 0, 0, 0, 0, "你确定要去 死亡矿井吗?"),
(@GOSSIP_MENU+1, 2, 2, "暴风城监狱", 1, 1, 0, 0, 0, 0, "你确定要去 暴风城监狱吗?"),
(@GOSSIP_MENU+1, 3, 2, "怒焰裂谷", 1, 1, 0, 0, 0, 0, "你确定要去 怒焰裂谷吗?"),
(@GOSSIP_MENU+1, 4, 2, "剃刀高地", 1, 1, 0, 0, 0, 0, "你确定要去 剃刀高地吗?"),
(@GOSSIP_MENU+1, 5, 2, "剃刀沼泽", 1, 1, 0, 0, 0, 0, "你确定要去 剃刀沼泽吗?"),
(@GOSSIP_MENU+1, 6, 2, "血色修道院", 1, 1, 0, 0, 0, 0, "你确定要去血色修道院吗?"),
(@GOSSIP_MENU+1, 7, 2, "影牙城堡", 1, 1, 0, 0, 0, 0, "你确定要去影牙城堡吗?"),
(@GOSSIP_MENU+1, 8, 2, "哀嚎洞穴", 1, 1, 0, 0, 0, 0, "你确定要去哀嚎洞穴吗?"),
(@GOSSIP_MENU+1, 9, 2, "黑暗深渊", 1, 1, 0, 0, 0, 0, "你确定要去黑暗深渊吗?"),
(@GOSSIP_MENU+1, 10, 2, "黑石深渊", 1, 1, 0, 0, 0, 0, "你确定要去黑石深渊吗?"),
(@GOSSIP_MENU+1, 11, 2, "黑石塔", 1, 1, 0, 0, 0, 0, "你确定要去黑石塔吗?"),
(@GOSSIP_MENU+1, 12, 2, "厄运之槌", 1, 1, 0, 0, 0, 0, "你确定要去厄运之槌吗?"),
(@GOSSIP_MENU+1, 13, 2, "玛拉顿", 1, 1, 0, 0, 0, 0, "你确定要去玛拉顿吗?"),
(@GOSSIP_MENU+1, 14, 2, "通灵学院", 1, 1, 0, 0, 0, 0, "你确定要去通灵学院吗?"),
(@GOSSIP_MENU+1, 15, 2, "斯坦索姆", 1, 1, 0, 0, 0, 0, "你确定要去斯坦索姆吗?"),
(@GOSSIP_MENU+1, 16, 2, "阿塔哈卡神庙", 1, 1, 0, 0, 0, 0, "你确定要去阿塔哈卡神庙吗?"),
(@GOSSIP_MENU+1, 17, 2, "奥达曼", 1, 1, 0, 0, 0, 0, "你确定要去奥达曼吗?"),
(@GOSSIP_MENU+1, 18, 2, "祖尔法拉克", 1, 1, 0, 0, 0, 0, "你确定要去祖尔法拉克吗?"),
(@GOSSIP_MENU+1, 19, 7, "返回..", 1, 1, @GOSSIP_MENU, 0, 0, 0, NULL),
(@GOSSIP_MENU+2, 0, 2, "奥金顿", 1, 1, 0, 0, 0, 0, "你确定要去奥金顿吗?"),
(@GOSSIP_MENU+2, 1, 2, "时光之穴", 1, 1, 0, 0, 0, 0, "你确定要去时光之穴吗?"),
(@GOSSIP_MENU+2, 2, 2, "盘牙洞穴", 1, 1, 0, 0, 0, 0, "你确定要去盘牙洞穴吗?"),
(@GOSSIP_MENU+2, 3, 2, "地狱火堡垒", 1, 1, 0, 0, 0, 0, "你确定要去地狱火堡垒吗?"),
(@GOSSIP_MENU+2, 4, 2, "魔导师平台", 1, 1, 0, 0, 0, 0, "你确定要去魔导师平台吗?"),
(@GOSSIP_MENU+2, 5, 2, "风暴要塞", 1, 1, 0, 0, 0, 0, "你确定要去风暴要塞吗?"),
(@GOSSIP_MENU+2, 6, 7, "返回..", 1, 1, @GOSSIP_MENU, 0, 0, 0, NULL),
(@GOSSIP_MENU+3, 0, 2, "蜘蛛王国", 1, 1, 0, 0, 0, 0, "你确定要去蜘蛛王国吗?"),
(@GOSSIP_MENU+3, 1, 2, "净化斯坦索姆", 1, 1, 0, 0, 0, 0, "你确定要去净化斯坦索姆吗?"),
(@GOSSIP_MENU+3, 2, 2, "勇士的试炼", 1, 1, 0, 0, 0, 0, "你确定要去勇士的试炼吗?"),
(@GOSSIP_MENU+3, 3, 2, "达克萨隆要塞", 1, 1, 0, 0, 0, 0, "你确定要去达克萨隆要塞吗?"),
(@GOSSIP_MENU+3, 4, 2, "古达克", 1, 1, 0, 0, 0, 0, "你确定要去古达克吗?"),
(@GOSSIP_MENU+3, 5, 2, "冰冠城塞", 1, 1, 0, 0, 0, 0, "你确定要去冰冠城塞吗?"),
(@GOSSIP_MENU+3, 6, 2, "魔枢", 1, 1, 0, 0, 0, 0, "你确定要去魔枢吗?"),
(@GOSSIP_MENU+3, 7, 2, "紫罗兰监狱", 1, 1, 0, 0, 0, 0, "你确定要去紫罗兰监狱吗?"),
(@GOSSIP_MENU+3, 8, 2, "闪电大厅", 1, 1, 0, 0, 0, 0, "你确定要去闪电大厅吗?"),
(@GOSSIP_MENU+3, 9, 2, "岩石大厅", 1, 1, 0, 0, 0, 0, "你确定要去岩石大厅吗?"),
(@GOSSIP_MENU+3, 10, 2, "乌特加德城堡", 1, 1, 0, 0, 0, 0, "你确定要去乌特加德城堡吗?"),
(@GOSSIP_MENU+3, 11, 2, "乌特加德之巅", 1, 1, 0, 0, 0, 0, "你确定要去乌特加德之巅吗?"),
(@GOSSIP_MENU+3, 12, 7, "返回..", 1, 1, @GOSSIP_MENU, 0, 0, 0, NULL),
(@GOSSIP_MENU+4, 0, 2, "黑暗神殿", 1, 1, 0, 0, 0, 0, "你确定要去黑暗神殿吗?"),
(@GOSSIP_MENU+4, 1, 2, "黑翼之巢", 1, 1, 0, 0, 0, 0, "你确定要去黑翼之巢吗?"),
(@GOSSIP_MENU+4, 2, 2, "海加尔山", 1, 1, 0, 0, 0, 0, "你确定要去海加尔山吗?"),
(@GOSSIP_MENU+4, 3, 2, "毒蛇神殿", 1, 1, 0, 0, 0, 0, "你确定要去毒蛇神殿吗?"),
(@GOSSIP_MENU+4, 4, 2, "十字军的试炼", 1, 1, 0, 0, 0, 0, "你确定要去十字军的试炼吗?"),
(@GOSSIP_MENU+4, 5, 2, "格鲁尔的巢穴", 1, 1, 0, 0, 0, 0, "你确定要去格鲁尔的巢穴吗?"),
(@GOSSIP_MENU+4, 6, 2, "玛瑟里顿的巢穴", 1, 1, 0, 0, 0, 0, "你确定要去玛瑟里顿的巢穴吗?"),
(@GOSSIP_MENU+4, 7, 2, "冰冠城塞", 1, 1, 0, 0, 0, 0, "你确定要去冰冠城塞吗?"),
(@GOSSIP_MENU+4, 8, 2, "卡拉赞", 1, 1, 0, 0, 0, 0, "你确定要去卡拉赞吗?"),
(@GOSSIP_MENU+4, 9, 2, "熔火之心", 1, 1, 0, 0, 0, 0, "你确定要去熔火之心吗?"),
(@GOSSIP_MENU+4, 10, 2, "纳克萨玛斯", 1, 1, 0, 0, 0, 0, "你确定要去纳克萨玛斯吗?"),
(@GOSSIP_MENU+4, 11, 2, "奥妮克希亚的巢穴", 1, 1, 0, 0, 0, 0, "你确定要去奥妮克希亚的巢穴吗?"),
(@GOSSIP_MENU+4, 12, 2, "安其拉废墟", 1, 1, 0, 0, 0, 0, "你确定要去安其拉废墟吗?"),
(@GOSSIP_MENU+4, 13, 2, "太阳井高地", 1, 1, 0, 0, 0, 0, "你确定要去太阳井高地吗?"),
(@GOSSIP_MENU+4, 14, 2, "风暴之眼", 1, 1, 0, 0, 0, 0, "你确定要去风暴之眼吗?"),
(@GOSSIP_MENU+4, 15, 2, "安其拉神殿", 1, 1, 0, 0, 0, 0, "你确定要去安其拉神殿吗?"),
(@GOSSIP_MENU+4, 16, 2, "永恒之眼", 1, 1, 0, 0, 0, 0, "你确定要去永恒之眼吗?"),
(@GOSSIP_MENU+4, 17, 2, "黑耀石神殿", 1, 1, 0, 0, 0, 0, "你确定要去黑耀石神殿吗?"),
(@GOSSIP_MENU+4, 18, 2, "奥杜尔", 1, 1, 0, 0, 0, 0, "你确定要去奥杜尔吗?"),
(@GOSSIP_MENU+4, 19, 2, "阿尔卡冯的宝库", 1, 1, 0, 0, 0, 0, "你确定要去阿尔卡冯的宝库吗?"),
(@GOSSIP_MENU+4, 21, 2, "祖尔格拉布", 1, 1, 0, 0, 0, 0, "你确定要去祖尔格拉布吗?"),
(@GOSSIP_MENU+4, 22, 2, "祖阿曼", 1, 1, 0, 0, 0, 0, "你确定要去祖阿曼吗?"),
(@GOSSIP_MENU+4, 23, 7, "返回..", 1, 1, @GOSSIP_MENU, 0, 0, 0, NULL),
(@GOSSIP_MENU+5, 0, 2, "艾尔文森林", 1, 1, 0, 0, 0, 0, "你确定要去艾尔文森林吗?"),
(@GOSSIP_MENU+5, 1, 2, "永歌森林", 1, 1, 0, 0, 0, 0, "你确定要去永歌森林吗?"),
(@GOSSIP_MENU+5, 2, 2, "丹莫罗", 1, 1, 0, 0, 0, 0, "你确定要去丹莫罗吗?"),
(@GOSSIP_MENU+5, 3, 2, "特瑞斯法林地", 1, 1, 0, 0, 0, 0, "你确定要去特瑞斯法林地吗?"),
(@GOSSIP_MENU+5, 4, 2, "幽魂之地", 1, 1, 0, 0, 0, 0, "你确定要去幽魂之地吗?"),
(@GOSSIP_MENU+5, 5, 2, "洛克莫丹", 1, 1, 0, 0, 0, 0, "你确定要去洛克莫丹吗?"),
(@GOSSIP_MENU+5, 6, 2, "银松森林", 1, 1, 0, 0, 0, 0, "你确定要去银松森林吗?"),
(@GOSSIP_MENU+5, 7, 2, "西部荒野", 1, 1, 0, 0, 0, 0, "你确定要去西部荒野吗?"),
(@GOSSIP_MENU+5, 8, 2, "赤脊山", 1, 1, 0, 0, 0, 0, "你确定要去赤脊山吗?"),
(@GOSSIP_MENU+5, 9, 2, "暮色森林", 1, 1, 0, 0, 0, 0, "你确定要去暮色森林吗?"),
(@GOSSIP_MENU+5, 10, 2, "希尔斯布莱德丘陵", 1, 1, 0, 0, 0, 0, "你确定要去希尔斯布莱德丘陵吗?"),
(@GOSSIP_MENU+5, 11, 2, "湿地", 1, 1, 0, 0, 0, 0, "你确定要去湿地吗?"),
(@GOSSIP_MENU+5, 12, 2, "奥特兰克山脉", 1, 1, 0, 0, 0, 0, "你确定要去奥特兰克山脉吗?"),
(@GOSSIP_MENU+5, 13, 2, "阿拉希高地", 1, 1, 0, 0, 0, 0, "你确定要去阿拉希高地吗?"),
(@GOSSIP_MENU+5, 14, 2, "荆棘谷", 1, 1, 0, 0, 0, 0, "你确定要去荆棘谷吗?"),
(@GOSSIP_MENU+5, 15, 2, "荒芜之地", 1, 1, 0, 0, 0, 0, "你确定要去荒芜之地吗?"),
(@GOSSIP_MENU+5, 16, 2, "悲伤沼泽", 1, 1, 0, 0, 0, 0, "你确定要去悲伤沼泽吗?"),
(@GOSSIP_MENU+5, 17, 2, "辛特兰", 1, 1, 0, 0, 0, 0, "你确定要去辛特兰吗?"),
(@GOSSIP_MENU+5, 18, 2, "灼热峡谷", 1, 1, 0, 0, 0, 0, "你确定要去灼热峡谷吗?"),
(@GOSSIP_MENU+5, 19, 2, "诅咒之地", 1, 1, 0, 0, 0, 0, "你确定要去诅咒之地吗?"),
(@GOSSIP_MENU+5, 20, 2, "燃烧平原", 1, 1, 0, 0, 0, 0, "你确定要去燃烧平原吗?"),
(@GOSSIP_MENU+5, 21, 2, "西瘟疫之地", 1, 1, 0, 0, 0, 0, "你确定要去西瘟疫之地吗?"),
(@GOSSIP_MENU+5, 22, 2, "东瘟疫之地", 1, 1, 0, 0, 0, 0, "你确定要去东瘟疫之地吗?"),
(@GOSSIP_MENU+5, 23, 2, "奎尔丹纳斯岛", 1, 1, 0, 0, 0, 0, "你确定要去奎尔丹纳斯岛吗?"),
(@GOSSIP_MENU+5, 24, 7, "返回..", 1, 1, @GOSSIP_MENU, 0, 0, 0, NULL),
(@GOSSIP_MENU+6, 0, 2, "秘蓝岛", 1, 1, 0, 0, 0, 0, "你确定要去秘蓝岛吗?"),
(@GOSSIP_MENU+6, 1, 2, "泰达希尔", 1, 1, 0, 0, 0, 0, "你确定要去泰达希尔吗?"),
(@GOSSIP_MENU+6, 2, 2, "杜隆塔尔", 1, 1, 0, 0, 0, 0, "你确定要去杜隆塔尔吗?"),
(@GOSSIP_MENU+6, 3, 2, "莫高雷", 1, 1, 0, 0, 0, 0, "你确定要去莫高雷吗?"),
(@GOSSIP_MENU+6, 4, 2, "血雾岛", 1, 1, 0, 0, 0, 0, "你确定要去血雾岛吗?"),
(@GOSSIP_MENU+6, 5, 2, "黑海岸", 1, 1, 0, 0, 0, 0, "你确定要去黑海岸吗?"),
(@GOSSIP_MENU+6, 6, 2, "贫瘠之地", 1, 1, 0, 0, 0, 0, "你确定要去贫瘠之地吗?"),
(@GOSSIP_MENU+6, 7, 2, "石爪山脉", 1, 1, 0, 0, 0, 0, "你确定要去石爪山脉吗?"),
(@GOSSIP_MENU+6, 8, 2, "灰谷森林", 1, 1, 0, 0, 0, 0, "你确定要去灰谷森林吗?"),
(@GOSSIP_MENU+6, 9, 2, "千针石林", 1, 1, 0, 0, 0, 0, "你确定要去千针石林吗?"),
(@GOSSIP_MENU+6, 10, 2, "凄凉之地", 1, 1, 0, 0, 0, 0, "你确定要去凄凉之地吗?"),
(@GOSSIP_MENU+6, 11, 2, "尘泥沼泽", 1, 1, 0, 0, 0, 0, "你确定要去尘泥沼泽吗?"),
(@GOSSIP_MENU+6, 12, 2, "菲拉斯", 1, 1, 0, 0, 0, 0, "你确定要去菲拉斯吗?"),
(@GOSSIP_MENU+6, 13, 2, "塔纳利斯沙漠", 1, 1, 0, 0, 0, 0, "你确定要去塔纳利斯沙漠吗?"),
(@GOSSIP_MENU+6, 14, 2, "艾萨拉", 1, 1, 0, 0, 0, 0, "你确定要去艾萨拉吗?"),
(@GOSSIP_MENU+6, 15, 2, "费伍德森林", 1, 1, 0, 0, 0, 0, "你确定要去费伍德森林吗?"),
(@GOSSIP_MENU+6, 16, 2, "安戈洛环形山", 1, 1, 0, 0, 0, 0, "你确定要去安戈洛环形山吗?"),
(@GOSSIP_MENU+6, 17, 2, "希利苏斯", 1, 1, 0, 0, 0, 0, "你确定要去希利苏斯吗?"),
(@GOSSIP_MENU+6, 18, 2, "冬泉谷", 1, 1, 0, 0, 0, 0, "你确定要去冬泉谷吗?"),
(@GOSSIP_MENU+6, 19, 7, "返回..", 1, 1, @GOSSIP_MENU, 0, 0, 0, NULL),
(@GOSSIP_MENU+7, 0, 2, "地狱火半岛", 1, 1, 0, 0, 0, 0, "你确定要去地狱火半岛吗?"),
(@GOSSIP_MENU+7, 1, 2, "赞加沼泽", 1, 1, 0, 0, 0, 0, "你确定要去赞加沼泽吗?"),
(@GOSSIP_MENU+7, 2, 2, "泰罗卡森林", 1, 1, 0, 0, 0, 0, "你确定要去泰罗卡森林吗?"),
(@GOSSIP_MENU+7, 3, 2, "纳格兰", 1, 1, 0, 0, 0, 0, "你确定要去纳格兰吗?"),
(@GOSSIP_MENU+7, 4, 2, "刀锋山", 1, 1, 0, 0, 0, 0, "你确定要去刀锋山吗?"),
(@GOSSIP_MENU+7, 5, 2, "虚空风暴", 1, 1, 0, 0, 0, 0, "你确定要去虚空风暴吗?"),
(@GOSSIP_MENU+7, 6, 2, "影月谷", 1, 1, 0, 0, 0, 0, "你确定要去影月谷吗?"),
(@GOSSIP_MENU+7, 7, 7, "返回..", 1, 1, @GOSSIP_MENU, 0, 0, 0, NULL),
(@GOSSIP_MENU+8, 0, 2, "北风苔原", 1, 1, 0, 0, 0, 0, "你确定要去北风苔原吗?"),
(@GOSSIP_MENU+8, 1, 2, "嚎风峡湾", 1, 1, 0, 0, 0, 0, "你确定要去嚎风峡湾吗?"),
(@GOSSIP_MENU+8, 2, 2, "龙骨荒野", 1, 1, 0, 0, 0, 0, "你确定要去龙骨荒野吗?"),
(@GOSSIP_MENU+8, 3, 2, "灰熊丘陵", 1, 1, 0, 0, 0, 0, "你确定要去灰熊丘陵吗?"),
(@GOSSIP_MENU+8, 4, 2, "祖尔德拉克", 1, 1, 0, 0, 0, 0, "你确定要去祖尔德拉克吗?"),
(@GOSSIP_MENU+8, 5, 2, "索拉查盆地", 1, 1, 0, 0, 0, 0, "你确定要去索拉查盆地吗?"),
(@GOSSIP_MENU+8, 6, 2, "晶歌森林", 1, 1, 0, 0, 0, 0, "你确定要去晶歌森林吗?"),
(@GOSSIP_MENU+8, 7, 2, "风暴之巅", 1, 1, 0, 0, 0, 0, "你确定要去风暴之巅吗?"),
(@GOSSIP_MENU+8, 8, 2, "冰冠城塞", 1, 1, 0, 0, 0, 0, "你确定要去冰冠城塞吗?"),
(@GOSSIP_MENU+8, 9, 2, "冬拥湖", 1, 1, 0, 0, 0, 0, "你确定要去冬拥湖吗?"),
(@GOSSIP_MENU+8, 10, 7, "返回..", 1, 1, @GOSSIP_MENU, 0, 0, 0, NULL);

-- Teleport scripts:



INSERT INTO smart_scripts (entryorguid, source_type, id, link, event_type, event_phase_mask, event_chance, event_flags, event_param1, event_param2, event_param3, event_param4, action_type, action_param1, action_param2, action_param3, action_param4, action_param5, action_param6, target_type, target_param1, target_param2, target_param3, target_x, target_y, target_z, target_o, comment) VALUES
(@ENTRY, 0, 1, 0, 62, 0, 100, 0, @GOSSIP_MENU, 1, 0, 0, 62, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, -8842.09, 626.358, 94.0867, 3.61363, "Teleporter script"),
(@ENTRY, 0, 2, 0, 62, 0, 100, 0, @GOSSIP_MENU, 2, 0, 0, 62, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 1601.08, -4378.69, 9.9846, 2.14362, "Teleporter script"),
(@ENTRY, 0, 3, 0, 62, 0, 100, 0, @GOSSIP_MENU, 11, 0, 0, 62, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, -14281.9, 552.564, 8.90422, 0.860144, "Teleporter script"),
(@ENTRY, 0, 4, 0, 62, 0, 100, 0, @GOSSIP_MENU, 10, 0, 0, 62, 530, 0, 0, 0, 0, 0, 7, 0, 0, 0, -1887.62, 5359.09, -12.4279, 4.40435, "Teleporter script"),
(@ENTRY, 0, 5, 0, 62, 0, 100, 0, @GOSSIP_MENU, 9, 0, 0, 62, 571, 0, 0, 0, 0, 0, 7, 0, 0, 0, 5809.55, 503.975, 657.526, 2.38338, "Teleporter script"),
(@ENTRY, 0, 6, 0, 62, 0, 100, 0, @GOSSIP_MENU, 12, 0, 0, 62, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, -13181.8, 339.356, 42.9805, 1.18013, "Teleporter script"),
(@ENTRY, 0, 7, 0, 62, 0, 100, 0, @GOSSIP_MENU, 3, 0, 0, 62, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 9869.91, 2493.58, 1315.88, 2.78897, "Teleporter script"),
(@ENTRY, 0, 8, 0, 62, 0, 100, 0, @GOSSIP_MENU, 4, 0, 0, 62, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, -4900.47, -962.585, 501.455, 5.40538, "Teleporter script"),
(@ENTRY, 0, 9, 0, 62, 0, 100, 0, @GOSSIP_MENU, 5, 0, 0, 62, 530, 0, 0, 0, 0, 0, 7, 0, 0, 0, -3864.92, -11643.7, -137.644, 5.50862, "Teleporter script"),
(@ENTRY, 0, 10, 0, 62, 0, 100, 0, @GOSSIP_MENU, 6, 0, 0, 62, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, -1274.45, 71.8601, 128.159, 2.80623, "Teleporter script"),
(@ENTRY, 0, 11, 0, 62, 0, 100, 0, @GOSSIP_MENU, 7, 0, 0, 62, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 1633.75, 240.167, -43.1034, 6.26128, "Teleporter script"),
(@ENTRY, 0, 12, 0, 62, 0, 100, 0, @GOSSIP_MENU, 8, 0, 0, 62, 530, 0, 0, 0, 0, 0, 7, 0, 0, 0, 9738.28, -7454.19, 13.5605, 0.043914, "Teleporter script"),
(@ENTRY, 0, 13, 0, 62, 0, 100, 0, @GOSSIP_MENU+1, 0, 0, 0, 62, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, -5163.54, 925.423, 257.181, 1.57423, "Teleporter script"),
(@ENTRY, 0, 14, 0, 62, 0, 100, 0, @GOSSIP_MENU+1, 1, 0, 0, 62, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, -11209.6, 1666.54, 24.6974, 1.42053, "Teleporter script"),
(@ENTRY, 0, 15, 0, 62, 0, 100, 0, @GOSSIP_MENU+1, 2, 0, 0, 62, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, -8799.15, 832.718, 97.6348, 6.04085, "Teleporter script"),
(@ENTRY, 0, 16, 0, 62, 0, 100, 0, @GOSSIP_MENU+1, 3, 0, 0, 62, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 1811.78, -4410.5, -18.4704, 5.20165, "Teleporter script"),
(@ENTRY, 0, 17, 0, 62, 0, 100, 0, @GOSSIP_MENU+1, 4, 0, 0, 62, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, -4657.3, -2519.35, 81.0529, 4.54808, "Teleporter script"),
(@ENTRY, 0, 18, 0, 62, 0, 100, 0, @GOSSIP_MENU+1, 5, 0, 0, 62, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, -4470.28, -1677.77, 81.3925, 1.16302, "Teleporter script"),
(@ENTRY, 0, 19, 0, 62, 0, 100, 0, @GOSSIP_MENU+1, 6, 0, 0, 62, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 2873.15, -764.523, 160.332, 5.10447, "Teleporter script"),
(@ENTRY, 0, 20, 0, 62, 0, 100, 0, @GOSSIP_MENU+1, 7, 0, 0, 62, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, -234.675, 1561.63, 76.8921, 1.24031, "Teleporter script"),
(@ENTRY, 0, 21, 0, 62, 0, 100, 0, @GOSSIP_MENU+1, 8, 0, 0, 62, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, -731.607, -2218.39, 17.0281, 2.78486, "Teleporter script"),
(@ENTRY, 0, 22, 0, 62, 0, 100, 0, @GOSSIP_MENU+1, 9, 0, 0, 62, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 4249.99, 740.102, -25.671, 1.34062, "Teleporter script"),
(@ENTRY, 0, 23, 0, 62, 0, 100, 0, @GOSSIP_MENU+1, 10, 0, 0, 62, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, -7179.34, -921.212, 165.821, 5.09599, "Teleporter script"),
(@ENTRY, 0, 24, 0, 62, 0, 100, 0, @GOSSIP_MENU+1, 11, 0, 0, 62, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, -7527.05, -1226.77, 285.732, 5.29626, "Teleporter script"),
(@ENTRY, 0, 25, 0, 62, 0, 100, 0, @GOSSIP_MENU+1, 12, 0, 0, 62, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, -3520.14, 1119.38, 161.025, 4.70454, "Teleporter script"),
(@ENTRY, 0, 26, 0, 62, 0, 100, 0, @GOSSIP_MENU+1, 13, 0, 0, 62, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, -1421.42, 2907.83, 137.415, 1.70718, "Teleporter script"),
(@ENTRY, 0, 27, 0, 62, 0, 100, 0, @GOSSIP_MENU+1, 14, 0, 0, 62, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 1269.64, -2556.21, 93.6088, 0.620623, "Teleporter script"),
(@ENTRY, 0, 28, 0, 62, 0, 100, 0, @GOSSIP_MENU+1, 15, 0, 0, 62, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 3352.92, -3379.03, 144.782, 6.25978, "Teleporter script"),
(@ENTRY, 0, 29, 0, 62, 0, 100, 0, @GOSSIP_MENU+1, 16, 0, 0, 62, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, -10177.9, -3994.9, -111.239, 6.01885, "Teleporter script"),
(@ENTRY, 0, 30, 0, 62, 0, 100, 0, @GOSSIP_MENU+1, 17, 0, 0, 62, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, -6071.37, -2955.16, 209.782, 0.015708, "Teleporter script"),
(@ENTRY, 0, 31, 0, 62, 0, 100, 0, @GOSSIP_MENU+1, 18, 0, 0, 62, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, -6801.19, -2893.02, 9.00388, 0.158639, "Teleporter script"),
(@ENTRY, 0, 32, 0, 62, 0, 100, 0, @GOSSIP_MENU+2, 0, 0, 0, 62, 530, 0, 0, 0, 0, 0, 7, 0, 0, 0, -3324.49, 4943.45, -101.239, 4.63901, "Teleporter script"),
(@ENTRY, 0, 33, 0, 62, 0, 100, 0, @GOSSIP_MENU+2, 1, 0, 0, 62, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, -8369.65, -4253.11, -204.272, -2.70526, "Teleporter script"),
(@ENTRY, 0, 34, 0, 62, 0, 100, 0, @GOSSIP_MENU+2, 2, 0, 0, 62, 530, 0, 0, 0, 0, 0, 7, 0, 0, 0, 738.865, 6865.77, -69.4659, 6.27655, "Teleporter script"),
(@ENTRY, 0, 35, 0, 62, 0, 100, 0, @GOSSIP_MENU+2, 3, 0, 0, 62, 530, 0, 0, 0, 0, 0, 7, 0, 0, 0, -347.29, 3089.82, 21.394, 5.68114, "Teleporter script"),
(@ENTRY, 0, 36, 0, 62, 0, 100, 0, @GOSSIP_MENU+2, 4, 0, 0, 62, 530, 0, 0, 0, 0, 0, 7, 0, 0, 0, 12884.6, -7317.69, 65.5023, 4.799, "Teleporter script"),
(@ENTRY, 0, 37, 0, 62, 0, 100, 0, @GOSSIP_MENU+2, 5, 0, 0, 62, 530, 0, 0, 0, 0, 0, 7, 0, 0, 0, 3100.48, 1536.49, 190.3, 4.62226, "Teleporter script"),
(@ENTRY, 0, 38, 0, 62, 0, 100, 0, @GOSSIP_MENU+3, 0, 0, 0, 62, 571, 0, 0, 0, 0, 0, 7, 0, 0, 0, 3707.86, 2150.23, 36.76, 3.22, "Teleporter script"),
(@ENTRY, 0, 39, 0, 62, 0, 100, 0, @GOSSIP_MENU+3, 1, 0, 0, 62, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, -8756.39, -4440.68, -199.489, 4.66289, "Teleporter script"),
(@ENTRY, 0, 40, 0, 62, 0, 100, 0, @GOSSIP_MENU+3, 2, 0, 0, 62, 571, 0, 0, 0, 0, 0, 7, 0, 0, 0, 8590.95, 791.792, 558.235, 3.13127, "Teleporter script"),
(@ENTRY, 0, 41, 0, 62, 0, 100, 0, @GOSSIP_MENU+3, 3, 0, 0, 62, 571, 0, 0, 0, 0, 0, 7, 0, 0, 0, 4765.59, -2038.24, 229.363, 0.887627, "Teleporter script"),
(@ENTRY, 0, 42, 0, 62, 0, 100, 0, @GOSSIP_MENU+3, 4, 0, 0, 62, 571, 0, 0, 0, 0, 0, 7, 0, 0, 0, 6722.44, -4640.67, 450.632, 3.91123, "Teleporter script"),
(@ENTRY, 0, 43, 0, 62, 0, 100, 0, @GOSSIP_MENU+3, 5, 0, 0, 62, 571, 0, 0, 0, 0, 0, 7, 0, 0, 0, 5643.16, 2028.81, 798.274, 4.60242, "Teleporter script"),
(@ENTRY, 0, 44, 0, 62, 0, 100, 0, @GOSSIP_MENU+3, 6, 0, 0, 62, 571, 0, 0, 0, 0, 0, 7, 0, 0, 0, 3782.89, 6965.23, 105.088, 6.14194, "Teleporter script"),
(@ENTRY, 0, 45, 0, 62, 0, 100, 0, @GOSSIP_MENU+3, 7, 0, 0, 62, 571, 0, 0, 0, 0, 0, 7, 0, 0, 0, 5693.08, 502.588, 652.672, 4.0229, "Teleporter script"),
(@ENTRY, 0, 46, 0, 62, 0, 100, 0, @GOSSIP_MENU+3, 8, 0, 0, 62, 571, 0, 0, 0, 0, 0, 7, 0, 0, 0, 9136.52, -1311.81, 1066.29, 5.19113, "Teleporter script"),
(@ENTRY, 0, 47, 0, 62, 0, 100, 0, @GOSSIP_MENU+3, 9, 0, 0, 62, 571, 0, 0, 0, 0, 0, 7, 0, 0, 0, 8922.12, -1009.16, 1039.56, 1.57044, "Teleporter script"),
(@ENTRY, 0, 48, 0, 62, 0, 100, 0, @GOSSIP_MENU+3, 10, 0, 0, 62, 571, 0, 0, 0, 0, 0, 7, 0, 0, 0, 1203.41, -4868.59, 41.2486, 0.283237, "Teleporter script"),
(@ENTRY, 0, 49, 0, 62, 0, 100, 0, @GOSSIP_MENU+3, 11, 0, 0, 62, 571, 0, 0, 0, 0, 0, 7, 0, 0, 0, 1267.24, -4857.3, 215.764, 3.22768, "Teleporter script"),
(@ENTRY, 0, 50, 0, 62, 0, 100, 0, @GOSSIP_MENU+4, 0, 0, 0, 62, 530, 0, 0, 0, 0, 0, 7, 0, 0, 0, -3649.92, 317.469, 35.2827, 2.94285, "Teleporter script"),
(@ENTRY, 0, 51, 0, 62, 0, 100, 0, @GOSSIP_MENU+4, 1, 0, 0, 62, 229, 0, 0, 0, 0, 0, 7, 0, 0, 0, 152.451, -474.881, 116.84, 0.001073, "Teleporter script"),
(@ENTRY, 0, 52, 0, 62, 0, 100, 0, @GOSSIP_MENU+4, 2, 0, 0, 62, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, -8177.89, -4181.23, -167.552, 0.913338, "Teleporter script"),
(@ENTRY, 0, 53, 0, 62, 0, 100, 0, @GOSSIP_MENU+4, 3, 0, 0, 62, 530, 0, 0, 0, 0, 0, 7, 0, 0, 0, 797.855, 6865.77, -65.4165, 0.005938, "Teleporter script"),
(@ENTRY, 0, 54, 0, 62, 0, 100, 0, @GOSSIP_MENU+4, 4, 0, 0, 62, 571, 0, 0, 0, 0, 0, 7, 0, 0, 0, 8515.61, 714.153, 558.248, 1.57753, "Teleporter script"),
(@ENTRY, 0, 55, 0, 62, 0, 100, 0, @GOSSIP_MENU+4, 5, 0, 0, 62, 530, 0, 0, 0, 0, 0, 7, 0, 0, 0, 3530.06, 5104.08, 3.50861, 5.51117, "Teleporter script"),
(@ENTRY, 0, 56, 0, 62, 0, 100, 0, @GOSSIP_MENU+4, 6, 0, 0, 62, 530, 0, 0, 0, 0, 0, 7, 0, 0, 0, -336.411, 3130.46, -102.928, 5.20322, "Teleporter script"),
(@ENTRY, 0, 57, 0, 62, 0, 100, 0, @GOSSIP_MENU+4, 7, 0, 0, 62, 571, 0, 0, 0, 0, 0, 7, 0, 0, 0, 5855.22, 2102.03, 635.991, 3.57899, "Teleporter script"),
(@ENTRY, 0, 58, 0, 62, 0, 100, 0, @GOSSIP_MENU+4, 8, 0, 0, 62, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, -11118.9, -2010.33, 47.0819, 0.649895, "Teleporter script"),
(@ENTRY, 0, 59, 0, 62, 0, 100, 0, @GOSSIP_MENU+4, 9, 0, 0, 62, 230, 0, 0, 0, 0, 0, 7, 0, 0, 0, 1126.64, -459.94, -102.535, 3.46095, "Teleporter script"),
(@ENTRY, 0, 60, 0, 62, 0, 100, 0, @GOSSIP_MENU+4, 10, 0, 0, 62, 571, 0, 0, 0, 0, 0, 7, 0, 0, 0, 3668.72, -1262.46, 243.622, 4.785, "Teleporter script"),
(@ENTRY, 0, 61, 0, 62, 0, 100, 0, @GOSSIP_MENU+4, 11, 0, 0, 62, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, -4708.27, -3727.64, 54.5589, 3.72786, "Teleporter script"),
(@ENTRY, 0, 62, 0, 62, 0, 100, 0, @GOSSIP_MENU+4, 12, 0, 0, 62, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, -8409.82, 1499.06, 27.7179, 2.51868, "Teleporter script"),
(@ENTRY, 0, 63, 0, 62, 0, 100, 0, @GOSSIP_MENU+4, 13, 0, 0, 62, 530, 0, 0, 0, 0, 0, 7, 0, 0, 0, 12574.1, -6774.81, 15.0904, 3.13788, "Teleporter script"),
(@ENTRY, 0, 64, 0, 62, 0, 100, 0, @GOSSIP_MENU+4, 14, 0, 0, 62, 530, 0, 0, 0, 0, 0, 7, 0, 0, 0, 3088.49, 1381.57, 184.863, 4.61973, "Teleporter script"),
(@ENTRY, 0, 65, 0, 62, 0, 100, 0, @GOSSIP_MENU+4, 15, 0, 0, 62, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, -8240.09, 1991.32, 129.072, 0.941603, "Teleporter script"),
(@ENTRY, 0, 66, 0, 62, 0, 100, 0, @GOSSIP_MENU+4, 16, 0, 0, 62, 571, 0, 0, 0, 0, 0, 7, 0, 0, 0, 3784.17, 7028.84, 161.258, 5.79993, "Teleporter script"),
(@ENTRY, 0, 67, 0, 62, 0, 100, 0, @GOSSIP_MENU+4, 17, 0, 0, 62, 571, 0, 0, 0, 0, 0, 7, 0, 0, 0, 3472.43, 264.923, -120.146, 3.27923, "Teleporter script"),
(@ENTRY, 0, 68, 0, 62, 0, 100, 0, @GOSSIP_MENU+4, 18, 0, 0, 62, 571, 0, 0, 0, 0, 0, 7, 0, 0, 0, 9222.88, -1113.59, 1216.12, 6.27549, "Teleporter script"),
(@ENTRY, 0, 69, 0, 62, 0, 100, 0, @GOSSIP_MENU+4, 19, 0, 0, 62, 571, 0, 0, 0, 0, 0, 7, 0, 0, 0, 5453.72, 2840.79, 421.28, 0, "Teleporter script"),
(@ENTRY, 0, 70, 0, 62, 0, 100, 0, @GOSSIP_MENU+4, 21, 0, 0, 62, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, -11916.7, -1215.72, 92.289, 4.72454, "Teleporter script"),
(@ENTRY, 0, 71, 0, 62, 0, 100, 0, @GOSSIP_MENU+4, 22, 0, 0, 62, 530, 0, 0, 0, 0, 0, 7, 0, 0, 0, 6851.78, -7972.57, 179.242, 4.64691, "Teleporter script"),
(@ENTRY, 0, 72, 0, 62, 0, 100, 0, @GOSSIP_MENU+5, 0, 0, 0, 62, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, -9449.06, 64.8392, 56.3581, 3.07047, "Teleporter script"),
(@ENTRY, 0, 73, 0, 62, 0, 100, 0, @GOSSIP_MENU+5, 1, 0, 0, 62, 530, 0, 0, 0, 0, 0, 7, 0, 0, 0, 9024.37, -6682.55, 16.8973, 3.14131, "Teleporter script"),
(@ENTRY, 0, 74, 0, 62, 0, 100, 0, @GOSSIP_MENU+5, 2, 0, 0, 62, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, -5603.76, -482.704, 396.98, 5.23499, "Teleporter script"),
(@ENTRY, 0, 75, 0, 62, 0, 100, 0, @GOSSIP_MENU+5, 3, 0, 0, 62, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 2274.95, 323.918, 34.1137, 4.24367, "Teleporter script"),
(@ENTRY, 0, 76, 0, 62, 0, 100, 0, @GOSSIP_MENU+5, 4, 0, 0, 62, 530, 0, 0, 0, 0, 0, 7, 0, 0, 0, 7595.73, -6819.6, 84.3718, 2.56561, "Teleporter script"),
(@ENTRY, 0, 77, 0, 62, 0, 100, 0, @GOSSIP_MENU+5, 5, 0, 0, 62, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, -5405.85, -2894.15, 341.972, 5.48238, "Teleporter script"),
(@ENTRY, 0, 78, 0, 62, 0, 100, 0, @GOSSIP_MENU+5, 6, 0, 0, 62, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 505.126, 1504.63, 124.808, 1.77987, "Teleporter script"),
(@ENTRY, 0, 79, 0, 62, 0, 100, 0, @GOSSIP_MENU+5, 7, 0, 0, 62, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, -10684.9, 1033.63, 32.5389, 6.07384, "Teleporter script"),
(@ENTRY, 0, 80, 0, 62, 0, 100, 0, @GOSSIP_MENU+5, 8, 0, 0, 62, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, -9447.8, -2270.85, 71.8224, 0.283853, "Teleporter script"),
(@ENTRY, 0, 81, 0, 62, 0, 100, 0, @GOSSIP_MENU+5, 9, 0, 0, 62, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, -10531.7, -1281.91, 38.8647, 1.56959, "Teleporter script"),
(@ENTRY, 0, 82, 0, 62, 0, 100, 0, @GOSSIP_MENU+5, 10, 0, 0, 62, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, -385.805, -787.954, 54.6655, 1.03926, "Teleporter script"),
(@ENTRY, 0, 83, 0, 62, 0, 100, 0, @GOSSIP_MENU+5, 11, 0, 0, 62, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, -3517.75, -913.401, 8.86625, 2.60705, "Teleporter script"),
(@ENTRY, 0, 84, 0, 62, 0, 100, 0, @GOSSIP_MENU+5, 12, 0, 0, 62, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 275.049, -652.044, 130.296, 0.502032, "Teleporter script"),
(@ENTRY, 0, 85, 0, 62, 0, 100, 0, @GOSSIP_MENU+5, 13, 0, 0, 62, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, -1581.45, -2704.06, 35.4168, 0.490373, "Teleporter script"),
(@ENTRY, 0, 86, 0, 62, 0, 100, 0, @GOSSIP_MENU+5, 14, 0, 0, 62, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, -11921.7, -59.544, 39.7262, 3.73574, "Teleporter script"),
(@ENTRY, 0, 87, 0, 62, 0, 100, 0, @GOSSIP_MENU+5, 15, 0, 0, 62, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, -6782.56, -3128.14, 240.48, 5.65912, "Teleporter script"),
(@ENTRY, 0, 88, 0, 62, 0, 100, 0, @GOSSIP_MENU+5, 16, 0, 0, 62, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, -10368.6, -2731.3, 21.6537, 5.29238, "Teleporter script"),
(@ENTRY, 0, 89, 0, 62, 0, 100, 0, @GOSSIP_MENU+5, 17, 0, 0, 62, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 112.406, -3929.74, 136.358, 0.981903, "Teleporter script"),
(@ENTRY, 0, 90, 0, 62, 0, 100, 0, @GOSSIP_MENU+5, 18, 0, 0, 62, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, -6686.33, -1198.55, 240.027, 0.916887, "Teleporter script"),
(@ENTRY, 0, 91, 0, 62, 0, 100, 0, @GOSSIP_MENU+5, 19, 0, 0, 62, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, -11184.7, -3019.31, 7.29238, 3.20542, "Teleporter script"),
(@ENTRY, 0, 92, 0, 62, 0, 100, 0, @GOSSIP_MENU+5, 20, 0, 0, 62, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, -7979.78, -2105.72, 127.919, 5.10148, "Teleporter script"),
(@ENTRY, 0, 93, 0, 62, 0, 100, 0, @GOSSIP_MENU+5, 21, 0, 0, 62, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 1743.69, -1723.86, 59.6648, 5.23722, "Teleporter script"),
(@ENTRY, 0, 94, 0, 62, 0, 100, 0, @GOSSIP_MENU+5, 22, 0, 0, 62, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 2280.64, -5275.05, 82.0166, 4.7479, "Teleporter script"),
(@ENTRY, 0, 95, 0, 62, 0, 100, 0, @GOSSIP_MENU+5, 23, 0, 0, 62, 530, 0, 0, 0, 0, 0, 7, 0, 0, 0, 12806.5, -6911.11, 41.1156, 2.22935, "Teleporter script"),
(@ENTRY, 0, 96, 0, 62, 0, 100, 0, @GOSSIP_MENU+6, 0, 0, 0, 62, 530, 0, 0, 0, 0, 0, 7, 0, 0, 0, -4192.62, -12576.7, 36.7598, 1.62813, "Teleporter script"),
(@ENTRY, 0, 97, 0, 62, 0, 100, 0, @GOSSIP_MENU+6, 1, 0, 0, 62, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 9889.03, 915.869, 1307.43, 1.9336, "Teleporter script"),
(@ENTRY, 0, 98, 0, 62, 0, 100, 0, @GOSSIP_MENU+6, 2, 0, 0, 62, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 228.978, -4741.87, 10.1027, 0.416883, "Teleporter script"),
(@ENTRY, 0, 99, 0, 62, 0, 100, 0, @GOSSIP_MENU+6, 3, 0, 0, 62, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, -2473.87, -501.225, -9.42465, 0.6525, "Teleporter script"),
(@ENTRY, 0, 100, 0, 62, 0, 100, 0, @GOSSIP_MENU+6, 4, 0, 0, 62, 530, 0, 0, 0, 0, 0, 7, 0, 0, 0, -2095.7, -11841.1, 51.1557, 6.19288, "Teleporter script"),
(@ENTRY, 0, 101, 0, 62, 0, 100, 0, @GOSSIP_MENU+6, 5, 0, 0, 62, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 6463.25, 683.986, 8.92792, 4.33534, "Teleporter script"),
(@ENTRY, 0, 102, 0, 62, 0, 100, 0, @GOSSIP_MENU+6, 6, 0, 0, 62, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, -575.772, -2652.45, 95.6384, 0.006469, "Teleporter script"),
(@ENTRY, 0, 103, 0, 62, 0, 100, 0, @GOSSIP_MENU+6, 7, 0, 0, 62, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 1574.89, 1031.57, 137.442, 3.8013, "Teleporter script"),
(@ENTRY, 0, 104, 0, 62, 0, 100, 0, @GOSSIP_MENU+6, 8, 0, 0, 62, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 1919.77, -2169.68, 94.6729, 6.14177, "Teleporter script"),
(@ENTRY, 0, 105, 0, 62, 0, 100, 0, @GOSSIP_MENU+6, 9, 0, 0, 62, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, -5375.53, -2509.2, -40.432, 2.41885, "Teleporter script"),
(@ENTRY, 0, 106, 0, 62, 0, 100, 0, @GOSSIP_MENU+6, 10, 0, 0, 62, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, -656.056, 1510.12, 88.3746, 3.29553, "Teleporter script"),
(@ENTRY, 0, 107, 0, 62, 0, 100, 0, @GOSSIP_MENU+6, 11, 0, 0, 62, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, -3350.12, -3064.85, 33.0364, 5.12666, "Teleporter script"),
(@ENTRY, 0, 108, 0, 62, 0, 100, 0, @GOSSIP_MENU+6, 12, 0, 0, 62, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, -4808.31, 1040.51, 103.769, 2.90655, "Teleporter script"),
(@ENTRY, 0, 109, 0, 62, 0, 100, 0, @GOSSIP_MENU+6, 13, 0, 0, 62, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, -6940.91, -3725.7, 48.9381, 3.11174, "Teleporter script"),
(@ENTRY, 0, 110, 0, 62, 0, 100, 0, @GOSSIP_MENU+6, 14, 0, 0, 62, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 3117.12, -4387.97, 91.9059, 5.49897, "Teleporter script"),
(@ENTRY, 0, 111, 0, 62, 0, 100, 0, @GOSSIP_MENU+6, 15, 0, 0, 62, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 3898.8, -1283.33, 220.519, 6.24307, "Teleporter script"),
(@ENTRY, 0, 112, 0, 62, 0, 100, 0, @GOSSIP_MENU+6, 16, 0, 0, 62, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, -6291.55, -1158.62, -258.138, 0.457099, "Teleporter script"),
(@ENTRY, 0, 113, 0, 62, 0, 100, 0, @GOSSIP_MENU+6, 17, 0, 0, 62, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, -6815.25, 730.015, 40.9483, 2.39066, "Teleporter script"),
(@ENTRY, 0, 114, 0, 62, 0, 100, 0, @GOSSIP_MENU+6, 18, 0, 0, 62, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 6658.57, -4553.48, 718.019, 5.18088, "Teleporter script"),
(@ENTRY, 0, 115, 0, 62, 0, 100, 0, @GOSSIP_MENU+7, 0, 0, 0, 62, 530, 0, 0, 0, 0, 0, 7, 0, 0, 0, -207.335, 2035.92, 96.464, 1.59676, "Teleporter script"),
(@ENTRY, 0, 116, 0, 62, 0, 100, 0, @GOSSIP_MENU+7, 1, 0, 0, 62, 530, 0, 0, 0, 0, 0, 7, 0, 0, 0, -220.297, 5378.58, 23.3223, 1.61718, "Teleporter script"),
(@ENTRY, 0, 117, 0, 62, 0, 100, 0, @GOSSIP_MENU+7, 2, 0, 0, 62, 530, 0, 0, 0, 0, 0, 7, 0, 0, 0, -2266.23, 4244.73, 1.47728, 3.68426, "Teleporter script"),
(@ENTRY, 0, 118, 0, 62, 0, 100, 0, @GOSSIP_MENU+7, 3, 0, 0, 62, 530, 0, 0, 0, 0, 0, 7, 0, 0, 0, -1610.85, 7733.62, -17.2773, 1.33522, "Teleporter script"),
(@ENTRY, 0, 119, 0, 62, 0, 100, 0, @GOSSIP_MENU+7, 4, 0, 0, 62, 530, 0, 0, 0, 0, 0, 7, 0, 0, 0, 2029.75, 6232.07, 133.495, 1.30395, "Teleporter script"),
(@ENTRY, 0, 120, 0, 62, 0, 100, 0, @GOSSIP_MENU+7, 5, 0, 0, 62, 530, 0, 0, 0, 0, 0, 7, 0, 0, 0, 3271.2, 3811.61, 143.153, 3.44101, "Teleporter script"),
(@ENTRY, 0, 121, 0, 62, 0, 100, 0, @GOSSIP_MENU+7, 6, 0, 0, 62, 530, 0, 0, 0, 0, 0, 7, 0, 0, 0, -3681.01, 2350.76, 76.587, 4.25995, "Teleporter script"),
(@ENTRY, 0, 122, 0, 62, 0, 100, 0, @GOSSIP_MENU+8, 0, 0, 0, 62, 571, 0, 0, 0, 0, 0, 7, 0, 0, 0, 2954.24, 5379.13, 60.4538, 2.55544, "Teleporter script"),
(@ENTRY, 0, 123, 0, 62, 0, 100, 0, @GOSSIP_MENU+8, 1, 0, 0, 62, 571, 0, 0, 0, 0, 0, 7, 0, 0, 0, 682.848, -3978.3, 230.161, 1.54207, "Teleporter script"),
(@ENTRY, 0, 124, 0, 62, 0, 100, 0, @GOSSIP_MENU+8, 2, 0, 0, 62, 571, 0, 0, 0, 0, 0, 7, 0, 0, 0, 2678.17, 891.826, 4.37494, 0.101121, "Teleporter script"),
(@ENTRY, 0, 125, 0, 62, 0, 100, 0, @GOSSIP_MENU+8, 3, 0, 0, 62, 571, 0, 0, 0, 0, 0, 7, 0, 0, 0, 4017.35, -3403.85, 290, 5.35431, "Teleporter script"),
(@ENTRY, 0, 126, 0, 62, 0, 100, 0, @GOSSIP_MENU+8, 4, 0, 0, 62, 571, 0, 0, 0, 0, 0, 7, 0, 0, 0, 5560.23, -3211.66, 371.709, 5.55055, "Teleporter script"),
(@ENTRY, 0, 127, 0, 62, 0, 100, 0, @GOSSIP_MENU+8, 5, 0, 0, 62, 571, 0, 0, 0, 0, 0, 7, 0, 0, 0, 5614.67, 5818.86, -69.722, 3.60807, "Teleporter script"),
(@ENTRY, 0, 128, 0, 62, 0, 100, 0, @GOSSIP_MENU+8, 6, 0, 0, 62, 571, 0, 0, 0, 0, 0, 7, 0, 0, 0, 5411.17, -966.37, 167.082, 1.57167, "Teleporter script"),
(@ENTRY, 0, 129, 0, 62, 0, 100, 0, @GOSSIP_MENU+8, 7, 0, 0, 62, 571, 0, 0, 0, 0, 0, 7, 0, 0, 0, 6120.46, -1013.89, 408.39, 5.12322, "Teleporter script"),
(@ENTRY, 0, 130, 0, 62, 0, 100, 0, @GOSSIP_MENU+8, 8, 0, 0, 62, 571, 0, 0, 0, 0, 0, 7, 0, 0, 0, 8323.28, 2763.5, 655.093, 2.87223, "Teleporter script"),
(@ENTRY, 0, 131, 0, 62, 0, 100, 0, @GOSSIP_MENU+8, 9, 0, 0, 62, 571, 0, 0, 0, 0, 0, 7, 0, 0, 0, 4522.23, 2828.01, 389.975, 0.215009, "Teleporter script");

/*
TrinityCore Portal Master
By Rochet2
Downloaded from http://rochet2.github.io/
Bugs and contact with E-mail: Rochet2@post.com
*/



/*
'51900', '1', '0', '|TInterface/ICONS/Spell_Arcane_Portalstormwind:35:35|t|cff0000ffStormwind', '0', '1', '1', '51900', '0', '0', '0', '|cffffcc00Stormwind City\r\n|cffffffffAffiliation |cff0000ffALLIANCE\r\n|cffffffffLocation |cff0000ffNorthwest of Elwynn Forest.', '0');
'51900', '2', '0', '|TInterface/ICONS/Spell_Arcane_PortalOrgrimmar:35:35|t|cffff0000Orgrimmar', '0', '1', '1', '51900', '0', '0', '0', '|cffffcc00Orgrimmar  \r\n|cffffffffAffiliation |cffff0000HORDE  \r\n|cffffffffLocation |cffff0000Northern Durotar.\r\n', '0');
'51900', '3', '0', '|TInterface/ICONS/Achievement_Zone_Darnassus:35:35|t|cff0000ffDarnassus', '0', '1', '1', '51900', '0', '0', '0', '', '0');
'51900', '4', '0', '|TInterface/ICONS/Achievement_Zone_Ironforge:35:35|t|cff0000ffIronforge', '0', '1', '1', '51900', '0', '0', '0', '', '0');
'51900', '5', '0', '|TInterface/ICONS/Spell_Arcane_TeleportExodar:35:35|t|cff0000ffExodar', '0', '1', '1', '51900', '0', '0', '0', '', '0');
'51900', '6', '0', '|TInterface/ICONS/Spell_Arcane_PortalThunderBluff:35:35|t|cffff0000Thunder bluff', '0', '1', '1', '51900', '0', '0', '0', '', '0');
'51900', '7', '0', '|TInterface/ICONS/Spell_Arcane_PortalUndercity:35:35|t|cffff0000Undercity', '0', '1', '1', '51900', '0', '0', '0', '', '0');
'51900', '8', '0', '|TInterface/ICONS/Spell_Arcane_TeleportSilvermoon:35:35|t|cffff0000Silvermoon city', '0', '1', '1', '51900', '0', '0', '0', '', '0');
'51900', '9', '0', '|TInterface/ICONS/Spell_Arcane_TeleportDalaran:35:35|t|cff00ff00Dalaran', '0', '1', '1', '51900', '0', '0', '0', '', '0');
'51900', '10', '0', '|TInterface/ICONS/Spell_Arcane_TeleportShattrath:35:35|t|cff00ff00Shattrath', '0', '1', '1', '51900', '0', '0', '0', '', '0');
'51900', '11', '0', '|TInterface/ICONS/Achievement_Zone_Stranglethorn_01:35:35|t|cFF9932CCBooty bay', '0', '1', '1', '51900', '0', '0', '0', '', '0');
'51900', '12', '0', '|TInterface/ICONS/Ability_DualWieldSpecialization:35:35|t|cFF9932CCGurubashi arena', '0', '1', '1', '51900', '0', '0', '0', '', '0');
'51900', '13', '0', '|TInterface/ICONS/Achievement_Zone_EasternKingdoms_01:35:35|t|cff00ccffEastern Kingdoms', '0', '1', '1', '51905', '0', '0', '0', '', '0');
'51900', '14', '0', '|TInterface/ICONS/Achievement_Zone_Kalimdor_01:35:35|t|cffff6060Kalimdor', '0', '1', '1', '51906', '0', '0', '0', NULL, '0');
'51900', '15', '0', '|TInterface/ICONS/Achievement_Zone_Outland_01:35:35|t|cFF7FFF00Outland', '0', '1', '1', '51907', '0', '0', '0', NULL, '0');
'51900', '16', '0', '|TInterface/ICONS/Achievement_Zone_Northrend_01:35:35|t|cFF00008BNorthrend', '0', '1', '1', '51908', '0', '0', '0', NULL, '0');
'51900', '17', '0', '|TInterface/ICONS/Achievement_Boss_Magtheridon:35:35|t|cFFA52A2AClassic Dungeons', '0', '1', '1', '51901', '0', '0', '0', NULL, '0');
'51900', '18', '0', '|TInterface/ICONS/Achievement_Boss_Illidan:35:35|t|cFFA52A2ABCDungeons', '0', '1', '1', '51902', '0', '0', '0', NULL, '0');
'51900', '19', '0', '|TInterface/ICONS/Achievement_Boss_LichKing:35:35|t|cFFA52A2AWrath Dungeons', '0', '1', '1', '51903', '0', '0', '0', NULL, '0');
'51900', '20', '0', '|TInterface/ICONS/Achievement_Boss_Sindragosa:35:35|t|cFFA52A2ARaid Teleports', '0', '1', '1', '51904', '0', '0', '0', NULL, '0');
'51901', '19', '0', '|TInterface/ICONS/Mail_GMIcon:35:35|t<<Back>>', '0', '1', '1', '51900', '0', '0', '0', NULL, '0');
'51901', '0', '2', '|TInterface/ICONS/Achievement_Character_Gnome_Male:35:35|tGnomeregan', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51901', '1', '2', '|TInterface/ICONS/Achievement_Boss_Bazil_Thredd:35:35|tThe Deadmines', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51901', '2', '2', '|TInterface/ICONS/Achievement_Boss_EdwinVancleef:35:35|tThe Stockade', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51901', '3', '2', '|TInterface/ICONS/Spell_Shadow_DestructiveSoul:35:35|tRagefire Chasm', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51901', '4', '2', '|TInterface/ICONS/Spell_Nature_EyeOfTheStorm:35:35|tRazorfen Downs', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51901', '5', '2', '|TInterface/ICONS/INV_SpiritShard_01:35:35|tRazorfen Kraul', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51901', '6', '2', '|TInterface/ICONS/INV_Misc_Idol_01:35:35|tScarlet Monastery', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51901', '7', '2', '|TInterface/ICONS/INV_Misc_Head_Gnoll_01:35:35|tShadowfang Keep', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51901', '8', '2', '|TInterface/ICONS/Ability_Warlock_ChaosBolt.:35:35|tWailing Caverns', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51901', '9', '2', '|TInterface/ICONS/Spell_Frost_FrostShock:35:35|tBlackfathom Deeps', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51901', '10', '2', '|TInterface/ICONS/Spell_Frost_FireResistanceTotem:35:35|tBlackrock Depths', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51901', '11', '2', '|TInterface/ICONS/Spell_Nature_UnleashedRage:35:35|tBlackrock Spire', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51901', '12', '2', '|TInterface/ICONS/INV_Jewelcrafting_EmeraldCrab:35:35|tDire Maul', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51901', '13', '2', '|TInterface/ICONS/INV_Misc_ClothScrap_05:35:35|tMaraudon', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51901', '14', '2', '|TInterface/ICONS/Spell_DeathKnight_ArmyOfTheDead:35:35|tScholomance', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51901', '15', '2', '|TInterface/ICONS/Ability_Mount_NightmareHorse:35:35|tStratholme', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51901', '16', '2', '|TInterface/ICONS/INV_Misc_Statue_08:35:35|tSunken Temple', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51901', '17', '2', '|TInterface/ICONS/Achievement_Zone_Badlands_01:35:35|tUldaman', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51901', '18', '2', '|TInterface/ICONS/Spell_Frost_ChillingBlast:35:35|tZul\'Farrak', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51902', '6', '0', '|TInterface/ICONS/Mail_GMIcon:35:35|t<<Back>>', '0', '1', '1', '51900', '0', '0', '0', '', '0');
'51902', '5', '2', '|TInterface/ICONS/Achievement_Zone_Netherstorm_01:35:35|tTempest Keep', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51902', '4', '2', '|TInterface/ICONS/Achievement_Zone_IsleOfQuelDanas:35:35|tMagisters\' Terrace', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51902', '3', '2', '|TInterface/ICONS/Achievement_Zone_HellfirePeninsula_01:35:35|tHellfire Citadel', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51902', '2', '2', '|TInterface/ICONS/ABILITY_MAGE_INVISIBILITY:35:35|tCoilfang Reservoir', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51902', '1', '2', '|TInterface/ICONS/Ability_Mount_Drake_Bronze:35:35|tCaverns of Time', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51902', '0', '2', '|TInterface/ICONS/INV_1H_Auchindoun_01:35:35|tAuchindoun', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51903', '12', '0', '|TInterface/ICONS/Mail_GMIcon:35:35|t<<Back>>', '0', '1', '1', '51900', '0', '0', '0', '', '0');
'51903', '11', '2', '|TInterface/ICONS/Achievement_Dungeon_UtgardePinnacle_Heroic:35:35|tUtgarde Pinnacle', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51903', '10', '2', '|TInterface/ICONS/Achievement_Dungeon_UtgardeKeep_Heroic:35:35|tUtgarde Keep', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51903', '9', '2', '|TInterface/ICONS/Achievement_Zone_StormPeaks_11:35:35|tHalls of Stone', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51903', '8', '2', '|TInterface/ICONS/Achievement_Zone_StormPeaks_12:35:35|tHalls of Lightning', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51903', '7', '2', '|TInterface/ICONS/Achievement_Dungeon_TheVioletHold_Heroic:35:35|tThe Violet Hold', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51903', '6', '2', '|TInterface/ICONS/Achievement_Dungeon_Nexus70_Heroic:35:35|tThe Nexus Dungeons', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51903', '5', '2', '|TInterface/ICONS/Achievement_Zone_IceCrown_01:35:35|tIcecrown Citadel Dungeons', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51903', '4', '2', '|TInterface/ICONS/Achievement_Dungeon_Gundrak_Heroic:35:35|tGundrak', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51903', '3', '2', '|TInterface/ICONS/Achievement_Zone_ZulDrak_01:35:35|tDrak\'Tharon Keep', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51903', '2', '2', '|TInterface/ICONS/Achievement_Reputation_ArgentChampion:35:35|tTrial of the Champion', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51903', '1', '2', '|TInterface/ICONS/Achievement_Dungeon_CoTStratholme_Heroic:35:35|tThe Culling of Stratholme', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51903', '0', '2', '|TInterface/ICONS/Achievement_Dungeon_AzjolLowercity_Heroic:35:35|tAzjol-Nerub', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51904', '23', '0', '|TInterface/ICONS/Mail_GMIcon:35:35|t<<Back>>', '0', '1', '1', '51900', '0', '0', '0', '', '0');
'51904', '22', '2', '|TInterface/ICONS/INV_Offhand_ZulAman_D_02:35:35|tZul\'Aman', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51904', '21', '2', '|TInterface/ICONS/Inv_Helm_Mask_ZulGurub_D_01:35:35|tZul\'Gurub', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51904', '19', '2', '|TInterface/ICONS/INV_EssenceOfWintergrasp:35:35|tVault of Archavon', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51904', '18', '2', '|TInterface/ICONS/Achievement_Dungeon_UlduarRaid_Misc_03:35:35|tUlduar', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51904', '17', '2', '|TInterface/ICONS/Achievement_Reputation_WyrmrestTemple:35:35|tThe Obsidian Sanctum', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51904', '16', '2', '|TInterface/ICONS/INV_Misc_Eye_03:35:35|tThe Eye of Eternity', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51904', '15', '2', '|TInterface/ICONS/INV_Axe_37:35:35|tTemple of Ahn\'Qiraj', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51904', '14', '2', '|TInterface/ICONS/INV_Misc_Eye_04:35:35|tThe Eye', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51904', '13', '2', '|TInterface/ICONS/ACHIEVEMENT_BOSS_KILJAEDAN:35:35|tSunwell Plateau', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51904', '12', '2', '|TInterface/ICONS/INV_Weapon_Halberd_AhnQiraj:35:35|tRuins of Ahn\'Qiraj', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51904', '11', '2', '|TInterface/ICONS/Achievement_Boss_Onyxia:35:35|tOnyxia\'s Lair', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51904', '10', '2', '|TInterface/ICONS/Achievement_Dungeon_Naxxramas_Heroic:35:35|tNaxxramas', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51904', '9', '2', '|TInterface/ICONS/Ability_Druid_ChallangingRoar:35:35|tMolten Core', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51904', '8', '2', '|TInterface/ICONS/Achievement_Boss_PrinceMalchezaar_02:35:35|tKarazhan', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51904', '7', '2', '|TInterface/ICONS/Achievement_Dungeon_Icecrown_IcecrownEntrance:35:35|tIcecrown Citadel', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51904', '6', '2', '|TInterface/ICONS/Achievement_Boss_Magtheridon:35:35|tMagtheridon\'s Lair', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51904', '5', '2', '|TInterface/ICONS/Spell_Misc_EmotionAngry:35:35|tGruul\'s Lair', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51904', '4', '2', '|TInterface/ICONS/INV_Shield_72:35:35|tTrial of the Crusader', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51904', '3', '2', '|TInterface/ICONS/Ability_Hunter_SerpentSwiftness:35:35|tSerpentshrine Cavern', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51904', '2', '2', '|TInterface/ICONS/INV_Offhand_Hyjal_D_01:35:35|tHyjal Summit', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51904', '1', '2', '|TInterface/ICONS/Ability_Warlock_Backdraft:35:35|tBlackwing Lair', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51904', '0', '2', '|TInterface/ICONS/Achievement_Boss_CThun:35:35|tBlack Temple', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51905', '24', '0', '|TInterface/ICONS/Mail_GMIcon:35:35|t<<Back>>', '0', '1', '1', '51900', '0', '0', '0', '', '0');
'51905', '23', '2', '|TInterface/ICONS/Achievement_Zone_IsleOfQuelDanas:35:35|tIsle of Quel\'Danas', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51905', '22', '2', '|TInterface/ICONS/Achievement_Zone_EasternPlaguelands:35:35|tEastern Plaguelands', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51905', '21', '2', '|TInterface/ICONS/Achievement_Zone_WesternPlaguelands_01:35:35|tWestern Plaguelands', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51905', '20', '2', '|TInterface/ICONS/Achievement_Zone_BurningSteppes_01:35:35|tBurning Steppes', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51905', '19', '2', '|TInterface/ICONS/Achievement_Zone_BlastedLands_01:35:35|tThe Blasted Lands', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51905', '18', '2', '|TInterface/ICONS/Achievement_Zone_SearingGorge_01:35:35|tSearing Gorge', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51905', '17', '2', '|TInterface/ICONS/Achievement_Zone_Hinterlands_01:35:35|tThe Hinterlands', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51905', '16', '2', '|TInterface/ICONS/Achievement_Zone_SwampSorrows_01:35:35|tSwamp of Sorrows', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51905', '15', '2', '|TInterface/ICONS/Achievement_Zone_Badlands_01:35:35|tBadlands', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51905', '14', '2', '|TInterface/ICONS/Achievement_Zone_Stranglethorn_01:35:35|tStranglethorn Vale', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51905', '13', '2', '|TInterface/ICONS/Achievement_Zone_ArathiHighlands_01:35:35|tArathi Highlands', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51905', '12', '2', '|TInterface/ICONS/Achievement_Zone_AlteracMountains_01:35:35|tAlterac Mountains', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51905', '11', '2', '|TInterface/ICONS/Achievement_Zone_Wetlands_01:35:35|tWetlands', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51905', '10', '2', '|TInterface/ICONS/Achievement_Zone_HillsbradFoothills:35:35|tHillsbrad Foothills', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51905', '9', '2', '|TInterface/ICONS/Achievement_Zone_Duskwood:35:35|tDuskwood', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51905', '8', '2', '|TInterface/ICONS/Achievement_Zone_Redridgemountains:35:35|tRedridge mountains', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51905', '7', '2', '|TInterface/ICONS/Achievement_Zone_WestFall_01:35:35|tWestfall', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51905', '6', '2', '|TInterface/ICONS/Achievement_Zone_Silverpine_01:35:35|tSilverpine Forest', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51905', '5', '2', '|TInterface/ICONS/Achievement_Zone_Lochmodan:35:35|tLoch modan', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51905', '4', '2', '|TInterface/ICONS/Achievement_Zone_Ghostlands:35:35|tGhostlands', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51905', '3', '2', '|TInterface/ICONS/Achievement_Zone_TirisfalGlades_01:35:35|tTirisfal Glades', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51905', '2', '2', '|TInterface/ICONS/Achievement_Zone_DunMorogh:35:35|tDun Morogh', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51905', '1', '2', '|TInterface/ICONS/Achievement_Zone_EversongWoods:35:35|tEversong Woods', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51905', '0', '2', '|TInterface/ICONS/Achievement_Zone_ElwynnForest:35:35|tElwynn Forest', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51906', '19', '0', '|TInterface/ICONS/Mail_GMIcon:35:35|t<<Back>>', '0', '1', '1', '51900', '0', '0', '0', '', '0');
'51906', '18', '2', '|TInterface/ICONS/Achievement_Zone_Winterspring:35:35|tWinterspring', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51906', '17', '2', '|TInterface/ICONS/Achievement_Zone_Silithus_01:35:35|tSilithus', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51906', '16', '2', '|TInterface/ICONS/Achievement_Zone_UnGoroCrater_01:35:35|tUn\'Goro Crater', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51906', '15', '2', '|TInterface/ICONS/Achievement_Zone_Felwood:35:35|tFelwood', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51906', '14', '2', '|TInterface/ICONS/Achievement_Zone_Azshara_01:35:35|tAzshara', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51906', '13', '2', '|TInterface/ICONS/Achievement_Zone_Tanaris_01:35:35|tTanaris Desert', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51906', '12', '2', '|TInterface/ICONS/Achievement_Zone_Feralas:35:35|tFeralas', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51906', '11', '2', '|TInterface/ICONS/Achievement_Zone_DustwallowMarsh:35:35|tDustwallow Marsh', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51906', '10', '2', '|TInterface/ICONS/Achievement_Zone_Desolace:35:35|tDesolace', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51906', '9', '2', '|TInterface/ICONS/Achievement_Zone_ThousandNeedles_01:35:35|tThousand Needles', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51906', '8', '2', '|TInterface/ICONS/Achievement_Zone_Ashenvale_01:35:35|tAshenvale Forest', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51906', '7', '2', '|TInterface/ICONS/Achievement_Zone_Stonetalon_01:35:35|tStonetalon Mountains', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51906', '6', '2', '|TInterface/ICONS/Achievement_Zone_Barrens_01:35:35|tThe Barrens', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51906', '5', '2', '|TInterface/ICONS/Achievement_Zone_Darkshore_01:35:35|tDarkshore', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51906', '4', '2', '|TInterface/ICONS/Achievement_Zone_BloodmystIsle_01:35:35|tBloodmyst Isle', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51906', '3', '2', '|TInterface/ICONS/Achievement_Zone_Mulgore_01:35:35|tMulgore', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51906', '2', '2', '|TInterface/ICONS/Achievement_Zone_Durotar:35:35|tDurotar', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51906', '1', '2', '|TInterface/ICONS/Achievement_Zone_UnGoroCrater_01:35:35|tTeldrassil', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51906', '0', '2', '|TInterface/ICONS/Achievement_Zone_AzuremystIsle_01:35:35|tAzuremyst Isle', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51907', '7', '0', '|TInterface/ICONS/Mail_GMIcon:35:35|t<<Back>>', '0', '1', '1', '51900', '0', '0', '0', '', '0');
'51907', '6', '2', '|TInterface/ICONS/Achievement_Zone_Shadowmoon:35:35|tShadowmoon Valley', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51907', '5', '2', '|TInterface/ICONS/Achievement_Zone_Netherstorm_01:35:35|tNetherstorm', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51907', '4', '2', '|TInterface/ICONS/Achievement_Zone_AlteracMountains_01:35:35|tBlade\'s Edge Mountains', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51907', '3', '2', '|TInterface/ICONS/Achievement_Zone_Nagrand_01:35:35|tNagrand', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51907', '2', '2', '|TInterface/ICONS/Spell_Arcane_TeleportShattrath:35:35|tTerokkar Forest', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51907', '1', '2', '|TInterface/ICONS/Achievement_Zone_Zangarmarsh:35:35|tZangarmarsh', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51907', '0', '2', '|TInterface/ICONS/Achievement_Zone_HellfirePeninsula_01:35:35|tHellfire Peninsula', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51908', '9', '2', '|TInterface/ICONS/Achievement_Zone_Winterspring:35:35|tWintergrasp', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51908', '8', '2', '|TInterface/ICONS/Achievement_Zone_IceCrown_05:35:35|tIcecrown', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51908', '7', '2', '|TInterface/ICONS/Achievement_Zone_StormPeaks_01:35:35|tStorm Peaks', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51908', '6', '2', '|TInterface/ICONS/Achievement_Zone_CrystalSong_01:35:35|tCrystalsong Forest', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51908', '5', '2', '|TInterface/ICONS/Achievement_Zone_Sholazar_01:35:35|tSholazar Basin', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51908', '4', '2', '|TInterface/ICONS/Achievement_Zone_ZulDrak_01:35:35|tZul\'Drak', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51908', '3', '2', '|TInterface/ICONS/Achievement_Zone_GrizzlyHills_01:35:35|tGrizzly Hills', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51908', '2', '2', '|TInterface/ICONS/Achievement_Zone_DragonBlight_03:35:35|tDragonblight', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51908', '1', '2', '|TInterface/ICONS/Achievement_Zone_HowlingFjord_01:35:35|tHowling Fjord', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51908', '0', '2', '|TInterface/ICONS/Achievement_Zone_BoreanTundra_01:35:35|tBorean Tundra', '0', '1', '1', '0', '0', '0', '0', '', '0');
'51908', '10', '0', '|TInterface/ICONS/Mail_GMIcon:35:35|t<<Back>>', '0', '1', '1', '51900', '0', '0', '0', NULL, '0');
*/