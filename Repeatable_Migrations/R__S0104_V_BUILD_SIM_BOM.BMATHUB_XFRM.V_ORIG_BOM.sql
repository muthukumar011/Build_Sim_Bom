// Create View V_ORIG_BOM //

create or replace view BUILD_SIM_BOM.BMATHUB_XFRM.V_ORIG_BOM(
	INPUT_ITEM_ID,
	ITEM_CLASS_NM,
	OUTPUT_ITEM_ID,
	LOC
) as
SELECT
  INPUT_ITEM_ID,
  ITEM_CLASS_NM,
  OUTPUT_ITEM_ID,
  LOC
FROM
  BUILD_SIM_BOM.BMATHUB_BASE.T_ORIG_BOM;