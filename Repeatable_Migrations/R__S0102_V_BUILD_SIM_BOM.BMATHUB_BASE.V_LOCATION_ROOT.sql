// Create View V_LOCATION // 

create or replace view BUILD_SIM_BOM.BMATHUB_XFRM.V_LOCATION(
	ITEM_ID,
	ITEM_CLASS_NM,
	LOCATION_ID
) as
SELECT
  ITEM_ID,
  ITEM_CLASS_NM,
  LOCATION_ID
FROM
  BUILD_SIM_BOM.BMATHUB_BASE.T_LOCATION_ROOT;
