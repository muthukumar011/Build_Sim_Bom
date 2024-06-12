CREATE OR REPLACE PROCEDURE BUILD_SIM_BOM.BMATHUB_BASE.P_ROOT_CORE_BUILD()
RETURNS VARCHAR(50)
LANGUAGE SQL
EXECUTE AS OWNER
AS 
BEGIN 
    MERGE INTO BUILD_SIM_BOM.BMATHUB_BASE.T_COMPRESS_BOM_CORE AS target 
    USING (
        SELECT 
            OB.INPUT_ITEM_ID, 
            OB.ITEM_CLASS_NM, 
            OB.OUTPUT_ITEM_ID, 
            ROW_NUMBER() OVER(ORDER BY OB.INPUT_ITEM_ID) + 100 AS BOM_NUM,
            CASE 
                WHEN OB.ITEM_CLASS_NM = MR.ITEM_CLASS_NM THEN MR.LOC 
                ELSE OB.LOC 
            END AS LOC
        FROM 
            BUILD_SIM_BOM.BMATHUB_XFRM.V_ORIG_BOM AS OB
        LEFT JOIN 
            BUILD_SIM_BOM.BMATHUB_XFRM.V_METADATA_RULES AS MR
        ON
            OB.ITEM_CLASS_NM = MR.ITEM_CLASS_NM
    ) AS source
    ON (target.INPUT_ITEM_ID = source.INPUT_ITEM_ID) 
    WHEN MATCHED THEN 
        UPDATE 
        SET 
            target.ITEM_CLASS_NM = source.ITEM_CLASS_NM, 
            target.OUTPUT_ITEM_ID = source.OUTPUT_ITEM_ID, 
            target.BOM_NUM = source.BOM_NUM,
            target.LOC = source.LOC 
    WHEN NOT MATCHED THEN 
        INSERT (INPUT_ITEM_ID, ITEM_CLASS_NM, OUTPUT_ITEM_ID, BOM_NUM, LOC) 
        VALUES (source.INPUT_ITEM_ID, source.ITEM_CLASS_NM, source.OUTPUT_ITEM_ID, source.BOM_NUM, source.LOC);
    RETURN 'Data loaded successfully.';
END;


CALL BUILD_SIM_BOM.BMATHUB_BASE.P_ROOT_CORE_BUILD();






