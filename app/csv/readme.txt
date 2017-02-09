Version 3.0 Produced 2016-06-30

The kis .csv files have been included in this folder to enable users to load .csv versions of the kis.xml file entities into their databases for analysis.

The .csv file structure is based on that created for the Unistats output .xml file with some exceptions (see paragraph below). 

This documentation includes details of the parent entity, field description, field type, min/max occurrence, field length and additional notes.  Field information for the three .csv lookup tables (ACCREDITATIONTABLE.csv, KISAIM.csv and LOCATION.csv), plus the two additional .csv entities (UCASCOURSEID.csv and SBJ.csv (created to hold the COURSELOCATION UCASCOURSEID and KISCourse SBJ repeating fields)), can be found in the 'Unistats dataset file structure and description' 

https://www.hesa.ac.uk/collection/c16061/unistats_dataset_file_structure/

The .csv file name, the entity name, the entity description, how to join to other files and additional notes, if applicable, are listed below:

ACCREDITATION.csv, 
Accreditation entity, 
Contains information about course accreditation, 
Linked to KISCOURSE entity using PUBUKPRN, KISCOURSEID and KISMODE

ACCREDITATIONTABLE.csv, 
Accreditation lookup table,
Contains the accrediting body text and accreditation url for each ACCTYPE,
Lookup table
(This lookup table may be linked to the ACCREDITATION entity using ACCTYPE)

COMMON.csv, 
Common job types entity, 
Contains information relating to common job types obtained by students taking the course, 
Linked to KISCOURSE entity using PUBUKPRN, KISCOURSEID and KISMODE,
Linked to JOBLIST entity using PUBUKPRN, KISCOURSEID, KISMODE and COMSBJ,
(Note COMSBJ may contain nulls)

CONTINUATION.csv,
Continuation entity,
Contains continuation information for students on the course,
Linked to KISCOURSE entity using PUBUKPRN, KISCOURSEID and KISMODE

COURSELOCATION.csv,
Course location entity,
Contains details of the KIS course location,
Linked to KISCOURSE entity using PUBUKPRN, KISCOURSEID and KISMODE
Linked to UCASCOURSEID entity using PUBUKPRN, KISCOURSEID, KISMODE and LOCID
(Note LOCID may contain nulls)

COURSESTAGE.csv,
Course stage entity,
Contains details of the learning and teaching and assessment methods for the CourseStage,
Linked to KISCOURSE entity using PUBUKPRN, KISCOURSEID and KISMODE

DEGREECLASS.csv,
Degree classification entity,
Contains information relating to the degree classifications obtained by students,
Linked to KISCOURSE entity using PUBUKPRN, KISCOURSEID and KISMODE

EMPLOYMENT.csv,
Employment statistics entity,
Contains information relating to student employment outcomes,
Linked to KISCOURSE entity using PUBUKPRN, KISCOURSEID and KISMODE

ENTRY.csv
Entry qualifications entity,
Contains information relating to the entry qualifications of students,
Linked to KISCOURSE entity using PUBUKPRN, KISCOURSEID and KISMODE

INSTITUTION.csv,
Institution table,
This entity describes the reporting institution
Linked to KISCOURSE entity using PUBUKPRN

JOBLIST.csv,
Job list entity,
Contains information about common job types obtained by students,
Linked to COMMON entity using PUBUKPRN, KISCOURSEID, KISMODE and COMSBJ,
(Note COMSBJ may contain nulls)

JOBTYPE.csv,
Job type entity,
Contains information relating to the types of profession entered by students,
Linked to KISCOURSE entity using PUBUKPRN, KISCOURSEID and KISMODE

KISAIM.csv, 
KIS Aim lookup table,
Contains the code and label for each KISAIM,
Lookup table,
(This lookup table may be linked to the KISCOURSE entity using KISAIMCODE)

KISCOURSE.csv,
KIS course entity,
This entity records details of KIS courses,
Linked to INSTITUTION entity using PUBUKPRN and
Linked to child entities using PUBUKPRN, KISCOURSEID and KISMODE

LOCATION.csv,
Location lookup table,
Contains details for each teaching location,
Lookup table,
(This lookup table may be linked to the LOCID entity using UKPRN and LOCID)

NHSNSS.csv,
NHS NSS entity,
Contains the results for the questions on the NSS for students on NHS funded courses,
Linked to KISCOURSE entity using PUBUKPRN, KISCOURSEID and KISMODE

NSS.csv,
NSS entity,
Contains the National Student Survey (NSS) results,
Linked to KISCOURSE entity using PUBUKPRN, KISCOURSEID and KISMODE

SALARY.csv,
Salary entity,
Contains salary information of students,
Linked to KISCOURSE entity using PUBUKPRN, KISCOURSEID and KISMODE

SBJ.csv,
Subject entity,
Contains JACS level subject codes for each KISCourse,
Linked to KISCOURSE entity using PUBUKPRN, KISCOURSEID and KISMODE

TARIFF.csv,
Tariff entity,
Contains information relating to the entry tariff points of students,
Linked to KISCOURSE entity using PUBUKPRN, KISCOURSEID and KISMODE

UCASCOURSEID.csv,
UCASCOURSEID entity,
Contains UCAS course identifiers for each COURSELOCATION,
Linked to COURSELOCATION entity using PUBUKPRN, KISCOURSEID, KISMODE and LOCID


ACCREDITATIONBYHEP.csv,
Table showing usage of accreditation types by Higher Education Provider. This file enables Accrediting Bodies to determine which HE providers are using which accreditation types, to support their quality assurance and audit functions.
