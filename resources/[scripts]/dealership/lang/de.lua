if not Lang then Lang = {} end
Lang['de'] = {
    ['open'] = "~y~E~w~ zum öffnen",
    ['open_dealership'] = "~y~E~w~ zum öffnen",
    ['preview_vehicle'] = "~y~E~w~ Testfahrt ~y~B~w~ Kaufen",
    ['test_drive_started'] = "Testfahrt gestartet, sie endet in %s Sekunden.",
    ['already_has_business'] = "Du hast bereits eine Autohaus",
    ['already_has_owner'] = "Dieses Autohaus gehört schon jemanden",
    ['businnes_bougth'] = "Herzlichen Glückwunsch, Sie haben ein Autohaus gekauft",
    ['insufficient_funds'] = "Zu wenig Geld",
    ['insufficient_stock'] = "Unzureichender Bestand für dieses Fahrzeug",
    ['bought_vehicle'] = "Herzlichen Glückwunsch, Sie haben ein %s gekauft",
    ['money_withdrawn'] = "Geld abgehoben",
    ['money_deposited'] = "Geld eingezahlt",
    ['invalid_value'] = "Ungültiger Wert",
    ['max_amount'] = "Die maximale Anzahl dieser Fahrzeuge, die Sie transportieren können, beträgt %s",
    ['max_stock_vehicle'] = "Sie haben bereits die maximale Anzahl dieses Fahrzeugs in Ihrem Bestand erreicht",
    ['max_employees'] = "Sie haben das Mitarbeiterlimit erreicht",
    ['user_not_found'] = "Mitarbeiter wurde nicht gefunden",
    ['user_employed'] = "Mitarbeiter bereits angestellt",
    ['hired_user'] = "Herzlichen Glückwunsch, Sie haben %s eingestellt",
    ['fired_user'] = "Mitarbeiter entlassen",
    ['sell_request_created'] = "Verkauf angefordert für $%s",
    ['sell_request_created_owner'] = "Verkaufsanfrage wurde in Ihrem Autohaus erstellt",
    ['no_owner'] = "Dieses Autohaus hat keinen Besitzer",
    ['request_cancelled'] = "Ihre Anfrage wurde storniert und Ihr Geld zurückerstattet",
    ['buy_request_cancelled'] = "Ihre Anfrage wurde storniert",
    ['sold_vehicle'] = "Sie haben dieses Fahrzeug erfolgreich verkauft für $ %s",
    ['cant_cancel_request'] = "Sie können diese Anfrage nicht stornieren",
    ['request_created'] = "Ihre Anfrage wurde erstellt",
    ['cant_decline_request'] = "Sie können diese Anfrage nicht ablehnen",
    ['cant_accept_request'] = "Sie können diese Anfrage nicht annehmen",
    ['request_declined'] = "Sie haben diese Anfrage abgelehnt",
    ['request_finished'] = "Sie haben diese Anfrage abgeschlossen",
    ['o_bought_vehicle'] = "Sie haben dieses Fahrzeug gekauft",
    ['not_own_this_vehicle'] = "Der Kunde besitzt dieses Fahrzeug nicht mehr",
    ['not_own_this_vehicle_2'] = "Sie besitzen dieses Fahrzeug nicht",
    ['stock_price_changed'] = "Preis geändert",
    ['no_own_dealer'] = "Sie besitzen dieses Autohaus nicht",
    ['dealer_sold'] = "Sie haben dieses Autohaus verkauft",
    ['must_be_owner'] = "Sie müssen Eigentümer sein, um das zu tun",
    ['comission_received'] = "Sie haben eine Provision erhalten, überprüfen Sie Ihr Konto",
    ['comission_sent'] = "Der Mitarbeiter hat Ihre Provision erhalten",
    ['cant_find_user'] = "Dieser Mitarbeiter ist momentan nicht verfügbar",
    ['already_has_vehicle'] = "Sie haben dieses Fahrzeug bereits",
    ['already_requested'] = "Sie haben bereits eine aktive Anfrage für dieses Fahrzeug",

    ['occupied_places'] = "Besetzte Garage",
    ['already_has_job'] = "Sie haben bereits eine Lieferung im gange",
    ['blip_route'] = "Autohaus",
    ['already_is_in_garage'] = "Ihr Fahrzeug steht in Ihrer Garage",
    ['objective_marker_3'] = "~y~E~w~",
    ['sucess_2'] = "~g~Erfolg",
    ['sucess_in_progess_2'] = "Bring das Fahrzeug zurück in die Garage",
    ['sucess_finished_2'] = "Job beendet",
    ['garage_marker'] = "Ihre Garage",
    ['you_died'] = "Du bist gestorben, du hast keine Produkte geliefert",
    ['vehicle_destroyed'] = "Ihr Fahrzeug wurde zerstört, Sie haben keine Produkte geliefert",
    ['truck_plate'] = "Truck",
    ['truck_blip'] = "Vehicle",
    ['vehicle_locked'] = "Fahrzeug  erfolgreich <b>abgeschlossen</b>.",
    ['vehicle_unlocked'] = "Fahrzeug erfolgreich <b>aufgeschlossen</b>.",

    ['balance_vehicle_export'] = "Fahrzeugexport: %s",
    ['balance_vehicle_import'] = "Fahrzeugimport: %s",
    ['balance_vehicle_bought'] = "Fahrzeug gekauft: %s",
    ['balance_used_vehicle_bought'] = "Gebrauchtwagen gekauft: %s",
    ['balance_request_started'] = "[1] Fahrzeuganfragen Import: %s",
    ['balance_request_finished'] = "[2] Fahrzeuganfragen Import: %s",
    ['stock_full'] = "Der Lagerbestand des Autohauses ist voll",

    ['logs_date'] = "Datum",
    ['logs_hour'] = "Zeit",
    ['logs_bought'] = "```prolog\n[HÄNDLER GEKAUFT]: %s \n[ID]: %s \r```",
    ['logs_close'] = "```prolog\n[HÄNDLER GESCHLOSSEN]: %s \n[ID]: %s \r```",
    ['logs_lost_low_stock'] = "```prolog\n[DEALERSHIP BROKE]: %s\n[STOCK]: %s\n[EMPTY FROM]: %s\n[ID]: %s \r```",
	['logs_finish_import'] = "```prolog\n[IMPORT ABGESCHLOSSEN]: %s\n[FAHRZEUG]: %s %s\n[PREIS]: %s\n[STOCK]: %s\n[ID]: %s \r```",
	['logs_finish_export'] = "```prolog\n[EXPORT ABGESCHLOSSEN]: %s\n[FAHRZEUG]: %s %s\n[PREIS]: %s\n[STOCK]: %s\n[ID]: %s \r```",
    ['logs_vehicle_bought'] = "```prolog\n[FAHRZEUG GEKAUFT]: %s\n[FAHRZEUG]: %s\n[PREIS]: %s\n[ID]: %s \r```",
    ['logs_sell_used_vehicle_request'] = "```prolog\n[VERKAUFSANFRAGE ERSTELLT]: %s\n[FAHRZEUG]: %s\n[PLATE]: %s \n[PREIS]: %s \n[ID]: %s \r```",
    ['logs_sell_used_vehicle_finish'] = "```prolog\n[VERKAUFSANFRAGE ABGESCHLOSSEN]: %s\n[FAHRZEUG]: %s\n[PLATE]: %s \n[PREIS]: %s \n[ID]: %s \r```",
    ['logs_sell_used_vehicle_without_owner'] = "```prolog\n[FAHRZEUG VERKAUFEN]: %s\n[FAHRZEUG]: %s\n[PLATE]: %s \n[PREIS]: %s \n[ID]: %s \r```",
    ['logs_buy_vehicle_request'] = "```prolog\n[KAUFANFRAGE ERSTELLT]: %s\n[FAHRZEUG]: %s\n[PREIS]: %s \n[ID]: %s \r```",
    ['logs_buy_vehicle_finish'] = "```prolog\n[KAUFANFRAGE ABGESCHLOSSEN]: %s\n[FAHRZEUG]: %s\n[PREIS]: %s \n[ID]: %s \r```",
    ['logs_withdraw'] = "```prolog\n[GELD ABGEZOGEN]: %s\n[HÖHE]: %s\n[ID]: %s \r```",
    ['logs_deposited'] = "```prolog\n[GELD EINGEZAHLT]: %s\n[HÖHE]: %s\n[ID]: %s \r```",
}