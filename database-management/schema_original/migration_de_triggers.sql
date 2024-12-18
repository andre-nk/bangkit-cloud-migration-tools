CREATE TRIGGER INSUPD_ANLAGE
   ON DBO.ANLAGE
   AFTER INSERT, UPDATE
AS
BEGIN
	SET NOCOUNT ON
	IF EXISTS(SELECT * FROM DELETED) AND EXISTS(SELECT * FROM INSERTED)
	BEGIN
		UPDATE DBO.ANLAGE SET LETZTEAENDERUNG = GETDATE() WHERE ANLAGE_ID = (SELECT ANLAGE_ID FROM DELETED)
	END ELSE IF EXISTS(SELECT * FROM INSERTED) AND ((SELECT ANLAGEDATUM FROM INSERTED) IS NULL)
		UPDATE DBO.ANLAGE SET ANLAGEDATUM = GETDATE(), LETZTEAENDERUNG = GETDATE() WHERE ANLAGE_ID = (SELECT ANLAGE_ID FROM INSERTED)
END;

CREATE TRIGGER INSUPD_AUSFUEHRUNG
   ON DBO.AUSFUEHRUNG
   AFTER INSERT, UPDATE
AS
BEGIN
	SET NOCOUNT ON
	IF EXISTS(SELECT * FROM DELETED) AND EXISTS(SELECT * FROM INSERTED)
	BEGIN
		UPDATE DBO.AUSFUEHRUNG SET LETZTEAENDERUNG = GETDATE() WHERE AUSFUEHRUNG_ID = (SELECT AUSFUEHRUNG_ID FROM DELETED)
	END ELSE IF EXISTS(SELECT * FROM INSERTED) AND ((SELECT ANLAGEDATUM FROM INSERTED) IS NULL)
		UPDATE DBO.AUSFUEHRUNG SET ANLAGEDATUM = GETDATE(), LETZTEAENDERUNG = GETDATE() WHERE AUSFUEHRUNG_ID = (SELECT AUSFUEHRUNG_ID FROM INSERTED)
END;

CREATE TRIGGER [dbo].[INSUPD_AUSGABE]
   ON [dbo].[AUSGABE]
   AFTER INSERT, UPDATE
AS
BEGIN
	SET NOCOUNT ON
	IF EXISTS(SELECT * FROM DELETED) AND EXISTS(SELECT * FROM INSERTED)
	BEGIN
		UPDATE DBO.AUSGABE SET LETZTEAENDERUNG = GETDATE()
		FROM DBO.AUSGABE A
		INNER JOIN Inserted I ON A.AUSGABE_ID = I.AUSGABE_ID AND A.EXEMPLAR_ID = I.EXEMPLAR_ID
	END ELSE IF EXISTS(SELECT * FROM INSERTED) AND ((SELECT ANLAGEDATUM FROM INSERTED) IS NULL)
		UPDATE DBO.AUSGABE SET ANLAGEDATUM = GETDATE(), LETZTEAENDERUNG = GETDATE()
		FROM DBO.AUSGABE A
		INNER JOIN Inserted I ON A.AUSGABE_ID = I.AUSGABE_ID AND A.EXEMPLAR_ID = I.EXEMPLAR_ID
END;

CREATE TRIGGER INSUPD_AUSGABE_APP
   ON DBO.AUSGABE_APP
   AFTER INSERT, UPDATE
AS
BEGIN
	SET NOCOUNT ON
	IF EXISTS(SELECT * FROM DELETED) AND EXISTS(SELECT * FROM INSERTED)
	BEGIN
		UPDATE DBO.AUSGABE_APP SET LETZTEAENDERUNG = GETDATE() WHERE AUSGABE_APP_ID = (SELECT AUSGABE_APP_ID FROM DELETED)
	END ELSE IF EXISTS(SELECT * FROM INSERTED) AND ((SELECT ANLAGEDATUM FROM INSERTED) IS NULL)
		UPDATE DBO.AUSGABE_APP SET ANLAGEDATUM = GETDATE(), LETZTEAENDERUNG = GETDATE() WHERE AUSGABE_APP_ID = (SELECT AUSGABE_APP_ID FROM INSERTED)
END;

CREATE TRIGGER INSUPD_AUSGABE_GV
   ON DBO.AUSGABE_GV
   AFTER INSERT, UPDATE
AS
BEGIN
	SET NOCOUNT ON
	IF EXISTS(SELECT * FROM DELETED) AND EXISTS(SELECT * FROM INSERTED)
	BEGIN
		UPDATE DBO.AUSGABE_GV SET LETZTEAENDERUNG = GETDATE() WHERE AUSGABE_GV_ID = (SELECT AUSGABE_GV_ID FROM DELETED)
	END ELSE IF EXISTS(SELECT * FROM INSERTED) AND ((SELECT ANLAGEDATUM FROM INSERTED) IS NULL)
		UPDATE DBO.AUSGABE_GV SET ANLAGEDATUM = GETDATE(), LETZTEAENDERUNG = GETDATE() WHERE AUSGABE_GV_ID = (SELECT AUSGABE_GV_ID FROM INSERTED)
END;

CREATE TRIGGER INSUPD_AUSGABE_SIWOS
   ON DBO.AUSGABE_SIWOS
   AFTER INSERT, UPDATE
AS
BEGIN
	SET NOCOUNT ON
	IF EXISTS(SELECT * FROM DELETED) AND EXISTS(SELECT * FROM INSERTED)
	BEGIN
		UPDATE DBO.AUSGABE_SIWOS SET LETZTEAENDERUNG = GETDATE() WHERE AUSGABE_SIWOS_ID = (SELECT AUSGABE_SIWOS_ID FROM DELETED)
	END ELSE IF EXISTS(SELECT * FROM INSERTED) AND ((SELECT ANLAGEDATUM FROM INSERTED) IS NULL)
		UPDATE DBO.AUSGABE_SIWOS SET ANLAGEDATUM = GETDATE(), LETZTEAENDERUNG = GETDATE() WHERE AUSGABE_SIWOS_ID = (SELECT AUSGABE_SIWOS_ID FROM INSERTED)
END;

CREATE TRIGGER INSUPD_BENUTZER
   ON DBO.BENUTZER
   AFTER INSERT, UPDATE
AS
BEGIN
	SET NOCOUNT ON
	IF EXISTS(SELECT * FROM DELETED) AND EXISTS(SELECT * FROM INSERTED)
	BEGIN
		UPDATE DBO.BENUTZER SET LETZTEAENDERUNG = GETDATE() WHERE BENUTZER_ID = (SELECT BENUTZER_ID FROM DELETED)
	END ELSE IF EXISTS(SELECT * FROM INSERTED) AND ((SELECT ANLAGEDATUM FROM INSERTED) IS NULL)
		UPDATE DBO.BENUTZER SET ANLAGEDATUM = GETDATE(), LETZTEAENDERUNG = GETDATE() WHERE BENUTZER_ID = (SELECT BENUTZER_ID FROM INSERTED)
END;

CREATE TRIGGER INSUPD_BESTELLKOPF
   ON DBO.BESTELLKOPF
   AFTER INSERT, UPDATE
AS
BEGIN
	SET NOCOUNT ON
	IF EXISTS(SELECT * FROM DELETED) AND EXISTS(SELECT * FROM INSERTED)
	BEGIN
		UPDATE DBO.BESTELLKOPF SET LETZTEAENDERUNG = GETDATE() WHERE BESTELLKOPF_ID = (SELECT BESTELLKOPF_ID FROM DELETED)
	END ELSE IF EXISTS(SELECT * FROM INSERTED) AND ((SELECT ANLAGEDATUM FROM INSERTED) IS NULL)
		UPDATE DBO.BESTELLKOPF SET ANLAGEDATUM = GETDATE(), LETZTEAENDERUNG = GETDATE() WHERE BESTELLKOPF_ID = (SELECT BESTELLKOPF_ID FROM INSERTED)
END;

CREATE TRIGGER INSUPD_BESTELLPOSITION
   ON DBO.BESTELLPOSITION
   AFTER INSERT, UPDATE
AS
BEGIN
	SET NOCOUNT ON
	IF EXISTS(SELECT * FROM DELETED) AND EXISTS(SELECT * FROM INSERTED)
	BEGIN
		UPDATE DBO.BESTELLPOSITION SET LETZTEAENDERUNG = GETDATE() WHERE BESTELLPOSITION_ID = (SELECT BESTELLPOSITION_ID FROM DELETED)
	END ELSE IF EXISTS(SELECT * FROM INSERTED) AND ((SELECT ANLAGEDATUM FROM INSERTED) IS NULL)
		UPDATE DBO.BESTELLPOSITION SET ANLAGEDATUM = GETDATE(), LETZTEAENDERUNG = GETDATE() WHERE BESTELLPOSITION_ID = (SELECT BESTELLPOSITION_ID FROM INSERTED)
END;

CREATE TRIGGER INSUPD_BUND
   ON DBO.BUND
   AFTER INSERT, UPDATE
AS
BEGIN
	SET NOCOUNT ON
	IF EXISTS(SELECT * FROM DELETED) AND EXISTS(SELECT * FROM INSERTED)
	BEGIN
		UPDATE DBO.BUND SET LETZTEAENDERUNG = GETDATE() WHERE BUND_ID = (SELECT BUND_ID FROM DELETED)
	END ELSE IF EXISTS(SELECT * FROM INSERTED) AND ((SELECT ANLAGEDATUM FROM INSERTED) IS NULL)
		UPDATE DBO.BUND SET ANLAGEDATUM = GETDATE(), LETZTEAENDERUNG = GETDATE() WHERE BUND_ID = (SELECT BUND_ID FROM INSERTED)
END;

CREATE TRIGGER INSUPD_CADPLAN
   ON DBO.CADPLAN
   AFTER INSERT, UPDATE
AS
BEGIN
	SET NOCOUNT ON
	IF EXISTS(SELECT * FROM DELETED) AND EXISTS(SELECT * FROM INSERTED)
	BEGIN
		UPDATE DBO.CADPLAN SET LETZTEAENDERUNG = GETDATE() WHERE CADPLAN_ID = (SELECT CADPLAN_ID FROM DELETED)
	END ELSE IF EXISTS(SELECT * FROM INSERTED) AND ((SELECT ANLAGEDATUM FROM INSERTED) IS NULL)
		UPDATE DBO.CADPLAN SET ANLAGEDATUM = GETDATE(), LETZTEAENDERUNG = GETDATE() WHERE CADPLAN_ID = (SELECT CADPLAN_ID FROM INSERTED)
END;

CREATE TRIGGER INSUPD_CUSTOMIZE
   ON DBO.CUSTOMIZE
   AFTER INSERT, UPDATE
AS
BEGIN
	SET NOCOUNT ON
	IF EXISTS(SELECT * FROM DELETED) AND EXISTS(SELECT * FROM INSERTED)
	BEGIN
		UPDATE DBO.CUSTOMIZE SET LETZTEAENDERUNG = GETDATE() WHERE CUSTOMIZE_ID = (SELECT CUSTOMIZE_ID FROM DELETED)
	END ELSE IF EXISTS(SELECT * FROM INSERTED) AND ((SELECT ANLAGEDATUM FROM INSERTED) IS NULL)
		UPDATE DBO.CUSTOMIZE SET ANLAGEDATUM = GETDATE(), LETZTEAENDERUNG = GETDATE() WHERE CUSTOMIZE_ID = (SELECT CUSTOMIZE_ID FROM INSERTED)
END;

CREATE TRIGGER [DBO].[INSUPD_DATEIARCHIV] 
ON [DBO].[DATEIARCHIV] 
AFTER INSERT, UPDATE 
AS 
BEGIN 
SET NOCOUNT ON; 
UPDATE d 
SET ANLAGEDATUM = GETDATE() 
FROM dbo.DATEIARCHIV d	
INNER JOIN INSERTED i ON d.ARCHIVE_ID = i.ARCHIVE_ID 
WHERE d.ANLAGEDATUM IS NULL;	
UPDATE d 
SET LETZTEAENDERUNG = GETDATE() 
FROM dbo.DATEIARCHIV d	
INNER JOIN INSERTED i ON d.ARCHIVE_ID = i.ARCHIVE_ID 
WHERE d.LETZTEAENDERUNG IS NULL OR d.ANLAGEDATUM IS NOT NULL; 
END;

CREATE TRIGGER INSUPD_DEPOT
   ON DBO.DEPOT
   AFTER INSERT, UPDATE
AS
BEGIN
	SET NOCOUNT ON
	IF EXISTS(SELECT * FROM DELETED) AND EXISTS(SELECT * FROM INSERTED)
	BEGIN
		UPDATE DBO.DEPOT SET LETZTEAENDERUNG = GETDATE() WHERE DEPOT_ID = (SELECT DEPOT_ID FROM DELETED)
	END ELSE IF EXISTS(SELECT * FROM INSERTED) AND ((SELECT ANLAGEDATUM FROM INSERTED) IS NULL)
		UPDATE DBO.DEPOT SET ANLAGEDATUM = GETDATE(), LETZTEAENDERUNG = GETDATE() WHERE DEPOT_ID = (SELECT DEPOT_ID FROM INSERTED)
END;

CREATE TRIGGER INSUPD_EXEMPLAR
   ON DBO.EXEMPLAR
   AFTER INSERT, UPDATE
AS
BEGIN
	SET NOCOUNT ON
	IF EXISTS(SELECT * FROM DELETED) AND EXISTS(SELECT * FROM INSERTED)
	BEGIN
		UPDATE DBO.EXEMPLAR SET LETZTEAENDERUNG = GETDATE() WHERE EXEMPLAR_ID = (SELECT EXEMPLAR_ID FROM DELETED)
	END ELSE IF EXISTS(SELECT * FROM INSERTED) AND ((SELECT ANLAGEDATUM FROM INSERTED) IS NULL)
		UPDATE DBO.EXEMPLAR SET ANLAGEDATUM = GETDATE(), LETZTEAENDERUNG = GETDATE() WHERE EXEMPLAR_ID = (SELECT EXEMPLAR_ID FROM INSERTED)
END;

CREATE TRIGGER INSUPD_EXEMPLARSTATUS
   ON DBO.EXEMPLARSTATUS
   AFTER INSERT, UPDATE
AS
BEGIN
	SET NOCOUNT ON
	IF EXISTS(SELECT * FROM DELETED) AND EXISTS(SELECT * FROM INSERTED)
	BEGIN
		UPDATE DBO.EXEMPLARSTATUS SET LETZTEAENDERUNG = GETDATE() WHERE EXEMPLARSTATUS_ID = (SELECT EXEMPLARSTATUS_ID FROM DELETED)
	END ELSE IF EXISTS(SELECT * FROM INSERTED) AND ((SELECT ANLAGEDATUM FROM INSERTED) IS NULL)
		UPDATE DBO.EXEMPLARSTATUS SET ANLAGEDATUM = GETDATE(), LETZTEAENDERUNG = GETDATE() WHERE EXEMPLARSTATUS_ID = (SELECT EXEMPLARSTATUS_ID FROM INSERTED)
END;

CREATE TRIGGER INSUPD_GEBAEUDE
   ON DBO.GEBAEUDE
   AFTER INSERT, UPDATE
AS
BEGIN
	SET NOCOUNT ON
	IF EXISTS(SELECT * FROM DELETED) AND EXISTS(SELECT * FROM INSERTED)
	BEGIN
		UPDATE DBO.GEBAEUDE SET LETZTEAENDERUNG = GETDATE() WHERE GEBAEUDE_ID = (SELECT GEBAEUDE_ID FROM DELETED)
	END ELSE IF EXISTS(SELECT * FROM INSERTED) AND ((SELECT ANLAGEDATUM FROM INSERTED) IS NULL)
		UPDATE DBO.GEBAEUDE SET ANLAGEDATUM = GETDATE(), LETZTEAENDERUNG = GETDATE() WHERE GEBAEUDE_ID = (SELECT GEBAEUDE_ID FROM INSERTED)
END;

CREATE TRIGGER INSUPD_GFUNKTION
   ON DBO.GFUNKTION
   AFTER INSERT, UPDATE
AS
BEGIN
	SET NOCOUNT ON
	IF EXISTS(SELECT * FROM DELETED) AND EXISTS(SELECT * FROM INSERTED)
	BEGIN
		UPDATE DBO.GFUNKTION SET LETZTEAENDERUNG = GETDATE() WHERE GFUNKTION_ID = (SELECT GFUNKTION_ID FROM DELETED)
	END ELSE IF EXISTS(SELECT * FROM INSERTED) AND ((SELECT ANLAGEDATUM FROM INSERTED) IS NULL)
		UPDATE DBO.GFUNKTION SET ANLAGEDATUM = GETDATE(), LETZTEAENDERUNG = GETDATE() WHERE GFUNKTION_ID = (SELECT GFUNKTION_ID FROM INSERTED)
END;

CREATE TRIGGER INSUPD_GRUPPE
   ON DBO.GRUPPE
   AFTER INSERT, UPDATE
AS
BEGIN
	SET NOCOUNT ON
	IF EXISTS(SELECT * FROM DELETED) AND EXISTS(SELECT * FROM INSERTED)
	BEGIN
		UPDATE DBO.GRUPPE SET LETZTEAENDERUNG = GETDATE() WHERE GRUPPE_ID = (SELECT GRUPPE_ID FROM DELETED)
	END ELSE IF EXISTS(SELECT * FROM INSERTED) AND ((SELECT ANLAGEDATUM FROM INSERTED) IS NULL)
		UPDATE DBO.GRUPPE SET ANLAGEDATUM = GETDATE(), LETZTEAENDERUNG = GETDATE() WHERE GRUPPE_ID = (SELECT GRUPPE_ID FROM INSERTED)
END;

CREATE TRIGGER INSUPD_HAENDLER
   ON DBO.HAENDLER
   AFTER INSERT, UPDATE
AS
BEGIN
	SET NOCOUNT ON
	IF EXISTS(SELECT * FROM DELETED) AND EXISTS(SELECT * FROM INSERTED)
	BEGIN
		UPDATE DBO.HAENDLER SET LETZTEAENDERUNG = GETDATE() WHERE HAENDLER_ID = (SELECT HAENDLER_ID FROM DELETED)
	END ELSE IF EXISTS(SELECT * FROM INSERTED) AND ((SELECT ANLAGEDATUM FROM INSERTED) IS NULL)
		UPDATE DBO.HAENDLER SET ANLAGEDATUM = GETDATE(), LETZTEAENDERUNG = GETDATE() WHERE HAENDLER_ID = (SELECT HAENDLER_ID FROM INSERTED)
END;

CREATE TRIGGER INSUPD_JOURNAL
   ON DBO.JOURNAL
   AFTER INSERT
AS
BEGIN
	SET NOCOUNT ON
	IF EXISTS(SELECT * FROM INSERTED)
		UPDATE DBO.JOURNAL SET ANLAGEDATUM = GETDATE() WHERE ID = (SELECT ID FROM INSERTED)
END;

CREATE TRIGGER INSUPD_KOMPETENZSTUFE
   ON DBO.KOMPETENZSTUFE
   AFTER INSERT, UPDATE
AS
BEGIN
	SET NOCOUNT ON
	IF EXISTS(SELECT * FROM DELETED) AND EXISTS(SELECT * FROM INSERTED)
	BEGIN
		UPDATE DBO.KOMPETENZSTUFE SET LETZTEAENDERUNG = GETDATE() WHERE KOMPETENZSTUFE_ID = (SELECT KOMPETENZSTUFE_ID FROM DELETED)
	END ELSE IF EXISTS(SELECT * FROM INSERTED) AND ((SELECT ANLAGEDATUM FROM INSERTED) IS NULL)
		UPDATE DBO.KOMPETENZSTUFE SET ANLAGEDATUM = GETDATE(), LETZTEAENDERUNG = GETDATE() WHERE KOMPETENZSTUFE_ID = (SELECT KOMPETENZSTUFE_ID FROM INSERTED)
END;

CREATE TRIGGER INSUPD_PERSONAL
   ON DBO.PERSONAL
   AFTER INSERT, UPDATE
AS
BEGIN
	SET NOCOUNT ON
	IF EXISTS(SELECT * FROM DELETED) AND EXISTS(SELECT * FROM INSERTED)
	BEGIN
		UPDATE DBO.PERSONAL SET LETZTEAENDERUNG = GETDATE() WHERE PERSONAL_ID = (SELECT PERSONAL_ID FROM DELETED)
	END ELSE IF EXISTS(SELECT * FROM INSERTED) AND ((SELECT ANLAGEDATUM FROM INSERTED) IS NULL)
		UPDATE DBO.PERSONAL SET ANLAGEDATUM = GETDATE(), LETZTEAENDERUNG = GETDATE() WHERE PERSONAL_ID = (SELECT PERSONAL_ID FROM INSERTED)
END;

CREATE TRIGGER INSUPD_PERSONAL_GV
   ON DBO.PERSONAL_GV
   AFTER INSERT, UPDATE
AS
BEGIN
	SET NOCOUNT ON
	IF EXISTS(SELECT * FROM DELETED) AND EXISTS(SELECT * FROM INSERTED)
	BEGIN
		UPDATE DBO.PERSONAL_GV SET LETZTEAENDERUNG = GETDATE() WHERE PERSONAL_GV_ID = (SELECT PERSONAL_GV_ID FROM DELETED)
	END ELSE IF EXISTS(SELECT * FROM INSERTED) AND ((SELECT ANLAGEDATUM FROM INSERTED) IS NULL)
		UPDATE DBO.PERSONAL_GV SET ANLAGEDATUM = GETDATE(), LETZTEAENDERUNG = GETDATE() WHERE PERSONAL_GV_ID = (SELECT PERSONAL_GV_ID FROM INSERTED)
END;

CREATE TRIGGER INSUPD_PERSONALBILD
   ON DBO.PERSONALBILD
   AFTER INSERT, UPDATE
AS
BEGIN
	SET NOCOUNT ON
	IF EXISTS(SELECT * FROM DELETED) AND EXISTS(SELECT * FROM INSERTED)
	BEGIN
		UPDATE DBO.PERSONALBILD SET LETZTEAENDERUNG = GETDATE() WHERE PERSONALBILD_ID = (SELECT PERSONALBILD_ID FROM DELETED)
	END ELSE IF EXISTS(SELECT * FROM INSERTED) AND ((SELECT ANLAGEDATUM FROM INSERTED) IS NULL)
		UPDATE DBO.PERSONALBILD SET ANLAGEDATUM = GETDATE(), LETZTEAENDERUNG = GETDATE() WHERE PERSONALBILD_ID = (SELECT PERSONALBILD_ID FROM INSERTED)
END;

CREATE TRIGGER [DBO].[INSUPD_QUICK_QUERIES] 
ON [DBO].[QUICK_QUERIES] 
AFTER INSERT, UPDATE 
AS 
BEGIN 
SET NOCOUNT ON; 
UPDATE q 
SET ANLAGEDATUM = GETDATE() 
FROM DBO.QUICK_QUERIES q	
INNER JOIN INSERTED i ON q.QUICK_QUERY_ID = i.QUICK_QUERY_ID 
WHERE q.ANLAGEDATUM IS NULL;	
UPDATE q 
SET LETZTEAENDERUNG = GETDATE() 
FROM DBO.QUICK_QUERIES q	
INNER JOIN INSERTED i ON q.QUICK_QUERY_ID = i.QUICK_QUERY_ID 
WHERE q.LETZTEAENDERUNG IS NULL OR q.ANLAGEDATUM IS NOT NULL; 
END;

CREATE TRIGGER INSUPD_QUITTUNGSART
   ON DBO.QUITTUNGSART
   AFTER INSERT, UPDATE
AS
BEGIN
	SET NOCOUNT ON
	IF EXISTS(SELECT * FROM DELETED) AND EXISTS(SELECT * FROM INSERTED)
	BEGIN
		UPDATE DBO.QUITTUNGSART SET LETZTEAENDERUNG = GETDATE() WHERE QUITTUNGSART_ID = (SELECT QUITTUNGSART_ID FROM DELETED)
	END ELSE IF EXISTS(SELECT * FROM INSERTED) AND ((SELECT ANLAGEDATUM FROM INSERTED) IS NULL)
		UPDATE DBO.QUITTUNGSART SET ANLAGEDATUM = GETDATE(), LETZTEAENDERUNG = GETDATE() WHERE QUITTUNGSART_ID = (SELECT QUITTUNGSART_ID FROM INSERTED)
END;

CREATE TRIGGER INSUPD_REPORT
   ON DBO.REPORT
  AFTER INSERT, UPDATE
AS
BEGIN
	SET NOCOUNT ON
	IF EXISTS(SELECT * FROM DELETED) AND EXISTS(SELECT * FROM INSERTED)
	BEGIN
		UPDATE DBO.REPORT SET LETZTEAENDERUNG = GETDATE() WHERE REPORT_ID = (SELECT REPORT_ID FROM DELETED)
	END ELSE IF EXISTS(SELECT * FROM INSERTED) AND ((SELECT ANLAGEDATUM FROM INSERTED) IS NULL)
		UPDATE DBO.REPORT SET ANLAGEDATUM = GETDATE(), LETZTEAENDERUNG = GETDATE() WHERE REPORT_ID = (SELECT REPORT_ID FROM INSERTED)
END;

CREATE TRIGGER INSUPD_REPORT_BIN
   ON DBO.REPORT_BIN
   AFTER INSERT, UPDATE
AS
BEGIN
	SET NOCOUNT ON
	IF EXISTS(SELECT * FROM DELETED) AND EXISTS(SELECT * FROM INSERTED)
	BEGIN
		UPDATE DBO.REPORT_BIN SET LETZTEAENDERUNG = GETDATE() WHERE REPORT_BIN_ID = (SELECT REPORT_BIN_ID FROM DELETED)
	END ELSE IF EXISTS(SELECT * FROM INSERTED) AND ((SELECT ANLAGEDATUM FROM INSERTED) IS NULL)
		UPDATE DBO.REPORT_BIN SET ANLAGEDATUM = GETDATE(), LETZTEAENDERUNG = GETDATE() WHERE REPORT_BIN_ID = (SELECT REPORT_BIN_ID FROM INSERTED)
END;

CREATE TRIGGER INSUPD_ROLLE
   ON DBO.ROLLE
   AFTER INSERT, UPDATE
AS
BEGIN
	SET NOCOUNT ON
	IF EXISTS(SELECT * FROM DELETED) AND EXISTS(SELECT * FROM INSERTED)
	BEGIN
		UPDATE DBO.ROLLE SET LETZTEAENDERUNG = GETDATE() WHERE ROLLE_ID = (SELECT ROLLE_ID FROM DELETED)
	END ELSE IF EXISTS(SELECT * FROM INSERTED) AND ((SELECT ANLAGEDATUM FROM INSERTED) IS NULL)
		UPDATE DBO.ROLLE SET ANLAGEDATUM = GETDATE(), LETZTEAENDERUNG = GETDATE() WHERE ROLLE_ID = (SELECT ROLLE_ID FROM INSERTED)
END;

CREATE TRIGGER INSUPD_SCHLIESSMATRIX
   ON DBO.SCHLIESSMATRIX
   AFTER INSERT, UPDATE
AS
BEGIN
	SET NOCOUNT ON
	IF EXISTS(SELECT * FROM DELETED) AND EXISTS(SELECT * FROM INSERTED)
	BEGIN
		UPDATE DBO.SCHLIESSMATRIX SET LETZTEAENDERUNG = GETDATE() WHERE SCHLIESSMATRIX_ID = (SELECT SCHLIESSMATRIX_ID FROM DELETED)
	END ELSE IF EXISTS(SELECT * FROM INSERTED) AND ((SELECT ANLAGEDATUM FROM INSERTED) IS NULL)
		UPDATE DBO.SCHLIESSMATRIX SET ANLAGEDATUM = GETDATE(), LETZTEAENDERUNG = GETDATE() WHERE SCHLIESSMATRIX_ID = (SELECT SCHLIESSMATRIX_ID FROM INSERTED)
END;

CREATE TRIGGER INSUPD_SCHLUESSEL
   ON DBO.SCHLUESSEL
   AFTER INSERT, UPDATE
AS
BEGIN
	SET NOCOUNT ON
	IF EXISTS(SELECT * FROM DELETED) AND EXISTS(SELECT * FROM INSERTED)
	BEGIN
		UPDATE DBO.SCHLUESSEL SET LETZTEAENDERUNG = GETDATE() WHERE SCHLUESSEL_ID = (SELECT SCHLUESSEL_ID FROM DELETED)
	END ELSE IF EXISTS(SELECT * FROM INSERTED) AND ((SELECT ANLAGEDATUM FROM INSERTED) IS NULL)
		UPDATE DBO.SCHLUESSEL SET ANLAGEDATUM = GETDATE(), LETZTEAENDERUNG = GETDATE() WHERE SCHLUESSEL_ID = (SELECT SCHLUESSEL_ID FROM INSERTED)
END;

CREATE TRIGGER INSUPD_SCHLUESSEL_SIWOS_DELTA
   ON DBO.SCHLUESSEL_SIWOS_DELTA
   AFTER INSERT, UPDATE
AS
BEGIN
	SET NOCOUNT ON
	IF EXISTS(SELECT * FROM DELETED) AND EXISTS(SELECT * FROM INSERTED)
	BEGIN
		UPDATE DBO.SCHLUESSEL_SIWOS_DELTA SET LETZTEAENDERUNG = GETDATE() WHERE SCHLUESSEL_ID = (SELECT SCHLUESSEL_ID FROM DELETED)
	END ELSE IF EXISTS(SELECT * FROM INSERTED) AND ((SELECT ANLAGEDATUM FROM INSERTED) IS NULL)
		UPDATE DBO.SCHLUESSEL_SIWOS_DELTA SET ANLAGEDATUM = GETDATE(), LETZTEAENDERUNG = GETDATE() WHERE SCHLUESSEL_ID = (SELECT SCHLUESSEL_ID FROM INSERTED)
END;

CREATE TRIGGER INSUPD_STANDORT
  ON DBO.STANDORT
   AFTER INSERT, UPDATE
AS
BEGIN
	SET NOCOUNT ON
	IF EXISTS(SELECT * FROM DELETED) AND EXISTS(SELECT * FROM INSERTED)
	BEGIN
		UPDATE DBO.STANDORT SET LETZTEAENDERUNG = GETDATE() WHERE STANDORT_ID = (SELECT STANDORT_ID FROM DELETED)
	END ELSE IF EXISTS(SELECT * FROM INSERTED) AND ((SELECT ANLAGEDATUM FROM INSERTED) IS NULL)
		UPDATE DBO.STANDORT SET ANLAGEDATUM = GETDATE(), LETZTEAENDERUNG = GETDATE() WHERE STANDORT_ID = (SELECT STANDORT_ID FROM INSERTED)
END;

CREATE TRIGGER INSUPD_SYS_ADDON
   ON DBO.SYS_ADDON
   AFTER INSERT, UPDATE
AS
BEGIN
	SET NOCOUNT ON
	IF EXISTS(SELECT * FROM DELETED) AND EXISTS(SELECT * FROM INSERTED)
	BEGIN
		UPDATE DBO.SYS_ADDON SET LETZTEAENDERUNG = GETDATE() WHERE SYS_ADDON_ID = (SELECT SYS_ADDON_ID FROM DELETED)
	END ELSE IF EXISTS(SELECT * FROM INSERTED) AND ((SELECT ANLAGEDATUM FROM INSERTED) IS NULL)
		UPDATE DBO.SYS_ADDON SET ANLAGEDATUM = GETDATE(), LETZTEAENDERUNG = GETDATE() WHERE SYS_ADDON_ID = (SELECT SYS_ADDON_ID FROM INSERTED)
END;

CREATE TRIGGER INSUPD_SYS_NACHSCHLAGETABELLE
   ON DBO.SYS_NACHSCHLAGETABELLE
   AFTER INSERT, UPDATE
AS
BEGIN
	SET NOCOUNT ON
	IF EXISTS(SELECT * FROM DELETED) AND EXISTS(SELECT * FROM INSERTED)
	BEGIN
		UPDATE DBO.SYS_NACHSCHLAGETABELLE SET LETZTEAENDERUNG = GETDATE() WHERE SYS_NACHSCHLAGETABELLE_ID = (SELECT SYS_NACHSCHLAGETABELLE_ID FROM DELETED)
	END ELSE IF EXISTS(SELECT * FROM INSERTED) AND ((SELECT ANLAGEDATUM FROM INSERTED) IS NULL)
		UPDATE DBO.SYS_NACHSCHLAGETABELLE SET ANLAGEDATUM = GETDATE(), LETZTEAENDERUNG = GETDATE() WHERE SYS_NACHSCHLAGETABELLE_ID = (SELECT SYS_NACHSCHLAGETABELLE_ID FROM INSERTED)
END;

CREATE TRIGGER INSUPD_TMP_DRUCK
   ON DBO.TMP_DRUCK
   AFTER INSERT, UPDATE
AS
BEGIN
	SET NOCOUNT ON
	IF EXISTS(SELECT * FROM DELETED) AND EXISTS(SELECT * FROM INSERTED)
	BEGIN
		UPDATE DBO.TMP_DRUCK SET AENDERUNGSDATUM = GETDATE() WHERE VORGANG_ID = (SELECT VORGANG_ID FROM DELETED)
	END ELSE IF EXISTS(SELECT * FROM INSERTED) AND ((SELECT ANLAGEDATUM FROM INSERTED) IS NULL)
		UPDATE DBO.TMP_DRUCK SET ANLAGEDATUM = GETDATE(), AENDERUNGSDATUM = GETDATE() WHERE VORGANG_ID = (SELECT VORGANG_ID FROM INSERTED)
END;

CREATE TRIGGER INSUPD_TUER
   ON DBO.TUER
   AFTER INSERT, UPDATE
AS
BEGIN
	SET NOCOUNT ON
	IF EXISTS(SELECT * FROM DELETED) AND EXISTS(SELECT * FROM INSERTED)
	BEGIN
		UPDATE DBO.TUER SET LETZTEAENDERUNG = GETDATE() WHERE TUER_ID = (SELECT TUER_ID FROM DELETED)
	END ELSE IF EXISTS(SELECT * FROM INSERTED) AND ((SELECT ANLAGEDATUM FROM INSERTED) IS NULL)
		UPDATE DBO.TUER SET ANLAGEDATUM = GETDATE(), LETZTEAENDERUNG = GETDATE() WHERE TUER_ID = (SELECT TUER_ID FROM INSERTED)
END;

CREATE TRIGGER INSUPD_UNTERSCHRIFT
   ON DBO.UNTERSCHRIFT
  AFTER INSERT, UPDATE
AS
BEGIN
	SET NOCOUNT ON
	IF EXISTS(SELECT * FROM DELETED) AND EXISTS(SELECT * FROM INSERTED)
	BEGIN
		UPDATE DBO.UNTERSCHRIFT SET LETZTEAENDERUNG = GETDATE() WHERE UNTERSCHRIFT_ID = (SELECT UNTERSCHRIFT_ID FROM DELETED)
	END ELSE IF EXISTS(SELECT * FROM INSERTED) AND ((SELECT ANLAGEDATUM FROM INSERTED) IS NULL)
		UPDATE DBO.UNTERSCHRIFT SET ANLAGEDATUM = GETDATE(), LETZTEAENDERUNG = GETDATE() WHERE UNTERSCHRIFT_ID = (SELECT UNTERSCHRIFT_ID FROM INSERTED)
END;

CREATE TRIGGER INSUPD_VIPSTUFE
   ON DBO.VIPSTUFE
   AFTER INSERT, UPDATE
AS
BEGIN
	SET NOCOUNT ON
	IF EXISTS(SELECT * FROM DELETED) AND EXISTS(SELECT * FROM INSERTED)
	BEGIN
		UPDATE DBO.VIPSTUFE SET LETZTEAENDERUNG = GETDATE() WHERE VIPSTUFE_ID = (SELECT VIPSTUFE_ID FROM DELETED)
	END ELSE IF EXISTS(SELECT * FROM INSERTED) AND ((SELECT ANLAGEDATUM FROM INSERTED) IS NULL)
		UPDATE DBO.VIPSTUFE SET ANLAGEDATUM = GETDATE(), LETZTEAENDERUNG = GETDATE() WHERE VIPSTUFE_ID = (SELECT VIPSTUFE_ID FROM INSERTED)
END;

CREATE TRIGGER INSUPD_ZEITZONE
   ON DBO.ZEITZONE
   AFTER INSERT, UPDATE
AS
BEGIN
	SET NOCOUNT ON
	IF EXISTS(SELECT * FROM DELETED) AND EXISTS(SELECT * FROM INSERTED)
	BEGIN
		UPDATE DBO.ZEITZONE SET LETZTEAENDERUNG = GETDATE() WHERE ZEITZONE_ID = (SELECT ZEITZONE_ID FROM DELETED)
	END ELSE IF EXISTS(SELECT * FROM INSERTED) AND ((SELECT ANLAGEDATUM FROM INSERTED) IS NULL)
		UPDATE DBO.ZEITZONE SET ANLAGEDATUM = GETDATE(), LETZTEAENDERUNG = GETDATE() WHERE ZEITZONE_ID = (SELECT ZEITZONE_ID FROM INSERTED)
END;

CREATE TRIGGER INSUPD_ZUGRIFF
   ON DBO.ZUGRIFF
   AFTER INSERT, UPDATE
AS
BEGIN
	SET NOCOUNT ON
	IF EXISTS(SELECT * FROM DELETED) AND EXISTS(SELECT * FROM INSERTED)
	BEGIN
		UPDATE DBO.ZUGRIFF SET LETZTEAENDERUNG = GETDATE() WHERE ZUGRIFF_ID = (SELECT ZUGRIFF_ID FROM DELETED)
	END ELSE IF EXISTS(SELECT * FROM INSERTED) AND ((SELECT ANLAGEDATUM FROM INSERTED) IS NULL)
		UPDATE DBO.ZUGRIFF SET ANLAGEDATUM = GETDATE(), LETZTEAENDERUNG = GETDATE() WHERE ZUGRIFF_ID = (SELECT ZUGRIFF_ID FROM INSERTED)
END;

CREATE TRIGGER [dbo].[INSUPD_ZYLINDER]
   ON [dbo].[ZYLINDER]
   AFTER INSERT, UPDATE
AS
BEGIN
	SET NOCOUNT ON
	IF @@NESTLEVEL = 1
	BEGIN
		IF EXISTS(SELECT * FROM DELETED) AND EXISTS(SELECT * FROM INSERTED)
		BEGIN
			UPDATE DBO.ZYLINDER SET LETZTEAENDERUNG = GETDATE() WHERE ZYLINDER_ID = (SELECT ZYLINDER_ID FROM DELETED)
		END ELSE IF EXISTS(SELECT * FROM INSERTED) AND ((SELECT ANLAGEDATUM FROM INSERTED) IS NULL)
		BEGIN
			DECLARE	@LOCATETRESULT varchar(40)
			DECLARE	@NEW_SCHLUESSELNUMMER varchar(20)
			DECLARE	@NEW_ANLAGE_ID varchar(32)
			DECLARE	@NEW_ZYLINDER_ID varchar(32)
			SELECT @NEW_SCHLUESSELNUMMER = ins.SCHLUESSELNUMMER FROM INSERTED ins
			SELECT @NEW_ANLAGE_ID = ins.ANLAGE_ID FROM INSERTED ins
			SELECT @NEW_ZYLINDER_ID = ins.ZYLINDER_ID FROM INSERTED ins
			EXEC SCHLUESSELNUMMEREXISTS
				@SCHLUESSELNUMMER = @NEW_SCHLUESSELNUMMER,
				@ANLAGE_ID = @NEW_ANLAGE_ID,
				@LOCATETRESULT = @LOCATETRESULT OUTPUT
    		UPDATE DBO.ZYLINDER SET ANLAGEDATUM = GETDATE(), LETZTEAENDERUNG = GETDATE(), SCHLUESSEL_ID = @LOCATETRESULT WHERE ZYLINDER_ID = @NEW_ZYLINDER_ID
		END
	END
END;

CREATE TRIGGER INSUPD_ZYLINDER_SIWOS_DELTA
   ON DBO.ZYLINDER_SIWOS_DELTA
   AFTER INSERT, UPDATE
AS
BEGIN
	SET NOCOUNT ON
	IF EXISTS(SELECT * FROM DELETED) AND EXISTS(SELECT * FROM INSERTED)
	BEGIN
		UPDATE DBO.ZYLINDER_SIWOS_DELTA SET LETZTEAENDERUNG = GETDATE() WHERE ZYLINDER_ID = (SELECT ZYLINDER_ID FROM DELETED)
	END ELSE IF EXISTS(SELECT * FROM INSERTED) AND ((SELECT ANLAGEDATUM FROM INSERTED) IS NULL)
		UPDATE DBO.ZYLINDER_SIWOS_DELTA SET ANLAGEDATUM = GETDATE(), LETZTEAENDERUNG = GETDATE() WHERE ZYLINDER_ID = (SELECT ZYLINDER_ID FROM INSERTED)
END;