INSERT INTO Address (Region, Area, Territory)
SELECT DISTINCT       RegName,       AreaName,       TerName       FROM ZNO_table
UNION SELECT DISTINCT EORegName,     EOAreaName,     EOTerName     FROM ZNO_table
UNION SELECT DISTINCT ukrPTRegName,  ukrPTAreaName,  ukrPTTerName  FROM ZNO_table
UNION SELECT DISTINCT mathPTRegName, mathPTAreaName, mathPTTerName FROM ZNO_table
UNION SELECT DISTINCT histPTRegName, histPTAreaName, histPTTerName FROM ZNO_table
UNION SELECT DISTINCT physPTRegName, physPTAreaName, physPTTerName FROM ZNO_table
UNION SELECT DISTINCT chemPTRegName, chemPTAreaName, chemPTTerName FROM ZNO_table
UNION SELECT DISTINCT bioPTRegName,  bioPTAreaName,  bioPTTerName  FROM ZNO_table
UNION SELECT DISTINCT geoPTRegName,  geoPTAreaName,  geoPTTerName  FROM ZNO_table
UNION SELECT DISTINCT engPTRegName,  engPTAreaName,  engPTTerName  FROM ZNO_table
UNION SELECT DISTINCT fraPTRegName,  fraPTAreaName,  fraPTTerName  FROM ZNO_table
UNION SELECT DISTINCT deuPTRegName,  deuPTAreaName,  deuPTTerName  FROM ZNO_table
UNION SELECT DISTINCT spaPTRegName,  spaPTAreaName,  spaPTTerName  FROM ZNO_table;

UPDATE Address
SET Type_terr = ZNO_table.terTypeName
FROM ZNO_table
WHERE ZNO_table.RegName  = Address.Region AND
      ZNO_table.AreaName = Address.Area AND
      ZNO_table.TerName  = Address.Territory;

DELETE FROM Address WHERE Territory IS NULL;

INSERT INTO Person (Person_iD, birth, Gender, Type_person, profile, class_lang)
SELECT DISTINCT ON (OutID) OutID, birth, SexTypeName, RegTypeName, ClassProfileNAME, ClassLangName
FROM ZNO_table

INSERT INTO Person_Address (person_id, address_id)
SELECT DISTINCT ON (ZNO_table.OutID)
	ZNO_table.OutID,
	Address.address_id
FROM (ZNO_table)
LEFT JOIN Address ON
	(ZNO_table.RegName  = Address.Region AND
     ZNO_table.AreaName = Address.Area AND
     ZNO_table.TerName  = Address.Territory);

INSERT INTO School(School_name, Type, Parent)
SELECT DISTINCT ON (all_schools.school_name)
	all_schools.school_name,
	ZNO_table.EOTypeName,
	ZNO_table.EOParent
FROM (
    select distinct *
    FROM (
        SELECT DISTINCT EOName FROM ZNO_table
        UNION SELECT DISTINCT ukrPTName  FROM ZNO_table
        UNION SELECT DISTINCT mathPTName FROM ZNO_table
        UNION SELECT DISTINCT histPTName FROM ZNO_table
        UNION SELECT DISTINCT physPTName FROM ZNO_table
        UNION SELECT DISTINCT chemPTName FROM ZNO_table
        UNION SELECT DISTINCT bioPTName  FROM ZNO_table
        UNION SELECT DISTINCT geoPTName  FROM ZNO_table
        UNION SELECT DISTINCT engPTName  FROM ZNO_table
        UNION SELECT DISTINCT fraPTName  FROM ZNO_table
        UNION SELECT DISTINCT deuPTName  FROM ZNO_table
        UNION SELECT DISTINCT spaPTName  FROM ZNO_table
    ) as temp
) AS all_schools (school_name)
LEFT JOIN ZNO_table ON
	all_schools.school_name = ZNO_table.EOName
WHERE all_schools.school_name IS NOT NULL;

INSERT INTO School_address(school_name, address_id)
SELECT DISTINCT ON (all_schools.school_name)
	all_schools.school_name, 
	Address.address_id
FROM (
    select distinct * 
    FROM (
        SELECT DISTINCT EOName, EOTerName, EOAreaName, EORegName FROM ZNO_table
        UNION SELECT DISTINCT ukrPTName,  ukrPTTerName,  ukrPTAreaName,  ukrPTRegName  FROM ZNO_table
        UNION SELECT DISTINCT mathPTName, mathPTTerName, mathPTAreaName, mathPTRegName FROM ZNO_table
        UNION SELECT DISTINCT histPTName, histPTTerName, histPTAreaName, histPTRegName FROM ZNO_table
        UNION SELECT DISTINCT physPTName, physPTTerName, physPTAreaName, physPTRegName FROM ZNO_table
        UNION SELECT DISTINCT chemPTName, chemPTTerName, chemPTAreaName, chemPTRegName FROM ZNO_table
        UNION SELECT DISTINCT bioPTName,  bioPTTerName,  bioPTAreaName,  bioPTRegName  FROM ZNO_table
        UNION SELECT DISTINCT geoPTName,  geoPTTerName,  geoPTAreaName,  geoPTRegName  FROM ZNO_table
        UNION SELECT DISTINCT engPTName,  engPTTerName,  engPTAreaName,  engPTRegName  FROM ZNO_table
        UNION SELECT DISTINCT fraPTName,  fraPTTerName,  fraPTAreaName,  fraPTRegName  FROM ZNO_table
        UNION SELECT DISTINCT deuPTName,  deuPTTerName,  deuPTAreaName,  deuPTRegName  FROM ZNO_table
        UNION SELECT DISTINCT spaPTName,  spaPTTerName,  spaPTAreaName,  spaPTRegName  FROM ZNO_table
    ) as temp
) AS all_schools (school_name, TerName, AreaName, RegName)
LEFT JOIN Address ON
	all_schools.TerName = Address.territory AND
	all_schools.AreaName = Address.area AND
	all_schools.RegName = Address.region
WHERE all_schools.school_name IS NOT NULL;


INSERT INTO Exam (Person_id, Year_test, School_name, Object_name, Object_status, Ball, Ball12, Ball100,
       Adapt_Scale)
SELECT OutID, Year,  UkrPTName, ukrTest, ukrTestStatus, ukrBall, ukrBall12, ukrBall100, ukrAdaptScale
FROM ZNO_table
WHERE ukrTest IS NOT NULL;

INSERT INTO Exam (Person_id, Year_test, School_name, Object_name, Object_status, Ball, Ball12, Ball100,
       Test_lang)
SELECT OutID, Year,  histPTName, histTest, histTestStatus, histBall, histBall12, histBall100, histLang
FROM ZNO_table
WHERE histTest IS NOT NULL;

INSERT INTO Exam (Person_id, Year_test, School_name, Object_name, Object_status, Ball, Ball12, Ball100,
       Test_lang)
SELECT OutID, Year,  mathPTName, mathTest, mathTestStatus, mathBall, mathBall12, mathBall100, mathLang
FROM ZNO_table
WHERE mathTest IS NOT NULL;

INSERT INTO Exam (Person_id, Year_test, School_name, Object_name, Object_status, Ball, Ball12, Ball100,
       Test_lang)
SELECT OutID, Year,  physPTName, physTest, physTestStatus, physBall, physBall12, physBall100, physLang
FROM ZNO_table
WHERE physTest IS NOT NULL;

INSERT INTO Exam (Person_id, Year_test, School_name, Object_name, Object_status, Ball, Ball12, Ball100,
       Test_lang)
SELECT OutID, Year,  chemPTName, chemTest, chemTestStatus, chemBall, chemBall12, chemBall100, chemLang
FROM ZNO_table
WHERE chemTest IS NOT NULL;

INSERT INTO Exam (Person_id, Year_test, School_name, Object_name, Object_status, Ball, Ball12, Ball100,
       Test_lang)
SELECT OutID, Year,  bioPTName, bioTest, bioTestStatus, bioBall, bioBall12, bioBall100, bioLang
FROM ZNO_table
WHERE bioTest IS NOT NULL;

INSERT INTO Exam (Person_id, Year_test, School_name, Object_name, Object_status, Ball, Ball12, Ball100,
       Test_lang)
SELECT OutID, Year,  geoPTName, geoTest, geoTestStatus, geoBall, geoBall12, geoBall100, geoLang
FROM ZNO_table
WHERE geoTest IS NOT NULL;

INSERT INTO Exam (Person_id, Year_test, School_name, Object_name, Object_status, Ball, Ball12, Ball100,
       DPA_level)
SELECT OutID, Year,  engPTName, engTest, engTestStatus, engBall, engBall12, engBall100, engDPALevel
FROM ZNO_table
WHERE engTest IS NOT NULL;

INSERT INTO Exam (Person_id, Year_test, School_name, Object_name, Object_status, Ball, Ball12, Ball100,
       DPA_level)
SELECT OutID, Year,  fraPTName, fraTest, fraTestStatus, fraBall, fraBall12, fraBall100, fraDPALevel
FROM ZNO_table
WHERE fraTest IS NOT NULL;

INSERT INTO Exam (Person_id, Year_test, School_name, Object_name, Object_status, Ball, Ball12, Ball100,
       DPA_level)
SELECT OutID, Year,  deuPTName, deuTest, deuTestStatus, deuBall, deuBall12, deuBall100, deuDPALevel
FROM ZNO_table
WHERE deuTest IS NOT NULL;

INSERT INTO Exam (Person_id, Year_test, School_name, Object_name, Object_status, Ball, Ball12, Ball100,
       DPA_level)
SELECT OutID, Year,  spaPTName, spaTest, spaTestStatus, spaBall, spaBall12, spaBall100, spaDPALevel
FROM ZNO_table
WHERE spaTest IS NOT NULL;


