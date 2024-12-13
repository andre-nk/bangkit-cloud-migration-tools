package main

import (
	"database/sql"
	//"fmt"

	"github.com/bxcodec/faker/v4"
	"github.com/rs/zerolog/log"
	"time"
)

type Anlage struct {
	ANLAGE_ID       string  `faker:"uuid_digit"`         // Unique ID (UUID style)
	ANLAGE_NR       int     `faker:"boundary_start=1, boundary_end=1000"` // Random number
	KOMPETENZSTUFE  int     `faker:"boundary_start=0, boundary_end=5"`    // Competency level
	ANLAGENUMMER    *string `faker:"word"`              // Nullable
	BEZEICHNUNG     string  `faker:"word"`              // Name
	AUSGABEZONE_ID  int     `faker:"boundary_start=0, boundary_end=10"`   // Zone ID
	BEMERKUNG_1     string  `faker:"sentence"`          // Remarks
	BEMERKUNG_2     string  `faker:"sentence"`          // Remarks
	BEMERKUNG_3     string  `faker:"sentence"`          // Remarks
	SCHLIESSANLAGE  *string `faker:"word"`              // Nullable
	HERSTELLER      string  `faker:"company"`           // Manufacturer
	ANLAGENART      *string `faker:"word"`              // Type of Anlage (Nullable)
	ANLAGENNUMMER   *string `faker:"word"`              // Nullable
	SYSTEM          string  `faker:"word"`              // System
	ANLAGEANGELEGTAM time.Time `faker:"-"`              // Current timestamp
	SACHBEARBEITER_ID string `faker:"uuid_digit"`       // Operator ID
	ANLAGEDATUM      time.Time `faker:"-"`              // Current timestamp
	LETZTEAENDERUNG  time.Time `faker:"-"`              // Current timestamp
}

type GFunktion struct {
    GFUNKTION_ID         string    `faker:"uuid_digit"`
    GFUNKTION_NR         *int      `faker:"boundary_start=1, boundary_end=1000"`
    ANLAGE_ID            *string   `faker:"uuid_digit"`
    SCHLUESSELNUMMER_DEF *string   `faker:"word"`
    SCHLUESSELNUMMER_AUS *string   `faker:"word"`
    SCHLUESSELNUMMER_IN  *string   `faker:"word"`
    GFUNKTION           *string   `faker:"length=3"`
    KZ_VERARBEITUNG     *string   `faker:"length=1"`
    LETZTEAENDERUNG     time.Time `faker:"-"`
    ANLAGEDATUM         time.Time `faker:"-"`
    ZEITZONE_ID         *string   `faker:"uuid_digit"`
    TEMP_ID             *int      `faker:"boundary_start=1, boundary_end=100"`
}

type Personal struct {
    PERSONAL_ID         string    `faker:"uuid_digit"`
    PERSONAL_NR         *int      `faker:"boundary_start=1, boundary_end=10000"`
    VIPSTUFE_ID         *int      `faker:"boundary_start=0, boundary_end=5"`
    KOMPETENZSTUFE_ID   *int      `faker:"boundary_start=0, boundary_end=5"`
    PERSONALNUMMER      *string   `faker:"word"`
    SUCHBEGRIFF         *string   `faker:"word"`
    ANREDE              *string   `faker:"oneof: Herr, Frau, Divers"`
    NAME_1              string    `faker:"name"`
    NAME_2              *string   `faker:"name"`
    ZUSATZ              *string   `faker:"word"`
    STRASSE             *string   `faker:"street_address"`
    LKZ                 *string   `faker:"length=3"`
    PLZ                 *string   `faker:"postcode"`
    ORT                 *string   `faker:"city"`
    GEBURTSDATUM        *time.Time 
    VORLAGEDATUM        *time.Time
    ABTEILUNG           *string   `faker:"word"`
    BEREICH             *string   `faker:"word"`
    KOSTENSTELLE        *string   `faker:"word"`
    TAETIGKEIT          *string   `faker:"job_title"`
    RAUM                *string   `faker:"random_string"`
    MITARBEITERGRUPPE   *string   `faker:"word"`
    ZEITZONE            *string   `faker:"timezone"`
    TELEFONPRIVAT       *string   `faker:"phone_number"`
    TELEFONFIRMA        *string   `faker:"phone_number"`
    FAX                 *string   `faker:"phone_number"`
    FUNK                *string   `faker:"phone_number"`
    EMAIL               *string   `faker:"email"`
    WEB                 *string   `faker:"url"`
    BEGINNDATUM         *time.Time
    BEGINNUHR           *string   `faker:"length=5"`
    ENDEDATUM           *time.Time
    ENDEUHR             *string   `faker:"length=5"`
    PIN                 *string   `faker:"numerify:####"`
    BEMERKUNG_1         *string   `faker:"sentence"`
    BEMERKUNG_2         *string   `faker:"sentence"`
    BEMERKUNG_3         *string   `faker:"sentence"`
    SACHBEARBEITER_ID   *string   `faker:"uuid_digit"`
    QUITTUNGSART_ID     *int      `faker:"boundary_start=0, boundary_end=10"`
    ANLAGEDATUM         time.Time `faker:"-"`
    LETZTEAENDERUNG     time.Time `faker:"-"`
    TEMP_ID             *int      `faker:"boundary_start=1, boundary_end=100"`
}

type Exemplar struct {
    EXEMPLAR_ID         string    `faker:"uuid_digit"`
    EXEMPLAR_NR         *int      `faker:"boundary_start=1, boundary_end=10000"`
    BUND_ID             *string   `faker:"uuid_digit"`
    KOMPETENZSTUFE_ID   *int      `faker:"boundary_start=0, boundary_end=5"`
    SCHLUESSEL_ID       *string   `faker:"uuid_digit"`
    RESERVIERUNG_ID     *string   `faker:"uuid_digit"`
    AUSGABE_SIWOS_ID    *string   `faker:"uuid_digit"`
    SCHLUESSELNUMMER    *string   `faker:"word"`
    EXEMPLARSTATUS_ID   *int      `faker:"boundary_start=0, boundary_end=10"`
    SACHBEARBEITER_ID   *string   `faker:"uuid_digit"`
    DEPOT_ID            *string   `faker:"uuid_digit"`
    DEPOTSTATUS         *int      `faker:"boundary_start=0, boundary_end=5"`
    SONDERBESCHRIFTUNG  *string   `faker:"word"`
    EXEMPLAR_BEZEICHNUNG *string  `faker:"length=10"`
    LETZTEAENDERUNG     time.Time `faker:"-"`
    EXEMPLARNUMMER      *int      `faker:"boundary_start=1, boundary_end=1000"`
    ANLAGEDATUM         time.Time `faker:"-"`
    TEMP_ID             *int      `faker:"boundary_start=1, boundary_end=100"`
}

type Customize struct {
    CUSTOMIZE_ID      string    `faker:"uuid_digit"`
    CUSTOMIZE_NR      *int      `faker:"boundary_start=1, boundary_end=10000"`
    BEZEICHNUNG       *string   `faker:"word"`
    WERT              *string   `faker:"sentence"`
    ANLAGEDATUM       time.Time `faker:"-"`
    LETZTEAENDERUNG   time.Time `faker:"-"`
}

type Benutzer struct {
    BENUTZER_ID       string    `faker:"uuid_digit"`
    BENUTZER_NR       *int      `faker:"boundary_start=1, boundary_end=1000"`
    USER_KZ           *string   `faker:"word"`
    SYSTEMUSER        *int      `faker:"boundary_start=0, boundary_end=1"`
    VIPUSER           *int      `faker:"boundary_start=0, boundary_end=1"`
    NACHNAME          *string   `faker:"last_name"`
    VORNAME           *string   `faker:"first_name"`
    PASSWORT          *string   `faker:"password"`
    PERS_FRAGE        *string   `faker:"sentence"`
    PERS_ANTWORT      *string   `faker:"word"`
    ABTEILUNG         *string   `faker:"word"`
    RAUM              *string   `faker:"word"`
    TELEFON           *string   `faker:"phone_number"`
    EMAIL             *string   `faker:"email"`
    ANLAGEDATUM       time.Time `faker:"-"`
    LETZTEAENDERUNG   time.Time `faker:"-"`
    INAKTIV           *int      `faker:"boundary_start=0, boundary_end=1"`
    MENUE             *int      `faker:"boundary_start=0, boundary_end=5"`
    SACHBEARBEITER_ID *string   `faker:"uuid_digit"`
    TEMP_ID           *int      `faker:"boundary_start=1, boundary_end=100"`
}


// Helper function to create pointer to int
func ptr(i int) *int {
    return &i
}

func SeedWithFaker(db *sql.DB) {
	log.Info().Msg("Starting database seeding with Faker")
	
	for i := 0; i < 100; i++ { // Generate 100 fake records
		var anlage Anlage
		if err := faker.FakeData(&anlage); err != nil {
			log.Fatal().Err(err).Msg("Failed to generate fake data for ANLAGE")
			return
		}

		// Set non-faker fields
		now := time.Now()
		anlage.ANLAGEANGELEGTAM = now
		anlage.ANLAGEDATUM = now
		anlage.LETZTEAENDERUNG = now

		// Insert into the database
		query := `
		INSERT INTO ANLAGE (
			ANLAGE_ID, ANLAGE_NR, KOMPETENZSTUFE_ID, ANLAGENUMMER, BEZEICHNUNG, 
			AUSGABEZONE_ID, BEMERKUNG_1, BEMERKUNG_2, BEMERKUNG_3, SCHLIESSANLAGE, 
			HERSTELLER, ANLAGENART, SYSTEM, ANLAGENNUMMER, ANLAGEANGELEGTAM, 
			SACHBEARBEITER_ID, LETZTEAENDERUNG, ANLAGEDATUM
		) VALUES (
			@ANLAGE_ID, @ANLAGE_NR, @KOMPETENZSTUFE, @ANLAGENUMMER, @BEZEICHNUNG, 
			@AUSGABEZONE_ID, @BEMERKUNG_1, @BEMERKUNG_2, @BEMERKUNG_3, @SCHLIESSANLAGE, 
			@HERSTELLER, @ANLAGENART, @SYSTEM, @ANLAGENNUMMER, @ANLAGEANGELEGTAM, 
			@SACHBEARBEITER_ID, @LETZTEAENDERUNG, @ANLAGEDATUM
		)`
		_, err := db.Exec(query,
			sql.Named("ANLAGE_ID", anlage.ANLAGE_ID),
			sql.Named("ANLAGE_NR", anlage.ANLAGE_NR),
			sql.Named("KOMPETENZSTUFE", anlage.KOMPETENZSTUFE),
			sql.Named("ANLAGENUMMER", anlage.ANLAGENUMMER),
			sql.Named("BEZEICHNUNG", anlage.BEZEICHNUNG),
			sql.Named("AUSGABEZONE_ID", anlage.AUSGABEZONE_ID),
			sql.Named("BEMERKUNG_1", anlage.BEMERKUNG_1),
			sql.Named("BEMERKUNG_2", anlage.BEMERKUNG_2),
			sql.Named("BEMERKUNG_3", anlage.BEMERKUNG_3),
			sql.Named("SCHLIESSANLAGE", anlage.SCHLIESSANLAGE),
			sql.Named("HERSTELLER", anlage.HERSTELLER),
			sql.Named("ANLAGENART", anlage.ANLAGENART),
			sql.Named("SYSTEM", anlage.SYSTEM),
			sql.Named("ANLAGENNUMMER", anlage.ANLAGENNUMMER),
			sql.Named("ANLAGEANGELEGTAM", anlage.ANLAGEANGELEGTAM),
			sql.Named("SACHBEARBEITER_ID", anlage.SACHBEARBEITER_ID),
			sql.Named("LETZTEAENDERUNG", anlage.LETZTEAENDERUNG),
			sql.Named("ANLAGEDATUM", anlage.ANLAGEDATUM),
		)
		if err != nil {
			log.Fatal().Err(err).Msg("Failed to insert fake ANLAGE record")
			return
		}

		log.Info().Msgf("Inserted fake ANLAGE record: %+v", anlage)
	}

	log.Info().Msg("Seeder ran successfully")


	log.Info().Msg("Starting database seeding for GFUNKTION")
    
    for i := 0; i < 100; i++ { // Generate 100 fake records
        var gfunktion GFunktion
        if err := faker.FakeData(&gfunktion); err != nil {
            log.Fatal().Err(err).Msg("Failed to generate fake data for GFUNKTION")
            return
        }

        // Set non-faker fields
        now := time.Now()
        gfunktion.LETZTEAENDERUNG = now
        gfunktion.ANLAGEDATUM = now

        // Generate a random 3-character string for GFUNKTION
        gfunktionValue := faker.RandomString(3)
        gfunktion.GFUNKTION = &gfunktionValue

        // Generate a random 1-character processing key
        kzVerarbeitungValue := faker.RandomString(1)
        gfunktion.KZ_VERARBEITUNG = &kzVerarbeitungValue

        // Insert into the database
        query := `
        INSERT INTO GFUNKTION (
            GFUNKTION_ID, GFUNKTION_NR, ANLAGE_ID, SCHLUESSELNUMMER_DEF, 
            SCHLUESSELNUMMER_AUS, SCHLUESSELNUMMER_IN, GFUNKTION, 
            KZ_VERARBEITUNG, LETZTEAENDERUNG, ANLAGEDATUM, 
            ZEITZONE_ID, TEMP_ID
        ) VALUES (
            @GFUNKTION_ID, @GFUNKTION_NR, @ANLAGE_ID, @SCHLUESSELNUMMER_DEF, 
            @SCHLUESSELNUMMER_AUS, @SCHLUESSELNUMMER_IN, @GFUNKTION, 
            @KZ_VERARBEITUNG, @LETZTEAENDERUNG, @ANLAGEDATUM, 
            @ZEITZONE_ID, @TEMP_ID
        )`
        
        _, err := db.Exec(query,
            sql.Named("GFUNKTION_ID", gfunktion.GFUNKTION_ID),
            sql.Named("GFUNKTION_NR", gfunktion.GFUNKTION_NR),
            sql.Named("ANLAGE_ID", gfunktion.ANLAGE_ID),
            sql.Named("SCHLUESSELNUMMER_DEF", gfunktion.SCHLUESSELNUMMER_DEF),
            sql.Named("SCHLUESSELNUMMER_AUS", gfunktion.SCHLUESSELNUMMER_AUS),
            sql.Named("SCHLUESSELNUMMER_IN", gfunktion.SCHLUESSELNUMMER_IN),
            sql.Named("GFUNKTION", gfunktion.GFUNKTION),
            sql.Named("KZ_VERARBEITUNG", gfunktion.KZ_VERARBEITUNG),
            sql.Named("LETZTEAENDERUNG", gfunktion.LETZTEAENDERUNG),
            sql.Named("ANLAGEDATUM", gfunktion.ANLAGEDATUM),
            sql.Named("ZEITZONE_ID", gfunktion.ZEITZONE_ID),
            sql.Named("TEMP_ID", gfunktion.TEMP_ID),
        )
        if err != nil {
            log.Fatal().Err(err).Msg("Failed to insert fake GFUNKTION record")
            return
        }

        log.Info().Msgf("Inserted fake GFUNKTION record: %+v", gfunktion)
    }

    log.Info().Msg("Seeder for GFUNKTION ran successfully")


	log.Info().Msg("Starting database seeding for PERSONAL")
    
    for i := 0; i < 100; i++ { // Generate 100 fake records
        var personal Personal
        if err := faker.FakeData(&personal); err != nil {
            log.Fatal().Err(err).Msg("Failed to generate fake data for PERSONAL")
            return
        }

        // Set non-faker fields and generate additional data
        now := time.Now()
        personal.ANLAGEDATUM = now
        personal.LETZTEAENDERUNG = now

        // Generate some additional time-based fields
        birthDate := now.AddDate(-30, 0, 0) // Approximate 30 years ago
        personal.GEBURTSDATUM = &birthDate
        
        beginDate := now.AddDate(0, -1, 0) // Start date 1 month ago
        personal.BEGINNDATUM = &beginDate
        
        endDate := now.AddDate(0, 6, 0) // End date 6 months from now
        personal.ENDEDATUM = &endDate

        // Generate beginning and end times
        beginTime := fmt.Sprintf("%02d:%02d", rand.Intn(8)+7, rand.Intn(60)) // Work start time between 7-15
        personal.BEGINNUHR = &beginTime
        endTime := fmt.Sprintf("%02d:%02d", rand.Intn(8)+15, rand.Intn(60)) // Work end time between 15-23
        personal.ENDEUHR = &endTime

        // Insert into the database
        query := `
        INSERT INTO PERSONAL (
            PERSONAL_ID, PERSONAL_NR, VIPSTUFE_ID, KOMPETENZSTUFE_ID, 
            PERSONALNUMMER, SUCHBEGRIFF, ANREDE, NAME_1, NAME_2, ZUSATZ, 
            STRASSE, LKZ, PLZ, ORT, GEBURTSDATUM, VORLAGEDATUM, 
            ABTEILUNG, BEREICH, KOSTENSTELLE, TAETIGKEIT, RAUM, 
            MITARBEITERGRUPPE, ZEITZONE, TELEFONPRIVAT, TELEFONFIRMA, 
            FAX, FUNK, EMAIL, WEB, BEGINNDATUM, BEGINNUHR, 
            ENDEDATUM, ENDEUHR, PIN, BEMERKUNG_1, BEMERKUNG_2, BEMERKUNG_3, 
            SACHBEARBEITER_ID, QUITTUNGSART_ID, ANLAGEDATUM, 
            LETZTEAENDERUNG, TEMP_ID
        ) VALUES (
            @PERSONAL_ID, @PERSONAL_NR, @VIPSTUFE_ID, @KOMPETENZSTUFE_ID, 
            @PERSONALNUMMER, @SUCHBEGRIFF, @ANREDE, @NAME_1, @NAME_2, @ZUSATZ, 
            @STRASSE, @LKZ, @PLZ, @ORT, @GEBURTSDATUM, @VORLAGEDATUM, 
            @ABTEILUNG, @BEREICH, @KOSTENSTELLE, @TAETIGKEIT, @RAUM, 
            @MITARBEITERGRUPPE, @ZEITZONE, @TELEFONPRIVAT, @TELEFONFIRMA, 
            @FAX, @FUNK, @EMAIL, @WEB, @BEGINNDATUM, @BEGINNUHR, 
            @ENDEDATUM, @ENDEUHR, @PIN, @BEMERKUNG_1, @BEMERKUNG_2, @BEMERKUNG_3, 
            @SACHBEARBEITER_ID, @QUITTUNGSART_ID, @ANLAGEDATUM, 
            @LETZTEAENDERUNG, @TEMP_ID
        )`
        
        _, err := db.Exec(query,
            sql.Named("PERSONAL_ID", personal.PERSONAL_ID),
            sql.Named("PERSONAL_NR", personal.PERSONAL_NR),
            sql.Named("VIPSTUFE_ID", personal.VIPSTUFE_ID),
            sql.Named("KOMPETENZSTUFE_ID", personal.KOMPETENZSTUFE_ID),
            sql.Named("PERSONALNUMMER", personal.PERSONALNUMMER),
            sql.Named("SUCHBEGRIFF", personal.SUCHBEGRIFF),
            sql.Named("ANREDE", personal.ANREDE),
            sql.Named("NAME_1", personal.NAME_1),
            sql.Named("NAME_2", personal.NAME_2),
            sql.Named("ZUSATZ", personal.ZUSATZ),
            sql.Named("STRASSE", personal.STRASSE),
            sql.Named("LKZ", personal.LKZ),
            sql.Named("PLZ", personal.PLZ),
            sql.Named("ORT", personal.ORT),
            sql.Named("GEBURTSDATUM", personal.GEBURTSDATUM),
            sql.Named("VORLAGEDATUM", personal.VORLAGEDATUM),
            sql.Named("ABTEILUNG", personal.ABTEILUNG),
            sql.Named("BEREICH", personal.BEREICH),
            sql.Named("KOSTENSTELLE", personal.KOSTENSTELLE),
            sql.Named("TAETIGKEIT", personal.TAETIGKEIT),
            sql.Named("RAUM", personal.RAUM),
            sql.Named("MITARBEITERGRUPPE", personal.MITARBEITERGRUPPE),
            sql.Named("ZEITZONE", personal.ZEITZONE),
            sql.Named("TELEFONPRIVAT", personal.TELEFONPRIVAT),
            sql.Named("TELEFONFIRMA", personal.TELEFONFIRMA),
            sql.Named("FAX", personal.FAX),
            sql.Named("FUNK", personal.FUNK),
            sql.Named("EMAIL", personal.EMAIL),
            sql.Named("WEB", personal.WEB),
            sql.Named("BEGINNDATUM", personal.BEGINNDATUM),
            sql.Named("BEGINNUHR", personal.BEGINNUHR),
            sql.Named("ENDEDATUM", personal.ENDEDATUM),
            sql.Named("ENDEUHR", personal.ENDEUHR),
            sql.Named("PIN", personal.PIN),
            sql.Named("BEMERKUNG_1", personal.BEMERKUNG_1),
            sql.Named("BEMERKUNG_2", personal.BEMERKUNG_2),
            sql.Named("BEMERKUNG_3", personal.BEMERKUNG_3),
            sql.Named("SACHBEARBEITER_ID", personal.SACHBEARBEITER_ID),
            sql.Named("QUITTUNGSART_ID", personal.QUITTUNGSART_ID),
            sql.Named("ANLAGEDATUM", personal.ANLAGEDATUM),
            sql.Named("LETZTEAENDERUNG", personal.LETZTEAENDERUNG),
            sql.Named("TEMP_ID", personal.TEMP_ID),
        )
        if err != nil {
            log.Fatal().Err(err).Msg("Failed to insert fake PERSONAL record")
            return
        }

        log.Info().Msgf("Inserted fake PERSONAL record: %+v", personal)
    }

    log.Info().Msg("Seeder for PERSONAL ran successfully")


	log.Info().Msg("Starting database seeding for EXEMPLAR")
    
    for i := 0; i < 100; i++ { // Generate 100 fake records
        var exemplar Exemplar
        if err := faker.FakeData(&exemplar); err != nil {
            log.Fatal().Err(err).Msg("Failed to generate fake data for EXEMPLAR")
            return
        }

        // Set non-faker fields
        now := time.Now()
        exemplar.LETZTEAENDERUNG = now
        exemplar.ANLAGEDATUM = now

        // Ensure default values for nullable string fields
        if exemplar.RESERVIERUNG_ID == nil {
            emptyStr := ""
            exemplar.RESERVIERUNG_ID = &emptyStr
        }
        
        if exemplar.AUSGABE_SIWOS_ID == nil {
            emptyStr := ""
            exemplar.AUSGABE_SIWOS_ID = &emptyStr
        }

        // Insert into the database
        query := `
        INSERT INTO EXEMPLAR (
            EXEMPLAR_ID, EXEMPLAR_NR, BUND_ID, KOMPETENZSTUFE_ID, 
            SCHLUESSEL_ID, RESERVIERUNG_ID, AUSGABE_SIWOS_ID, 
            SCHLUESSELNUMMER, EXEMPLARSTATUS_ID, SACHBEARBEITER_ID, 
            DEPOT_ID, DEPOTSTATUS, SONDERBESCHRIFTUNG, EXEMPLAR_BEZEICHNUNG, 
            LETZTEAENDERUNG, EXEMPLARNUMMER, ANLAGEDATUM, TEMP_ID
        ) VALUES (
            @EXEMPLAR_ID, @EXEMPLAR_NR, @BUND_ID, @KOMPETENZSTUFE_ID, 
            @SCHLUESSEL_ID, @RESERVIERUNG_ID, @AUSGABE_SIWOS_ID, 
            @SCHLUESSELNUMMER, @EXEMPLARSTATUS_ID, @SACHBEARBEITER_ID, 
            @DEPOT_ID, @DEPOTSTATUS, @SONDERBESCHRIFTUNG, @EXEMPLAR_BEZEICHNUNG, 
            @LETZTEAENDERUNG, @EXEMPLARNUMMER, @ANLAGEDATUM, @TEMP_ID
        )`
        
        _, err := db.Exec(query,
            sql.Named("EXEMPLAR_ID", exemplar.EXEMPLAR_ID),
            sql.Named("EXEMPLAR_NR", exemplar.EXEMPLAR_NR),
            sql.Named("BUND_ID", exemplar.BUND_ID),
            sql.Named("KOMPETENZSTUFE_ID", exemplar.KOMPETENZSTUFE_ID),
            sql.Named("SCHLUESSEL_ID", exemplar.SCHLUESSEL_ID),
            sql.Named("RESERVIERUNG_ID", exemplar.RESERVIERUNG_ID),
            sql.Named("AUSGABE_SIWOS_ID", exemplar.AUSGABE_SIWOS_ID),
            sql.Named("SCHLUESSELNUMMER", exemplar.SCHLUESSELNUMMER),
            sql.Named("EXEMPLARSTATUS_ID", exemplar.EXEMPLARSTATUS_ID),
            sql.Named("SACHBEARBEITER_ID", exemplar.SACHBEARBEITER_ID),
            sql.Named("DEPOT_ID", exemplar.DEPOT_ID),
            sql.Named("DEPOTSTATUS", exemplar.DEPOTSTATUS),
            sql.Named("SONDERBESCHRIFTUNG", exemplar.SONDERBESCHRIFTUNG),
            sql.Named("EXEMPLAR_BEZEICHNUNG", exemplar.EXEMPLAR_BEZEICHNUNG),
            sql.Named("LETZTEAENDERUNG", exemplar.LETZTEAENDERUNG),
            sql.Named("EXEMPLARNUMMER", exemplar.EXEMPLARNUMMER),
            sql.Named("ANLAGEDATUM", exemplar.ANLAGEDATUM),
            sql.Named("TEMP_ID", exemplar.TEMP_ID),
        )
        if err != nil {
            log.Fatal().Err(err).Msg("Failed to insert fake EXEMPLAR record")
            return
        }

        log.Info().Msgf("Inserted fake EXEMPLAR record: %+v", exemplar)
    }

    log.Info().Msg("Seeder for EXEMPLAR ran successfully")


	log.Info().Msg("Starting database seeding for CUSTOMIZE")
    
    // Predefined list of custom configuration keys and values
    customizeConfigs := []struct{
        bezeichnung string
        wert        string
    }{
        {"SystemTheme", "Dark"},
        {"DefaultLanguage", "EN"},
        {"MaxLoginAttempts", "5"},
        {"SessionTimeout", "30"},
        {"EmailNotifications", "true"},
        {"DataRetentionDays", "365"},
        {"SecurityLevel", "High"},
        {"AuditLogging", "enabled"},
        {"UserRegistration", "restricted"},
        {"CacheExpiration", "3600"},
    }

    for i, config := range customizeConfigs {
        var customize Customize

        // Set fixed fields
        customize.CUSTOMIZE_ID = faker.UUIDDigit()
        customize.CUSTOMIZE_NR = ptr(i + 1)
        bezeichnung := config.bezeichnung
        customize.BEZEICHNUNG = &bezeichnung
        wert := config.wert
        customize.WERT = &wert

        // Set timestamps
        now := time.Now()
        customize.ANLAGEDATUM = now
        customize.LETZTEAENDERUNG = now

        // Insert into the database
        query := `
        INSERT INTO CUSTOMIZE (
            CUSTOMIZE_ID, CUSTOMIZE_NR, BEZEICHNUNG, WERT, 
            ANLAGEDATUM, LETZTEAENDERUNG
        ) VALUES (
            @CUSTOMIZE_ID, @CUSTOMIZE_NR, @BEZEICHNUNG, @WERT, 
            @ANLAGEDATUM, @LETZTEAENDERUNG
        )`
        
        _, err := db.Exec(query,
            sql.Named("CUSTOMIZE_ID", customize.CUSTOMIZE_ID),
            sql.Named("CUSTOMIZE_NR", customize.CUSTOMIZE_NR),
            sql.Named("BEZEICHNUNG", customize.BEZEICHNUNG),
            sql.Named("WERT", customize.WERT),
            sql.Named("ANLAGEDATUM", customize.ANLAGEDATUM),
            sql.Named("LETZTEAENDERUNG", customize.LETZTEAENDERUNG),
        )
        if err != nil {
            log.Fatal().Err(err).Msg("Failed to insert fake CUSTOMIZE record")
            return
        }

        log.Info().Msgf("Inserted fake CUSTOMIZE record: %+v", customize)
    }

    log.Info().Msg("Seeder for CUSTOMIZE ran successfully")



}
