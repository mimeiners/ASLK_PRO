SQLITE = sqlite3

%.sqlite: %.CSV
	rm -f $@
	$(SQLITE) $@ -echo -cmd ".mode csv" ".import $< $*"

%.dump: %.sqlite
	$(SQLITE) $< "SELECT * FROM $*"

database:
	sh ./mksqlite.sh

