BATS_TEST_TIMEOUT=10

setup_file() {
    # sichergehen, dass $DUT gesetzt ist
    if [ -z ${DUT+x} ]; then
        echo 'DUT not set'
        exit
    fi

    bats_require_minimum_version 1.11.0
}

setup() {
    # zusaetzliche asserts laden
    load 'test_helper/bats-support/load'
    load 'test_helper/bats-assert/load'
    load 'test_helper/bats-file/load'
}

teardown() {
    # nach jedem Testfall aufräumen
    rm -f ./test/data/out/*.out

    # Ausgabe des Aufrufs bei fehlgeschlagenen Testfaellen
    echo "Aufruf: $BATS_RUN_COMMAND"
    # Ausgabe des Exit-Codes des Aufrufs bei fehlgeschlagenen Testfaellen
    echo "Exit-Code: $status"
}

@test "Testet die Ausgabe und die Datei mithilfe von diff" {

    run --separate-stderr "$DUT" ./test/data/out/beispieltest.out < ./test/data/in/beispieltest.in

    assert_success
    assert_output 'SoRichtigSchlecht'
    [ -z "$stderr" ]  # es darf keine Ausgabe auf stderr geben

    diff ./test/data/out/beispieltest.out ./test/data/exp/beispieltest.exp
}

@test "BestCase" {

    run --separate-stderr "$DUT" ./test/data/out/bestCase.out < ./test/data/in/bestCase.in

    assert_success
    assert_output 'SoRichtigSchlecht'
    [ -z "$stderr" ]  # es darf keine Ausgabe auf stderr geben

    diff ./test/data/out/bestCase.out ./test/data/exp/bestCase.exp
}

@test "Doppler Bewertung 1" {

    run --separate-stderr "$DUT" ./test/data/out/dopplerBew.out < ./test/data/in/dopplerBew.in

    assert_success
    assert_output 'Worst'
    [ -z "$stderr" ]  # es darf keine Ausgabe auf stderr geben

    diff ./test/data/out/dopplerBew.out ./test/data/exp/dopplerBew.exp
}

@test "Doppler Bewertung 2" {

    run --separate-stderr "$DUT" ./test/data/out/dopplerBewertung.out < ./test/data/in/dopplerBewertung.in

    assert_success
    assert_output 'ZiemlichSchlecht'
    [ -z "$stderr" ]  # es darf keine Ausgabe auf stderr geben

    diff ./test/data/out/dopplerBewertung.out ./test/data/exp/dopplerBewertung.exp
}

@test "Doppler Kennzahl" {

    run --separate-stderr "$DUT" ./test/data/out/dopplerKennzahl.out < ./test/data/in/dopplerKennzahl.in

    assert_success
    assert_output 'SoRichtigSchlecht'
    [ -z "$stderr" ]  # es darf keine Ausgabe auf stderr geben

    diff ./test/data/out/dopplerKennzahl.out ./test/data/exp/dopplerKennzahl.exp
}

@test "Extremfall" {

    run --separate-stderr "$DUT" ./test/data/out/extrem.out < ./test/data/in/extrem.in

    assert_success
    assert_output 'SoRichtigSchlecht'
    [ -z "$stderr" ]  # es darf keine Ausgabe auf stderr geben

    diff ./test/data/out/extrem.out ./test/data/exp/extrem.exp
}

@test "Leer" {

    run --separate-stderr "$DUT" ./test/data/out/leer.out < ./test/data/in/leer.in

    assert_success
    assert_output ''
    [ -z "$stderr" ]  # es darf keine Ausgabe auf stderr geben

    diff ./test/data/out/leer.out ./test/data/exp/leer.exp
}

@test "Minimal" {

    run --separate-stderr "$DUT" ./test/data/out/minimal.out < ./test/data/in/minimal.in

    assert_success
    assert_output 'NochWenigerSchlecht'
    [ -z "$stderr" ]  # es darf keine Ausgabe auf stderr geben

    diff ./test/data/out/minimal.out ./test/data/exp/minimal.exp
}

@test "Viele Doppler" {

    run --separate-stderr "$DUT" ./test/data/out/vieleDoppler.out < ./test/data/in/vieleDoppler.in

    assert_success
    assert_output 'NochWenigerSchlecht'
    [ -z "$stderr" ]  # es darf keine Ausgabe auf stderr geben

    diff ./test/data/out/vieleDoppler.out ./test/data/exp/vieleDoppler.exp
}

@test "Viele Failed" {

    run --separate-stderr "$DUT" ./test/data/out/vieleFailed.out < ./test/data/in/vieleFailed.in

    assert_success
    assert_output 'Worst'
    [ -z "$stderr" ]  # es darf keine Ausgabe auf stderr geben

    diff ./test/data/out/vieleFailed.out ./test/data/exp/vieleFailed.exp
}

@test "Worst Case" {

    run --separate-stderr "$DUT" ./test/data/out/worstCase.out < ./test/data/in/worstCase.in

    assert_success
    assert_output 'Worst'
    [ -z "$stderr" ]  # es darf keine Ausgabe auf stderr geben

    diff ./test/data/out/worstCase.out ./test/data/exp/worstCase.exp
}

@test "Zieldatei ist schon sortiert vorhanden" {

    run --separate-stderr "$DUT" ./test/data/out/zieldateiSortVorhanden.out < ./test/data/in/zieldateiSortVorhanden.in

    assert_success
    assert_output 'SoRichtigSchlecht'
    [ -z "$stderr" ]  # es darf keine Ausgabe auf stderr geben

    diff ./test/data/out/zieldateiSortVorhanden.out ./test/data/exp/zieldateiSortVorhanden.exp
}

@test "Zieldatei vorhanden aber unsortiert" {

    run --separate-stderr "$DUT" ./test/data/out/zieldateiVorhanden.out < ./test/data/in/zieldateiVorhanden.in

    assert_success
    assert_output 'SoRichtigSchlecht'
    [ -z "$stderr" ]  # es darf keine Ausgabe auf stderr geben

    diff ./test/data/out/zieldateiVorhanden.out ./test/data/exp/zieldateiVorhanden.exp
}
