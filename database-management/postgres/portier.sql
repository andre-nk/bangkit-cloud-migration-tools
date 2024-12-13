CREATE SCHEMA IF NOT EXISTS dbo;

CREATE TABLE IF NOT EXISTS dbo.SYSTEM (
  SYSTEM_ID varchar PRIMARY KEY,
  SYSTEM_NR int,
  COMPETENCY_LEVEL_ID int,
  SYSTEM_NUMBER varchar,
  DESCRIPTION varchar,
  OUTPUT_ZONE_ID int,
  NOTE_1 varchar,
  NOTE_2 varchar,
  NOTE_3 varchar,
  LOCKING_SYSTEM varchar,
  MANUFACTURER varchar,
  SYSTEM_TYPE varchar,
  SYSTEMS_NUMBER varchar,
  SYSTEM_CODE varchar,
  SYSTEM_CREATED_ON timestamp,
  HANDLER_ID varchar,
  SYSTEM_DATE timestamp,
  LAST_MODIFIED timestamp,
  TEMP_ID int,
  TRANSFER_FLAG int,
  FACTORY varchar
);

CREATE UNIQUE INDEX IF NOT EXISTS dbo_PK_SYSTEM ON dbo.SYSTEM (SYSTEM_ID);

CREATE TABLE IF NOT EXISTS dbo.EXECUTION (
  EXECUTION_ID int PRIMARY KEY,
  DESCRIPTION varchar,
  SYSTEM_DATE timestamp,
  LAST_MODIFIED timestamp
);

CREATE UNIQUE INDEX IF NOT EXISTS dbo_PK_EXECUTION ON dbo.EXECUTION (EXECUTION_ID);

CREATE TABLE IF NOT EXISTS dbo.ISSUE (
  ISSUE_ID varchar PRIMARY KEY,
  COPY_ID varchar,
  PERSONNEL_ID varchar,
  BUNDLE_ID varchar,
  KEY_ID varchar,
  SYSTEM_ID varchar,
  ISSUE_NR int,
  FUNCTION_ID varchar,
  HANDLER_ID varchar,
  ISSUE_DATE timestamp,
  ISSUE_TIME varchar,
  RETURN_DEADLINE_DATE timestamp,
  RETURN_DEADLINE_TIME varchar,
  REMARK varchar,
  STATUS varchar,
  KEY_NUMBER varchar,
  ISSUE_PROCESS int,
  PENDING int,
  SIGNATURE_ID varchar,
  PICKUP_PERSONNEL_ID varchar,
  LAST_MODIFIED timestamp,
  SYSTEM_DATE timestamp,
  TEMP_ID int,
  DEPOSIT float
);

CREATE UNIQUE INDEX IF NOT EXISTS dbo_PK_ISSUE ON dbo.ISSUE (COPY_ID, ISSUE_ID);
CREATE INDEX IF NOT EXISTS dbo_IDX_ISSUE_KN ON dbo.ISSUE (KEY_NUMBER);
CREATE INDEX IF NOT EXISTS dbo_IDX_ISSUE_KID ON dbo.ISSUE (KEY_ID);
CREATE INDEX IF NOT EXISTS dbo_IDX_ISSUE_CID ON dbo.ISSUE (COPY_ID);
CREATE INDEX IF NOT EXISTS dbo_IDX_ISSUE_PID ON dbo.ISSUE (PERSONNEL_ID);

CREATE TABLE IF NOT EXISTS dbo.ISSUE_APP (
  ISSUE_APP_ID varchar PRIMARY KEY,
  PERSONNEL_ID varchar,
  BUNDLE_ID varchar,
  KEY_ID varchar,
  DEVICE_ID varchar,
  SIGNATURE_ID varchar,
  REQUEST_DATE timestamp,
  REQUEST_TIME varchar,
  RETURN_DEADLINE_DATE timestamp,
  RETURN_DEADLINE_TIME varchar,
  SIGNATURE_DATE varchar,
  SIGNATURE_TIME varchar,
  STATUS varchar,
  PENDING varchar,
  NOTE_1 varchar,
  NOTE_2 varchar,
  NOTE_3 varchar,
  IMAGE_SIGNATURE varchar,
  DEPOSIT_REQUIRED varchar,
  HANDLER_ID varchar,
  SYSTEM_DATE timestamp,
  LAST_MODIFIED timestamp
);

CREATE UNIQUE INDEX IF NOT EXISTS dbo_PK_ISSUE_APP ON dbo.ISSUE_APP (ISSUE_APP_ID);


CREATE TABLE IF NOT EXISTS dbo.ISSUE_GV (
  ISSUE_GV_ID varchar PRIMARY KEY,
  ISSUE_ID varchar,
  PERSONNEL_ID varchar,
  REQUEST_DATE timestamp,
  REQUEST_TIME varchar,
  APPROVAL_DATE varchar,
  APPROVAL_TIME varchar,
  GV_PERSONNEL_ID_APPROVED varchar,
  NOTE_1 varchar,
  NOTE_2 varchar,
  NOTE_3 varchar,
  APPROVAL_TYPE varchar,
  STATUS varchar,
  APPROVAL_PROCESS int,
  ISSUE_DOCUMENT varchar,
  FUNCTION_DOCUMENT1 varchar,
  HANDLER_ID varchar,
  SYSTEM_DATE timestamp,
  LAST_MODIFIED timestamp
);

CREATE UNIQUE INDEX IF NOT EXISTS dbo_PK_ISSUE_GV ON dbo.ISSUE_GV (ISSUE_GV_ID);

CREATE TABLE IF NOT EXISTS dbo.ISSUE_SIWOS (
  ISSUE_SIWOS_ID varchar PRIMARY KEY,
  APPLICATION_TYPE varchar,
  APPLICATION_NUMBER_SIWOS varchar,
  PERSONNEL_ID_APPLICANT varchar,
  PERSONNEL_NR_APPLICANT varchar,
  PERSONNEL_ID_APPROVER varchar,
  PERSONNEL_NR_APPROVER varchar,
  PERSONNEL_ID_TRANSCRIBER varchar,
  PERSONNEL_NR_TRANSCRIBER varchar,
  PERSONNEL_ID_PICKUP varchar,
  PERSONNEL_NR_PICKUP varchar,
  BUNDLE_ID varchar,
  KEY_ID varchar,
  COPY_ID varchar,
  CYLINDER_ID varchar,
  SYSTEM varchar,
  KEY_NUMBER varchar,
  COPY_NUMBER int,
  EXECUTION varchar,
  DIMENSION_LEFT varchar,
  DIMENSION_RIGHT varchar,
  COLOR varchar,
  DOOR_NUMBER varchar,
  NEW_DOOR_NUMBER varchar,
  ROOM_DESCRIPTION varchar,
  NEW_ROOM_DESCRIPTION varchar,
  APPLICATION_DATE timestamp,
  APPLICATION_TIME varchar,
  STATUS varchar,
  STATUS_MAIL varchar,
  RESERVATION_UNTIL varchar,
  NOTE_1 varchar,
  NOTE_2 varchar,
  NOTE_3 varchar,
  HANDLER_ID varchar,
  SYSTEM_DATE timestamp,
  LAST_MODIFIED timestamp
);

CREATE UNIQUE INDEX IF NOT EXISTS dbo_PK_ISSUE_SIWOS ON dbo.ISSUE_SIWOS (ISSUE_SIWOS_ID);

CREATE TABLE IF NOT EXISTS dbo.ISSUE_SIWOS_ARCHIVE (
  ISSUE_SIWOS_ID varchar PRIMARY KEY,
  APPLICATION_TYPE varchar,
  APPLICATION_NUMBER_SIWOS varchar,
  PERSONNEL_ID_APPLICANT varchar,
  PERSONNEL_NR_APPLICANT varchar,
  PERSONNEL_ID_APPROVER varchar,
  PERSONNEL_NR_APPROVER varchar,
  PERSONNEL_ID_TRANSCRIBER varchar,
  PERSONNEL_NR_TRANSCRIBER varchar,
  PERSONNEL_ID_PICKUP varchar,
  PERSONNEL_NR_PICKUP varchar,
  BUNDLE_ID varchar,
  KEY_ID varchar,
  COPY_ID varchar,
  CYLINDER_ID varchar,
  SYSTEM varchar,
  KEY_NUMBER varchar,
  COPY_NUMBER int,
  EXECUTION varchar,
  DIMENSION_LEFT varchar,
  DIMENSION_RIGHT varchar,
  COLOR varchar,
  DOOR_NUMBER varchar,
  NEW_DOOR_NUMBER varchar,
  ROOM_DESCRIPTION varchar,
  NEW_ROOM_DESCRIPTION varchar,
  APPLICATION_DATE timestamp,
  APPLICATION_TIME varchar,
  STATUS varchar,
  STATUS_MAIL varchar,
  RESERVATION_UNTIL varchar,
  NOTE_1 varchar,
  NOTE_2 varchar,
  NOTE_3 varchar,
  HANDLER_ID varchar,
  SYSTEM_DATE timestamp,
  LAST_MODIFIED timestamp,
  SIWOS_GEN_ID float
);

CREATE UNIQUE INDEX IF NOT EXISTS dbo_PK_ISSUE_SIWOS_ARCHIVE ON dbo.ISSUE_SIWOS_ARCHIVE (ISSUE_SIWOS_ID);

CREATE TABLE IF NOT EXISTS dbo.ISSUE_HISTORY (
  ISSUE_HISTORY_ID varchar PRIMARY KEY,
  ISSUE_ID varchar,
  SYSTEM_ID varchar,
  COPY_ID varchar,
  PERSONNEL_ID varchar,
  KEY_ID varchar,
  ISSUE_DATE timestamp,
  ISSUE_TIME varchar,
  ISSUE_NR int,
  BUNDLE_ID varchar,
  KEY_NUMBER varchar,
  RETURN_DATE timestamp,
  RETURN_TIME varchar,
  HANDLER_ID varchar,
  HANDLER_RETURN_ID varchar,
  NOTE varchar,
  PENDING int,
  COPY_STATUS_ID int,
  ISSUE_PROCESS int,
  SIGNATURE_ID varchar,
  PERSONNEL_ID_PICKUP varchar,
  DEPOSIT float
);

CREATE UNIQUE INDEX IF NOT EXISTS dbo_PK_ISSUE_HISTORY ON dbo.ISSUE_HISTORY (ISSUE_HISTORY_ID);
CREATE INDEX IF NOT EXISTS dbo_IDX_ISSUE_HISTORY_KN ON dbo.ISSUE_HISTORY (KEY_NUMBER);
CREATE INDEX IF NOT EXISTS dbo_IDX_ISSUE_HISTORY_KID ON dbo.ISSUE_HISTORY (KEY_ID);
CREATE INDEX IF NOT EXISTS dbo_IDX_ISSUE_HISTORY_CID ON dbo.ISSUE_HISTORY (COPY_ID);
CREATE INDEX IF NOT EXISTS dbo_IDX_ISSUE_HISTORY_PID ON dbo.ISSUE_HISTORY (PERSONNEL_ID);

CREATE TABLE IF NOT EXISTS dbo.USER (
  USER_ID varchar PRIMARY KEY,
  USER_NR int,
  USER_IDENTIFIER varchar,
  "SYSTEM_USER" int,
  VIP_USER int,
  LAST_NAME varchar,
  FIRST_NAME varchar,
  PASSWORD varchar,
  SECURITY_QUESTION varchar,
  SECURITY_ANSWER varchar,
  DEPARTMENT varchar,
  ROOM varchar,
  PHONE varchar,
  EMAIL varchar,
  SYSTEM_DATE timestamp,
  LAST_MODIFIED timestamp,
  INACTIVE int,
  MENU int,
  HANDLER_ID varchar,
  TEMP_ID int,
  PW1 varchar,
  PW2 varchar,
  PW3 varchar,
  PW4 varchar,
  PW5 varchar,
  PW6 varchar,
  PW7 varchar,
  PW8 varchar,
  PW9 varchar,
  PASSWORD_DATE timestamp,
  FIN_AS2_ORD boolean
);

CREATE UNIQUE INDEX IF NOT EXISTS dbo_PK_USER ON dbo.USER (USER_ID);

CREATE TABLE IF NOT EXISTS dbo.ORDER_HEADER (
  ORDER_HEADER_ID varchar PRIMARY KEY,
  ORDER_HEADER_NR int,
  SYSTEM_ID varchar,
  SUPPLIER_ID varchar,
  HANDLER_ID varchar,
  ORDER_NUMBER varchar,
  COMMISSION_NUMBER varchar,
  EXTRA_1 varchar,
  EXTRA_2 varchar,
  EXTRA_3 varchar,
  ORDER_DATE timestamp,
  DELIVERY_DATE timestamp,
  NOTE_1 varchar,
  NOTE_2 varchar,
  NOTE_3 varchar,
  STATUS varchar,
  DELIVERY_NAME varchar,
  DELIVERY_EXTRA varchar,
  DELIVERY_STREET varchar,
  DELIVERY_COUNTRY_CODE varchar,
  DELIVERY_ZIP varchar,
  DELIVERY_CITY varchar,
  ORDER_TYPE varchar,
  CUSTOMER_NUMBER varchar,
  BOOKING_DATE timestamp,
  SECURITY_CARD varchar,
  LAST_MODIFIED timestamp,
  SYSTEM_DATE timestamp,
  SC_SYSTEM varchar,
  SC_TYPE varchar,
  SC_CARD_NUMBER varchar,
  SC_MANUFACTURER varchar,
  SC_ISSUE_DATE varchar,
  SC_CARD_STRING varchar,
  SC_PIN varchar,
  SC_TAN varchar,
  SC_USB_ID varchar,
  SC_CUSTOMER_NUMBER varchar,
  SC_SUPPLIER_ID varchar,
  SC_ENTRY_TYPE varchar,
  AS2_KEY varchar,
  AS2_STATUS varchar
);

CREATE UNIQUE INDEX IF NOT EXISTS dbo_PK_ORDER_HEADER ON dbo.ORDER_HEADER (ORDER_HEADER_ID);

CREATE TABLE IF NOT EXISTS dbo.ORDER_POSITION (
  ORDER_POSITION_ID varchar PRIMARY KEY,
  ORDER_POSITION_NR int,
  ORDER_HEADER_ID varchar,
  KEY_ID varchar,
  CYLINDER_ID varchar,
  SORT_POSITION smallint,
  ORDERED smallint,
  DELIVERED smallint,
  TOTAL smallint,
  NUMBER varchar,
  DESCRIPTION varchar,
  DELIVERY_DATE timestamp,
  BOOKING_DATE timestamp,
  EXTRA_1 varchar,
  EXTRA_2 varchar,
  NOTE_1 varchar,
  NOTE_2 varchar,
  STATUS varchar,
  Z_ORDERED smallint,
  Z_DELIVERED smallint,
  Z_TOTAL smallint,
  KEY_TYPE varchar,
  LAST_MODIFIED timestamp,
  SYSTEM_DATE timestamp
);

CREATE UNIQUE INDEX IF NOT EXISTS dbo_PK_ORDER_POSITION ON dbo.ORDER_POSITION (ORDER_POSITION_ID);
CREATE INDEX IF NOT EXISTS dbo_IDX_ORDER_POSITION_KID ON dbo.ORDER_POSITION (KEY_ID);
CREATE INDEX IF NOT EXISTS dbo_IDX_ORDER_POSITION_CID ON dbo.ORDER_POSITION (CYLINDER_ID);
CREATE INDEX IF NOT EXISTS dbo_IDX_ORDER_POSITION_OID ON dbo.ORDER_POSITION (ORDER_HEADER_ID);

CREATE TABLE IF NOT EXISTS dbo.BUNDLE (
  BUNDLE_ID varchar PRIMARY KEY,
  BUNDLE_NR int,
  SYSTEM_ID varchar,
  TIME_ZONE_ID varchar,
  COMPETENCE_LEVEL_ID int,
  COPY_STATUS_ID int,
  HANDLER_ID varchar,
  RECEIPT_TYPE_ID int,
  BUNDLE_NUMBER varchar,
  DESCRIPTION varchar,
  DEPARTMENT varchar,
  AREA varchar,
  COST_CENTER varchar,
  DEPOT_ID varchar,
  NOTE_1 varchar,
  NOTE_2 varchar,
  NOTE_3 varchar,
  LAST_MODIFIED timestamp,
  SYSTEM_DATE timestamp,
  DEPOSIT int,
  ACQUISITION int,
  CURRENCY varchar,
  TEMP_ID int
);

CREATE UNIQUE INDEX IF NOT EXISTS dbo_PK_BUNDLE ON dbo.BUNDLE (BUNDLE_ID);

CREATE TABLE IF NOT EXISTS dbo.CAD_PLAN (
  CAD_PLAN_ID varchar PRIMARY KEY,
  CAD_PLAN_NR int,
  BUILDING_ID varchar,
  PLAN_NAME varchar,
  PATH varchar,
  SCALE float,
  TEXT_HEIGHT float,
  COLOR int,
  LAYER int,
  PLAN_BLOB bytea,
  HANDLER_ID varchar,
  LAST_MODIFIED timestamp,
  SYSTEM_DATE timestamp
);

CREATE UNIQUE INDEX IF NOT EXISTS dbo_PK_CAD_PLAN ON dbo.CAD_PLAN (CAD_PLAN_ID);

CREATE TABLE IF NOT EXISTS dbo.CUSTOMIZATION (
  CUSTOMIZATION_ID varchar PRIMARY KEY,
  CUSTOMIZATION_NR int,
  DESCRIPTION varchar,
  VALUE varchar,
  CREATION_DATE timestamp,
  LAST_MODIFIED timestamp,
  VALUE_BLOB varchar
);

CREATE UNIQUE INDEX IF NOT EXISTS dbo_PK_CUSTOMIZATION ON dbo.CUSTOMIZATION (CUSTOMIZATION_ID);
CREATE INDEX IF NOT EXISTS dbo_IDX_CUSTOMIZATION_DESC ON dbo.CUSTOMIZATION (DESCRIPTION);

CREATE TABLE IF NOT EXISTS dbo.FILE_ARCHIVE (
  ARCHIVE_ID varchar PRIMARY KEY,
  DESCRIPTION varchar,
  CATEGORY varchar,
  KEYWORD varchar,
  FILE_NAME varchar,
  DATE timestamp,
  STAFF_ID varchar,
  ARCHIVE_PATH varchar,
  USER_FLAG varchar,
  CREATION_DATE timestamp,
  LAST_MODIFIED timestamp
);

CREATE UNIQUE INDEX IF NOT EXISTS dbo_PK_FILE_ARCHIVE ON dbo.FILE_ARCHIVE (ARCHIVE_ID);

CREATE TABLE IF NOT EXISTS dbo.STORAGE (
  STORAGE_ID varchar PRIMARY KEY,
  STORAGE_NR int,
  STORAGE_NUMBER int,
  DESCRIPTION varchar,
  STREET varchar,
  COUNTRY_CODE varchar,
  POSTAL_CODE varchar,
  CITY varchar,
  PHONE varchar,
  FAX varchar,
  RADIO varchar,
  EMAIL varchar,
  NOTE_1 varchar,
  NOTE_2 varchar,
  NOTE_3 varchar,
  COMPETENCE_LEVEL_ID int,
  STATUS int,
  STAFF_ID varchar,
  CREATION_DATE timestamp,
  LAST_MODIFIED timestamp,
  TEMP_ID int
);

CREATE UNIQUE INDEX IF NOT EXISTS dbo_PK_STORAGE ON dbo.STORAGE (STORAGE_ID);

CREATE TABLE IF NOT EXISTS dbo.COPY (
  COPY_ID varchar PRIMARY KEY,
  COPY_NR int,
  BUNDLE_ID varchar,
  COMPETENCE_LEVEL_ID int,
  KEY_ID varchar,
  RESERVATION_ID varchar DEFAULT (''),
  ISSUE_SIWOS_ID varchar DEFAULT (''),
  KEY_NUMBER varchar,
  COPY_STATUS_ID int,
  STAFF_ID varchar,
  STORAGE_ID varchar,
  STORAGE_STATUS int,
  SPECIAL_LABEL varchar,
  COPY_DESCRIPTION varchar,
  LAST_MODIFIED timestamp,
  COPY_NUMBER int,
  CREATION_DATE timestamp,
  TEMP_ID int,
  ISSUE_GV_ID varchar,
  ISSUE_APP_ID varchar,
  TRANSFER_FLAG int
);

CREATE UNIQUE INDEX IF NOT EXISTS dbo_PK_COPY ON dbo.COPY (COPY_ID);
CREATE INDEX IF NOT EXISTS dbo_IDX_KEY_ID ON dbo.COPY (KEY_ID);
CREATE INDEX IF NOT EXISTS dbo_IDX_COPY_KN ON dbo.COPY (KEY_NUMBER);
CREATE INDEX IF NOT EXISTS dbo_IDX_COPY_KID ON dbo.COPY (KEY_ID);

CREATE TABLE IF NOT EXISTS dbo.COPY_STATUS (
  COPY_STATUS_ID int PRIMARY KEY,
  DESCRIPTION varchar,
  LAST_MODIFIED timestamp,
  CREATION_DATE timestamp
);

CREATE UNIQUE INDEX IF NOT EXISTS dbo_PK_COPY_STATUS ON dbo.COPY_STATUS (COPY_STATUS_ID);

CREATE TABLE IF NOT EXISTS dbo.BUILDING (
  BUILDING_ID varchar PRIMARY KEY,
  BUILDING_NR int,
  DESCRIPTION varchar,
  BUILDING_SECTION varchar,
  NOTE_1 varchar,
  NOTE_2 varchar,
  NOTE_3 varchar,
  POSTAL_CODE varchar,
  CITY varchar,
  COUNTRY_CODE varchar,
  STREET varchar,
  STAFF_ID varchar,
  LAST_MODIFIED timestamp,
  CREATION_DATE timestamp,
  TEMP_ID int,
  EXTERNAL_BUILDING_ID varchar
);

CREATE UNIQUE INDEX IF NOT EXISTS dbo_PK_BUILDING ON dbo.BUILDING (BUILDING_ID);

CREATE TABLE IF NOT EXISTS dbo.FUNCTION (
  FUNCTION_ID varchar PRIMARY KEY,
  FUNCTION_NR int,
  PLANT_ID varchar,
  KEY_NUMBER_DEF varchar,
  KEY_NUMBER_OUT varchar,
  KEY_NUMBER_IN varchar,
  FUNCTION_DESCRIPTION varchar,
  PROCESSING_FLAG varchar,
  LAST_MODIFIED timestamp,
  CREATION_DATE timestamp,
  TIMEZONE_ID varchar,
  TEMP_ID int,
  EXTERNAL_FLAG varchar
);

CREATE UNIQUE INDEX IF NOT EXISTS dbo_PK_FUNCTION ON dbo.FUNCTION (FUNCTION_ID);
CREATE INDEX IF NOT EXISTS dbo_IDX_KEY_NUMBER_OUT ON dbo.FUNCTION (KEY_NUMBER_OUT);
CREATE INDEX IF NOT EXISTS dbo_IDX_KEY_NUMBER_IN ON dbo.FUNCTION (KEY_NUMBER_IN);
CREATE INDEX IF NOT EXISTS dbo_IDX_FUNCTION_PLANT_ID ON dbo.FUNCTION (PLANT_ID);
CREATE INDEX IF NOT EXISTS dbo_IDX_FUNCTION_PLANT_ID_KNO ON dbo.FUNCTION (PLANT_ID, KEY_NUMBER_OUT);
CREATE INDEX IF NOT EXISTS dbo_IDX_FUNCTION_PLANT_ID_KNI ON dbo.FUNCTION (PLANT_ID, KEY_NUMBER_IN);
CREATE INDEX IF NOT EXISTS dbo_IDX_FUNCTION_PLANT_ID_KND ON dbo.FUNCTION (PLANT_ID, KEY_NUMBER_DEF);

CREATE TABLE IF NOT EXISTS dbo.GROUP (
  GROUP_ID varchar PRIMARY KEY,
  GROUP_NR int,
  GROUP_NUMBER int,
  DESCRIPTION varchar,
  NOTE_1 varchar,
  NOTE_2 varchar,
  NOTE_3 varchar,
  STAFF_ID varchar,
  LAST_MODIFIED timestamp,
  CREATION_DATE timestamp
);

CREATE UNIQUE INDEX IF NOT EXISTS dbo_PK_GROUP ON dbo.GROUP (GROUP_ID);

CREATE TABLE IF NOT EXISTS dbo.DEALER (
  DEALER_ID varchar PRIMARY KEY,
  DEALER_NR int,
  DEALER_NUMBER varchar,
  CUSTOMER_NUMBER varchar,
  NAME_1 varchar,
  NAME_2 varchar,
  SALUTATION varchar,
  ADDITIONAL_INFO varchar,
  STREET varchar,
  COUNTRY_CODE varchar,
  POSTAL_CODE varchar,
  CITY varchar,
  PHONE varchar,
  RADIO varchar,
  FAX varchar,
  EMAIL varchar,
  WEBSITE varchar,
  DEALER_SINCE timestamp,
  CONTACT_NAME varchar,
  CONTACT_PHONE varchar,
  LAST_ORDER timestamp,
  NOTE varchar,
  STAFF_ID varchar,
  NOTE_1 varchar,
  NOTE_2 varchar,
  NOTE_3 varchar,
  CONTACT varchar,
  ORDER_EMAIL varchar,
  ORDER_KEY varchar,
  LAST_MODIFIED timestamp,
  CREATION_DATE timestamp,
  DEALER_ORDER_HANDLER_ID varchar
);

CREATE UNIQUE INDEX IF NOT EXISTS dbo_PK_DEALER ON dbo.DEALER (DEALER_ID);

CREATE TABLE IF NOT EXISTS dbo.LOG (
  ACTION varchar,
  TABLE_NAME varchar,
  ID varchar,
  NR varchar,
  COLUMN_NAME varchar,
  VALUE varchar,
  OLD_VALUE varchar,
  USER_ID varchar,
  CREATION_DATE timestamp
);

CREATE TABLE IF NOT EXISTS dbo.COMPETENCY_LEVEL (
  COMPETENCY_LEVEL_ID int PRIMARY KEY,
  DESCRIPTION varchar,
  LAST_MODIFIED timestamp,
  CREATION_DATE timestamp
);

CREATE UNIQUE INDEX IF NOT EXISTS dbo_PK_COMPETENCY_LEVEL ON dbo.COMPETENCY_LEVEL (COMPETENCY_LEVEL_ID);

CREATE TABLE IF NOT EXISTS dbo.LOG_DATA (
  LOG_ID varchar PRIMARY KEY,
  APPLICATION_NUMBER_SIWOS varchar,
  SERVICE_CALL varchar,
  REQUEST_DATE timestamp,
  REQUEST_TIME varchar,
  REQUEST_XML varchar,
  RESPONSE_DATE timestamp,
  RESPONSE_TIME varchar,
  RESPONSE_XML varchar,
  ERROR_STATUS varchar,
  ERROR_MESSAGE varchar
);

CREATE UNIQUE INDEX IF NOT EXISTS dbo_PK_LOG_DATA ON dbo.LOG_DATA (LOG_ID);

CREATE TABLE IF NOT EXISTS dbo.PERSONNEL (
  PERSONNEL_ID varchar PRIMARY KEY,
  PERSONNEL_NR int,
  VIP_LEVEL_ID int,
  COMPETENCY_LEVEL_ID int,
  PERSONNEL_NUMBER varchar,
  SEARCH_TERM varchar,
  SALUTATION varchar,
  FIRST_NAME varchar,
  LAST_NAME varchar,
  ADDITIONAL_INFO varchar,
  STREET varchar,
  COUNTRY_CODE varchar,
  POSTAL_CODE varchar,
  CITY varchar,
  BIRTH_DATE timestamp,
  TEMPLATE_DATE timestamp,
  DEPARTMENT varchar,
  DIVISION varchar,
  COST_CENTER varchar,
  OCCUPATION varchar,
  ROOM varchar,
  EMPLOYEE_GROUP varchar,
  TIMEZONE varchar,
  PRIVATE_PHONE varchar,
  COMPANY_PHONE varchar,
  FAX varchar,
  MOBILE varchar,
  EMAIL varchar,
  WEBSITE varchar,
  START_DATE timestamp,
  START_TIME varchar,
  END_DATE timestamp,
  END_TIME varchar,
  PIN varchar,
  NOTE_1 varchar,
  NOTE_2 varchar,
  NOTE_3 varchar,
  STAFF_ID varchar,
  RECEIPT_TYPE_ID int,
  CREATION_DATE timestamp,
  LAST_MODIFIED timestamp,
  TEMP_ID int,
  RFID varchar,
  APPROVER_STATUS varchar,
  TRANSFER_FLAG int
);

CREATE UNIQUE INDEX IF NOT EXISTS dbo_PK_PERSONNEL ON dbo.PERSONNEL (PERSONNEL_ID);
CREATE INDEX IF NOT EXISTS dbo_IDX_PERSONNEL_PNR ON dbo.PERSONNEL (PERSONNEL_NUMBER);
CREATE INDEX IF NOT EXISTS dbo_IDX_PERSONNEL_FN ON dbo.PERSONNEL (FIRST_NAME);
CREATE INDEX IF NOT EXISTS dbo_IDX_PERSONNEL_LN ON dbo.PERSONNEL (LAST_NAME);
CREATE INDEX IF NOT EXISTS dbo_IDX_PERSONNEL_ST ON dbo.PERSONNEL (SEARCH_TERM);

CREATE TABLE IF NOT EXISTS dbo.PERSONNEL_GV (
  PERSONNEL_GV_ID varchar PRIMARY KEY,
  PERSONNEL_ID varchar,
  DB_FIELD varchar,
  VALUE varchar,
  NOTE_1 varchar,
  NOTE_2 varchar,
  NOTE_3 varchar,
  STAFF_ID varchar,
  CREATION_DATE timestamp,
  LAST_MODIFIED timestamp
);

CREATE UNIQUE INDEX IF NOT EXISTS dbo_PK_PERSONNEL_GV ON dbo.PERSONNEL_GV (PERSONNEL_GV_ID);

CREATE TABLE IF NOT EXISTS dbo.PERSONNEL_IMAGE (
  PERSONNEL_IMAGE_ID varchar PRIMARY KEY,
  LAST_MODIFIED timestamp,
  CREATION_DATE timestamp,
  IMAGE bytea
);

CREATE UNIQUE INDEX IF NOT EXISTS dbo_PK_PERSONNEL_IMAGE ON dbo.PERSONNEL_IMAGE (PERSONNEL_IMAGE_ID);

CREATE TABLE IF NOT EXISTS dbo.QUICK_QUERIES (
  QUICK_QUERY_ID int PRIMARY KEY,
  USER_ID varchar,
  SYSTEM_ID varchar,
  BUILDING_ID varchar,
  TYPE varchar,
  QUERY_NAME varchar,
  QUERY_PARAMS varchar,
  CREATION_DATE timestamp,
  LAST_MODIFIED timestamp
);

CREATE UNIQUE INDEX IF NOT EXISTS dbo_PK_QUICK_QUERIES ON dbo.QUICK_QUERIES (QUICK_QUERY_ID);

CREATE TABLE IF NOT EXISTS dbo.RECEIPT_TYPE (
  RECEIPT_TYPE_ID int PRIMARY KEY,
  DESCRIPTION varchar,
  LAST_MODIFIED timestamp,
  CREATION_DATE timestamp
);

CREATE UNIQUE INDEX IF NOT EXISTS dbo_PK_RECEIPT_TYPE ON dbo.RECEIPT_TYPE (RECEIPT_TYPE_ID);

CREATE TABLE IF NOT EXISTS dbo.RE_SYSTEM_BUNDLE (
  SYSTEM_ID varchar,
  BUNDLE_ID varchar,
  PRIMARY KEY (SYSTEM_ID, BUNDLE_ID)
);

CREATE UNIQUE INDEX IF NOT EXISTS dbo_PK_RE_SYSTEM_BUNDLE ON dbo.RE_SYSTEM_BUNDLE (SYSTEM_ID, BUNDLE_ID);

CREATE TABLE IF NOT EXISTS dbo.RE_SYSTEM_DEPOT (
  SYSTEM_ID varchar,
  DEPOT_ID varchar,
  PRIMARY KEY (SYSTEM_ID, DEPOT_ID)
);

CREATE UNIQUE INDEX IF NOT EXISTS dbo_PK_RE_SYSTEM_DEPOT ON dbo.RE_SYSTEM_DEPOT (SYSTEM_ID, DEPOT_ID);

CREATE TABLE IF NOT EXISTS dbo.RE_SYSTEM_BUILDING (
  SYSTEM_ID varchar,
  BUILDING_ID varchar,
  PRIMARY KEY (SYSTEM_ID, BUILDING_ID)
);

CREATE UNIQUE INDEX IF NOT EXISTS dbo_PK_RE_SYSTEM_BUILDING ON dbo.RE_SYSTEM_BUILDING (SYSTEM_ID, BUILDING_ID);

CREATE TABLE IF NOT EXISTS dbo.RE_SYSTEM_PERSONNEL (
  SYSTEM_ID varchar,
  PERSONNEL_ID varchar,
  PRIMARY KEY (SYSTEM_ID, PERSONNEL_ID)
);

CREATE UNIQUE INDEX IF NOT EXISTS dbo_PK_RE_SYSTEM_PERSONNEL ON dbo.RE_SYSTEM_PERSONNEL (SYSTEM_ID, PERSONNEL_ID);

CREATE TABLE IF NOT EXISTS dbo.RE_SYSTEM_ROLE (
  SYSTEM_ID varchar,
  ROLE_ID varchar,
  PRIMARY KEY (SYSTEM_ID, ROLE_ID)
);

CREATE UNIQUE INDEX IF NOT EXISTS dbo_PK_RE_SYSTEM_ROLE ON dbo.RE_SYSTEM_ROLE (SYSTEM_ID, ROLE_ID);

CREATE TABLE IF NOT EXISTS dbo.RE_SYSTEM_ROLE_USER (
  SYSTEM_ID varchar,
  ROLE_ID varchar,
  USER_ID varchar,
  COMPETENCY_LEVEL_ID int,
  PRIMARY KEY (SYSTEM_ID, ROLE_ID, USER_ID)
);

CREATE UNIQUE INDEX IF NOT EXISTS dbo_PK_RE_SYSTEM_ROLE_USER ON dbo.RE_SYSTEM_ROLE_USER (SYSTEM_ID, ROLE_ID, USER_ID);

CREATE TABLE IF NOT EXISTS dbo.RE_ISSUE_GV_SPECIMEN (
  ISSUE_GV_ID varchar,
  ISSUE_ID varchar,
  SPECIMEN_ID varchar,
  PRIMARY KEY (ISSUE_GV_ID, ISSUE_ID, SPECIMEN_ID)
);

CREATE UNIQUE INDEX IF NOT EXISTS dbo_PK_ISSUE_GV_SPECIMEN ON dbo.RE_ISSUE_GV_SPECIMEN (ISSUE_GV_ID, ISSUE_ID, SPECIMEN_ID);

CREATE TABLE IF NOT EXISTS dbo.RE_ISSUE_GV_PERSONNEL (
  ISSUE_GV_ID varchar,
  ISSUE_ID varchar,
  PERSONNEL_ID varchar,
  PRIMARY KEY (ISSUE_GV_ID, ISSUE_ID, PERSONNEL_ID)
);

CREATE UNIQUE INDEX IF NOT EXISTS dbo_PK_ISSUE_GV_PERSONNEL ON dbo.RE_ISSUE_GV_PERSONNEL (ISSUE_GV_ID, ISSUE_ID, PERSONNEL_ID);

CREATE TABLE IF NOT EXISTS dbo.RE_USER_DEPOT (
  USER_ID varchar,
  DEPOT_ID varchar,
  PRIMARY KEY (DEPOT_ID, USER_ID)
);

CREATE UNIQUE INDEX IF NOT EXISTS dbo_PK_RE_USER_DEPOT ON dbo.RE_USER_DEPOT (DEPOT_ID, USER_ID);

CREATE TABLE IF NOT EXISTS dbo.RE_USER_LOCATION (
  USER_ID varchar,
  LOCATION_ID varchar,
  PRIMARY KEY (USER_ID, LOCATION_ID)
);

CREATE UNIQUE INDEX IF NOT EXISTS dbo_PK_RE_USER_LOCATION ON dbo.RE_USER_LOCATION (USER_ID, LOCATION_ID);

CREATE TABLE IF NOT EXISTS dbo.RE_USER_TILE_STRUCTURE (
  TILE_ID int PRIMARY KEY,
  USER_ID varchar,
  SYSTEM_BUILDING_ID varchar,
  SYSTEM_BUILDING_DESCRIPTION varchar,
  "SYSTEM_USER" int DEFAULT (0),
  ROLE_ID varchar,
  TILE_STRUCTURE varchar,
  CREATION_DATE timestamp,
  LAST_MODIFIED timestamp
);

CREATE UNIQUE INDEX IF NOT EXISTS dbo_PK_RE_USER_TILE_STRUCTURE ON dbo.RE_USER_TILE_STRUCTURE (TILE_ID);

CREATE TABLE IF NOT EXISTS dbo.RE_BUNDLE_DEISTER (
  BUNDLE_ID varchar PRIMARY KEY,
  BUNDLE_NR int,
  KEYTAG_ID int,
  CABINET_ID int,
  SLOT_NUMBER int,
  TRANSPONDER_STATE int,
  TERMINAL_DISPLAY_NAME varchar,
  MAKE varchar,
  MODEL varchar,
  SERIAL_NUMBER varchar,
  RESPONSIBLE_EMAIL varchar,
  CURRENT_TERMINAL_USER_ID_KEEPER int
);

CREATE UNIQUE INDEX IF NOT EXISTS dbo_PK_RE_BUNDLE_DEISTER ON dbo.RE_BUNDLE_DEISTER (BUNDLE_ID);

CREATE TABLE IF NOT EXISTS dbo.RE_SPECIMEN_DEISTER (
  SPECIMEN_ID varchar PRIMARY KEY,
  SPECIMEN_NR int,
  CABINET_ID int,
  SLOT_NUMBER int,
  TRANSPONDER_STATE int,
  KEYTAG_ID int,
  TERMINAL_DISPLAY_NAME varchar,
  MAKE varchar,
  MODEL varchar,
  SERIAL_NUMBER varchar,
  RESPONSIBLE_EMAIL varchar,
  CURRENT_TERMINAL_USER_ID_KEEPER int
);

CREATE UNIQUE INDEX IF NOT EXISTS dbo_PK_RE_SPECIMEN_DEISTER ON dbo.RE_SPECIMEN_DEISTER (SPECIMEN_ID);

CREATE TABLE IF NOT EXISTS dbo.RE_BUILDING_BUNDLE (
  BUILDING_ID varchar,
  BUNDLE_ID varchar,
  PRIMARY KEY (BUNDLE_ID, BUILDING_ID)
);

CREATE UNIQUE INDEX IF NOT EXISTS dbo_PK_RE_BUILDING_BUNDLE ON dbo.RE_BUILDING_BUNDLE (BUNDLE_ID, BUILDING_ID);

CREATE TABLE IF NOT EXISTS dbo.RE_BUILDING_DEPOT (
  BUILDING_ID varchar,
  DEPOT_ID varchar,
  PRIMARY KEY (DEPOT_ID, BUILDING_ID)
);

CREATE UNIQUE INDEX IF NOT EXISTS dbo_PK_RE_BUILDING_DEPOT ON dbo.RE_BUILDING_DEPOT (DEPOT_ID, BUILDING_ID);

CREATE TABLE IF NOT EXISTS dbo.RE_BUILDING_PERSONNEL (
  BUILDING_ID varchar,
  PERSONNEL_ID varchar,
  PRIMARY KEY (BUILDING_ID, PERSONNEL_ID)
);

CREATE UNIQUE INDEX IF NOT EXISTS dbo_PK_RE_BUILDING_PERSONNEL ON dbo.RE_BUILDING_PERSONNEL (BUILDING_ID, PERSONNEL_ID);

CREATE TABLE IF NOT EXISTS dbo.RE_BUILDING_ROLE (
  BUILDING_ID varchar,
  ROLE_ID varchar,
  PRIMARY KEY (BUILDING_ID, ROLE_ID)
);

CREATE UNIQUE INDEX IF NOT EXISTS dbo_PK_RE_BUILDING_ROLE ON dbo.RE_BUILDING_ROLE (BUILDING_ID, ROLE_ID);

CREATE TABLE IF NOT EXISTS dbo.RE_BUILDING_ROLE_USER (
  BUILDING_ID varchar,
  ROLE_ID varchar,
  USER_ID varchar,
  COMPETENCY_LEVEL_ID int,
  PRIMARY KEY (BUILDING_ID, ROLE_ID, USER_ID)
);

CREATE UNIQUE INDEX IF NOT EXISTS dbo_PK_RE_BUILDING_ROLE_USER ON dbo.RE_BUILDING_ROLE_USER (BUILDING_ID, ROLE_ID, USER_ID);

CREATE TABLE IF NOT EXISTS dbo.RE_PERSONAL_DEISTER (
  TERMINAL_USER_ID int,
  PERSONAL_DEISTER_NR int PRIMARY KEY,
  PERSONAL_ID varchar,
  PERSONAL_NR int,
  TERMINAL_DISPLAY varchar
);

CREATE UNIQUE INDEX IF NOT EXISTS dbo_PK_RE_PERSONAL_DEISTER ON dbo.RE_PERSONAL_DEISTER (PERSONAL_DEISTER_NR);

CREATE TABLE IF NOT EXISTS dbo.RE_PERSONAL_GROUP (
  PERSONAL_ID varchar,
  GROUP_ID varchar,
  PRIMARY KEY (PERSONAL_ID, GROUP_ID)
);

CREATE UNIQUE INDEX IF NOT EXISTS dbo_PK_RE_PERSONAL_GROUP ON dbo.RE_PERSONAL_GROUP (PERSONAL_ID, GROUP_ID);

CREATE TABLE IF NOT EXISTS dbo.RE_PERSONAL_LOCATION (
  PERSONAL_ID varchar,
  LOCATION_ID varchar,
  PRIMARY KEY (PERSONAL_ID, LOCATION_ID)
);

CREATE UNIQUE INDEX IF NOT EXISTS dbo_PK_RE_PERSONAL_LOCATION ON dbo.RE_PERSONAL_LOCATION (PERSONAL_ID, LOCATION_ID);

CREATE TABLE IF NOT EXISTS dbo.RE_KEY_GROUP (
  KEY_ID varchar,
  GROUP_ID varchar,
  PRIMARY KEY (KEY_ID, GROUP_ID)
);

CREATE UNIQUE INDEX IF NOT EXISTS dbo_PK_RE_KEY_GROUP ON dbo.RE_KEY_GROUP (KEY_ID, GROUP_ID);

CREATE TABLE IF NOT EXISTS dbo.RE_KEY_CYLINDER (
  KEY_ID varchar,
  CYLINDER_ID varchar,
  PRIMARY KEY (KEY_ID, CYLINDER_ID)
);

CREATE UNIQUE INDEX IF NOT EXISTS dbo_PK_RE_KEY_CYLINDER ON dbo.RE_KEY_CYLINDER (KEY_ID, CYLINDER_ID);
CREATE INDEX IF NOT EXISTS dbo_IDX_RE_KEY_CYLINDER_KEYID_CYLINDERID ON dbo.RE_KEY_CYLINDER (KEY_ID, CYLINDER_ID);
CREATE INDEX IF NOT EXISTS dbo_IDX_RE_KEY_CYLINDER_KEYID ON dbo.RE_KEY_CYLINDER (KEY_ID);
CREATE INDEX IF NOT EXISTS dbo_IDX_RE_KEY_CYLINDER_CYLINDERID ON dbo.RE_KEY_CYLINDER (CYLINDER_ID);

CREATE TABLE IF NOT EXISTS dbo.RE_DOOR_CYLINDER (
  DOOR_ID varchar,
  CYLINDER_ID varchar,
  PRIMARY KEY (DOOR_ID, CYLINDER_ID)
);

CREATE UNIQUE INDEX IF NOT EXISTS dbo_PK_RE_DOOR_CYLINDER ON dbo.RE_DOOR_CYLINDER (DOOR_ID, CYLINDER_ID);

CREATE TABLE IF NOT EXISTS dbo.RE_CYLINDER_CADPLAN (
  CYLINDER_ID varchar,
  CADPLAN_ID varchar,
  PRIMARY KEY (CADPLAN_ID, CYLINDER_ID)
);

CREATE UNIQUE INDEX IF NOT EXISTS dbo_PK_RE_CYLINDER_CADPLAN ON dbo.RE_CYLINDER_CADPLAN (CADPLAN_ID, CYLINDER_ID);
CREATE INDEX IF NOT EXISTS dbo_IDX_RE_CYLINDER_CADPLAN_CYLINDERID_CADPLANID ON dbo.RE_CYLINDER_CADPLAN (CYLINDER_ID, CADPLAN_ID);

CREATE TABLE IF NOT EXISTS dbo.REPORT (
  REPORT_ID varchar PRIMARY KEY,
  REPORT_NR int,
  REPORT_TYPE int,
  "GROUP" varchar,
  NAME varchar,
  NOTE_1 varchar,
  NOTE_2 varchar,
  NOTE_3 varchar,
  CONTROL int,
  REPORT_EDITABLE int,
  SQL_TEXT varchar,
  LAST_MODIFIED timestamp,
  CREATION_DATE timestamp,
  REPORT_NUMBER varchar
);

CREATE UNIQUE INDEX IF NOT EXISTS dbo_PK_REPORT ON dbo.REPORT (REPORT_ID);

CREATE TABLE IF NOT EXISTS dbo.REPORT_BIN (
  REPORT_BIN_ID varchar PRIMARY KEY,
  REPORT_BIN_NR int,
  REPORT_ID varchar,
  LANGUAGE_ID int,
  DESCRIPTION varchar,
  REPORT_PATH varchar,
  REPORT_BIN bytea,
  LAST_MODIFIED timestamp,
  CREATION_DATE timestamp,
  HANDLER_ID varchar,
  REPORT_VARIANT int
);

CREATE UNIQUE INDEX IF NOT EXISTS dbo_PK_REPORT_BIN ON dbo.REPORT_BIN (REPORT_BIN_ID);

CREATE TABLE IF NOT EXISTS dbo.ROLE (
  ROLE_ID varchar PRIMARY KEY,
  ROLE_NR int,
  LEVEL int,
  DESCRIPTION varchar,
  CREATION_DATE timestamp,
  LAST_MODIFIED timestamp
);

CREATE UNIQUE INDEX IF NOT EXISTS dbo_PK_ROLE ON dbo.ROLE (ROLE_ID);

CREATE TABLE IF NOT EXISTS dbo.LOCK_MATRIX (
  LOCK_MATRIX_ID varchar PRIMARY KEY,
  NUMBER int,
  LOCK_MATRIX_NR int,
  DESCRIPTION varchar,
  PERIODIC varchar,
  DATE_FLAG varchar,
  DATE_SET text,
  TIME_SET text,
  HOLIDAY_SET text,
  HANDLER_ID varchar,
  STATUS varchar,
  LAST_MODIFIED timestamp,
  CREATION_DATE timestamp,
  TEMP_ID int
);

CREATE UNIQUE INDEX IF NOT EXISTS dbo_PK_LOCK_MATRIX ON dbo.LOCK_MATRIX (LOCK_MATRIX_ID);

CREATE TABLE IF NOT EXISTS dbo.KEY (
  KEY_ID varchar PRIMARY KEY,
  KEY_NR int,
  FACILITY_ID varchar,
  TIMEZONE_ID varchar,
  COMPETENCY_LEVEL_ID int,
  NODE int,
  KEY_NUMBER varchar,
  ADDITIONAL_KEY_NUMBER varchar,
  KEY_DESCRIPTION varchar,
  KEY_NAME varchar,
  KEY_TYPE smallint,
  LOCK_TYPE smallint,
  KEY_CATEGORY smallint,
  MINIMUM_STOCK int,
  ORDER_SUGGESTION int,
  NOTE_1 varchar,
  NOTE_2 varchar,
  NOTE_3 varchar,
  ITEM_NR varchar,
  HANDLER_ID varchar,
  SORT_ORDER int,
  SPECIAL_LABEL varchar,
  EXTERNAL_DEPOT int,
  RECEIPT_TYPE_ID int,
  DEPOSIT int,
  ACQUISITION int,
  CURRENCY varchar,
  TEMP_ID int,
  EXTENSION int,
  FOREIGN_KEY_ID varchar,
  PIN varchar,
  WORK varchar,
  LAST_MODIFIED timestamp,
  CREATION_DATE timestamp,
  EXTERNAL_FLAG varchar,
  SENSITIVE varchar,
  APPROVAL_FLAG varchar,
  TRANSFER_FLAG int
);

CREATE UNIQUE INDEX IF NOT EXISTS dbo_PK_KEY ON dbo.KEY (KEY_ID);
CREATE INDEX IF NOT EXISTS dbo_IDX_KEY_KEYNUMBER ON dbo.KEY (KEY_NUMBER);
CREATE INDEX IF NOT EXISTS dbo_IDX_KEY_DESCRIPTION ON dbo.KEY (KEY_DESCRIPTION);
CREATE INDEX IF NOT EXISTS dbo_IDX_KEY_FACILITYID ON dbo.KEY (FACILITY_ID);

CREATE TABLE IF NOT EXISTS dbo.KEY_SIWOS_DELTA (
  KEY_ID varchar PRIMARY KEY,
  WORK varchar,
  MANUFACTURER varchar,
  LOCK_SYSTEM varchar,
  KEY_NUMBER varchar,
  STATUS varchar,
  TRANSFER_FLAG int,
  TRANSFER_FLAG_FACILITY int,
  CREATION_DATE timestamp,
  LAST_MODIFIED timestamp
);

CREATE UNIQUE INDEX IF NOT EXISTS dbo_PK_KEY_SIWOS_DELTA ON dbo.KEY_SIWOS_DELTA (KEY_ID);

CREATE TABLE IF NOT EXISTS dbo.LOCATION (
  LOCATION_ID varchar PRIMARY KEY,
  LOCATION_NR int,
  LOCATION_NUMBER int,
  DESCRIPTION varchar,
  STREET varchar,
  COUNTRY_CODE varchar,
  ZIP_CODE varchar,
  CITY varchar,
  PHONE varchar,
  FAX varchar,
  MOBILE varchar,
  EMAIL varchar,
  NOTE_1 varchar,
  NOTE_2 varchar,
  NOTE_3 varchar,
  STATUS int,
  HANDLER_ID varchar,
  CREATION_DATE timestamp,
  LAST_MODIFIED timestamp,
  TEMP_ID int
);

CREATE UNIQUE INDEX IF NOT EXISTS dbo_PK_LOCATION ON dbo.LOCATION (LOCATION_ID);

CREATE TABLE IF NOT EXISTS dbo.SYS_ADDON (
  SYS_ADDON_ID varchar PRIMARY KEY,
  SYS_ADDON_NR int,
  TYPE varchar,
  DESCRIPTION varchar,
  PROGRAM varchar,
  CODE int,
  HINT varchar,
  FIELD_A varchar,
  FIELD_B varchar,
  STATUS varchar,
  CREATION_DATE timestamp,
  LAST_MODIFIED timestamp
);

CREATE UNIQUE INDEX IF NOT EXISTS dbo_PK_SYS_ADDON ON dbo.SYS_ADDON (SYS_ADDON_ID);

CREATE TABLE IF NOT EXISTS dbo.SYS_LOOKUP_TABLE (
  SYS_LOOKUP_TABLE_ID varchar PRIMARY KEY,
  SYS_LOOKUP_TABLE_NR int,
  TYPE int,
  DESCRIPTION varchar,
  VALUE varchar,
  HANDLER_ID varchar,
  CREATION_DATE timestamp,
  LAST_MODIFIED timestamp
);

CREATE UNIQUE INDEX IF NOT EXISTS dbo_PK_SYS_LOOKUP_TABLE ON dbo.SYS_LOOKUP_TABLE (SYS_LOOKUP_TABLE_ID);

CREATE TABLE IF NOT EXISTS dbo.TMP_PRINT (
  PROCESS_ID varchar,
  SOURCE_ID varchar,
  OLD_VALUE_ID varchar,
  NEW_VALUE_ID varchar,
  OLD_TEXT varchar,
  NEW_TEXT varchar,
  HANDLER_ID varchar,
  CHANGE_DATE timestamp,
  CREATION_DATE timestamp,
  PRIMARY KEY (PROCESS_ID, SOURCE_ID)
);

CREATE UNIQUE INDEX IF NOT EXISTS dbo_PK_TMP_PRINT ON dbo.TMP_PRINT (PROCESS_ID, SOURCE_ID);

CREATE TABLE IF NOT EXISTS dbo.DOOR (
  DOOR_ID varchar PRIMARY KEY,
  BUILDING_ID varchar,
  DOORNR int,
  DESCRIPTION varchar,
  SHORT_NOTE varchar,
  DOOR_NR varchar,
  ELECTRIC_DOOR varchar,
  ROOM_DESCRIPTION varchar,
  DEPARTMENT varchar,
  AREA varchar,
  COST_CENTER varchar,
  ADDITIONAL_1 varchar,
  ADDITIONAL_2 varchar,
  NOTE_1 varchar,
  NOTE_2 varchar,
  NOTE_3 varchar,
  INSTALLATION_STATUS int,
  TEMP_ID int,
  FOREIGN_DOOR_ID varchar,
  HANDLER_ID varchar,
  LAST_MODIFIED timestamp,
  CREATION_DATE timestamp
);

CREATE UNIQUE INDEX IF NOT EXISTS dbo_PK_DOOR ON dbo.DOOR (DOOR_ID);

CREATE TABLE IF NOT EXISTS dbo.SIGNATURE (
  SIGNATURE_ID varchar PRIMARY KEY,
  SIGNATURE_NR int,
  PERSONAL_ID varchar,
  HANDLER_ID varchar,
  LAST_MODIFIED timestamp,
  CREATION_DATE timestamp,
  IMAGE bytea
);

CREATE UNIQUE INDEX IF NOT EXISTS dbo_PK_SIGNATURE ON dbo.SIGNATURE (SIGNATURE_ID);

CREATE TABLE IF NOT EXISTS dbo.VIP_LEVEL (
  VIP_LEVEL_ID int PRIMARY KEY,
  DESCRIPTION varchar,
  CREATION_DATE timestamp,
  LAST_MODIFIED timestamp
);

CREATE UNIQUE INDEX IF NOT EXISTS dbo_PK_VIP_LEVEL ON dbo.VIP_LEVEL (VIP_LEVEL_ID);

CREATE TABLE IF NOT EXISTS dbo.TIMEZONE (
  TIMEZONE_ID varchar PRIMARY KEY,
  TIMEZONE_NR int,
  TIMEZONE_DESCRIPTION varchar,
  TIME_PERIOD varchar,
  WEEKDAYS varchar,
  TIME_OF_DAY varchar,
  D1 varchar,
  D2 varchar,
  D3 varchar,
  D4 varchar,
  D5 varchar,
  D6 varchar,
  D7 varchar,
  DATE_FROM timestamp,
  DATE_TO timestamp,
  TIME_FROM varchar,
  TIME_TO varchar,
  STATUS varchar,
  HANDLER_ID varchar,
  CREATION_DATE timestamp,
  LAST_MODIFIED timestamp,
  TEMP_ID int
);

CREATE UNIQUE INDEX IF NOT EXISTS dbo_PK_TIMEZONE ON dbo.TIMEZONE (TIMEZONE_ID);

CREATE TABLE IF NOT EXISTS dbo.ACCESS (
  ACCESS_ID varchar PRIMARY KEY,
  ACCESS_NR int,
  "GROUP" varchar,
  ACTION varchar,
  LEVEL int,
  COMPETENCE int,
  LAST_MODIFIED timestamp,
  CREATION_DATE timestamp
);

CREATE UNIQUE INDEX IF NOT EXISTS dbo_PK_ACCESS ON dbo.ACCESS (ACCESS_ID);

CREATE TABLE IF NOT EXISTS dbo.CYLINDER (
  CYLINDER_ID varchar PRIMARY KEY,
  CYLINDER_NR int,
  FACILITY_ID varchar,
  BUILDING_ID varchar,
  CADPLAN_ID varchar,
  COMPETENCE_LEVEL_ID int,
  EXECUTION_ID int,
  KEY_NUMBER varchar,
  DESCRIPTION varchar,
  POSITION varchar,
  CYLINDER_COUNT int,
  SHORT_NOTE varchar,
  ORDER_SUGGESTION int,
  DOOR_NR varchar,
  ROOM_DESCRIPTION varchar,
  DEPARTMENT varchar,
  AREA varchar,
  COST_CENTER varchar,
  COLOR varchar,
  ELECTRIC_DOOR varchar,
  ADDITIONAL_1 varchar,
  ADDITIONAL_2 varchar,
  DIMENSIONS varchar,
  DIMENSION_LEFT numeric(6, 1),
  DIMENSION_RIGHT numeric(6, 1),
  NOTE_1 varchar,
  NOTE_2 varchar,
  NOTE_3 varchar,
  INSTALLATION_STATUS int,
  ARTICLE_NR varchar,
  SORT_ORDER numeric(8, 2),
  SPECIAL_EXECUTION varchar,
  SPECIAL_EXECUTION_POSITION varchar,
  SPECIAL_POSITION varchar,
  XVALUE float,
  YVALUE float,
  ZVALUE float,
  HANDLER_ID varchar,
  DEPOSIT numeric(8, 2),
  PURCHASE numeric(8, 2),
  CURRENCY varchar,
  TEMP_ID int,
  EXTENSION int,
  FOREIGN_CYLINDER_ID varchar,
  FACTORY varchar,
  LAST_MODIFIED timestamp,
  CREATION_DATE timestamp,
  ARTICLE_DESCRIPTION varchar,
  EXTERNAL_FLAG varchar,
  TRANSFER_FLAG int,
  KEY_ID varchar DEFAULT ('')
);

CREATE UNIQUE INDEX IF NOT EXISTS dbo_PK_CYLINDER ON dbo.CYLINDER (CYLINDER_ID);
CREATE INDEX IF NOT EXISTS dbo_IDX_CYLINDER_SN ON dbo.CYLINDER (KEY_NUMBER);
CREATE INDEX IF NOT EXISTS dbo_IDX_CYLINDER_DESC ON dbo.CYLINDER (DESCRIPTION);
CREATE INDEX IF NOT EXISTS dbo_IDX_CYLINDER_FACILITY_ID ON dbo.CYLINDER (FACILITY_ID);
CREATE INDEX IF NOT EXISTS dbo_IDX_CYLINDER_BUILDING_ID ON dbo.CYLINDER (BUILDING_ID);
CREATE INDEX IF NOT EXISTS dbo_IDX_CYLINDER_DOOR_NR ON dbo.CYLINDER (DOOR_NR);
CREATE INDEX IF NOT EXISTS dbo_IDX_CYLINDER_ROOM_DESC ON dbo.CYLINDER (ROOM_DESCRIPTION);

CREATE TABLE IF NOT EXISTS dbo.CYLINDER_SIWOS_DELTA (
  CYLINDER_ID varchar PRIMARY KEY,
  FACTORY varchar,
  LOCKING_SYSTEM varchar,
  KEY_NUMBER varchar,
  STATUS varchar,
  TRANSFER_FLAG int,
  TRANSFER_FLAG_SYSTEM int,
  CREATION_DATE timestamp,
  LAST_MODIFIED timestamp
);

CREATE UNIQUE INDEX IF NOT EXISTS dbo_PK_CYLINDER_SIWOS_DELTA ON dbo.CYLINDER_SIWOS_DELTA (CYLINDER_ID);

CREATE TABLE IF NOT EXISTS dbo.CYLINDER_HISTORY (
  CYLINDER_ID varchar,
  CYLINDER_NR int,
  FACILITY_ID varchar,
  BUILDING_ID varchar,
  COMPETENCE_LEVEL_ID int,
  EXECUTION_ID int,
  DESCRIPTION varchar,
  POSITION varchar,
  CYLINDER_COUNT int,
  SHORT_NOTE varchar,
  ORDER_SUGGESTION int,
  DOOR_NR varchar,
  ROOM_DESCRIPTION varchar,
  DEPARTMENT varchar,
  AREA varchar,
  COST_CENTER varchar,
  COLOR varchar,
  ELECTRIC_DOOR varchar,
  ADDITIONAL_1 varchar,
  ADDITIONAL_2 varchar,
  DIMENSIONS varchar,
  DIMENSION_LEFT numeric(6, 1),
  DIMENSION_RIGHT numeric(6, 1),
  NOTE_1 varchar,
  NOTE_2 varchar,
  NOTE_3 varchar,
  INSTALLATION_STATUS int,
  ARTICLE_NR varchar,
  SORT_ORDER numeric(8, 2),
  SPECIAL_EXECUTION varchar,
  SPECIAL_EXECUTION_POSITION varchar,
  SPECIAL_POSITION varchar,
  XVALUE int,
  YVALUE int,
  HANDLER_ID varchar,
  CREATION_DATE timestamp,
  DEPOSIT numeric(8, 2),
  PURCHASE numeric(8, 2),
  CURRENCY varchar
);

CREATE INDEX IF NOT EXISTS dbo_IDX_CYLINDER_HISTORY_CYLINDER_ID ON dbo.CYLINDER_HISTORY (CYLINDER_ID);
CREATE INDEX IF NOT EXISTS dbo_IDX_CYLINDER_HISTORY_FACILITY_ID ON dbo.CYLINDER_HISTORY (FACILITY_ID);
CREATE INDEX IF NOT EXISTS dbo_IDX_CYLINDER_HISTORY_BUILDING_ID ON dbo.CYLINDER_HISTORY (BUILDING_ID);

