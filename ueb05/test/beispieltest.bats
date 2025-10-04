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
    # zusätzliche asserts laden
    load 'test_helper/bats-support/load'
    load 'test_helper/bats-assert/load'
    load 'test_helper/bats-file/load'
}

teardown() {
    echo "Aufruf: $BATS_RUN_COMMAND"
    echo "Exit-Code: $status"
}

# Ruft make mit DUT als file mittels run auf.
# $@ Parameter, die an make uebergeben werden
runMake() {
    run --separate-stderr make --file="$DUT" "$@"
}

@test "01. Hilfeaufruf, Beispieltest" {
    runMake help

    echo "$output" | diff --binary - test/data/exp/help.exp
    assert_equal "$stderr" ""
    assert_success
}

@test "02. ppm aus jpg, Beispieltest" {
    rm -f fh-wedel.ppm
    runMake fh-wedel.ppm

    diff -q --binary fh-wedel.ppm test/data/exp/fh-wedel.ppm.exp
    assert_success
    
    rm -f fh-wedel.ppm
}

@test "03. make png, Beispieltest" {
    rm -f fh-wedel.ppm fh-wedel.scaled fh-wedel.png
    rm -f tga.ppm tga.scaled tga.png
    
    runMake png

    diff -q --binary fh-wedel.png test/data/exp/fh-wedel.png.exp
    diff -q --binary tga.png test/data/exp/tga.png.exp
    assert_success
    
    rm -f fh-wedel.ppm fh-wedel.scaled fh-wedel.png
    rm -f tga.ppm tga.scaled tga.png
}

@test "04. png aus jpg, skaliert (Querformat, SIZE=200), Beispieltest" {
    rm -f fh-wedel.ppm fh-wedel.scaled fh-wedel.png
    
    runMake fh-wedel.png SIZE=200

    diff -q --binary fh-wedel.ppm test/data/exp/fh-wedel.ppm.exp
    diff -q --binary fh-wedel.scaled test/data/exp/fh-wedel.scaled_200.exp
    diff -q --binary fh-wedel.png test/data/exp/fh-wedel.png_200.exp
    assert_success
    
    rm -f fh-wedel.ppm fh-wedel.scaled fh-wedel.png
}

@test "05. ppm aus tga" {
    rm -f tga.ppm
    runMake tga.ppm

    diff -q --binary tga.ppm test/data/exp/tga.ppm.exp
    assert_success
    
    rm -f tga.ppm
}

@test "06. png aus tga, Beispieltest" {
    rm -f tga.ppm tga.scaled tga.png
    
    runMake tga.png

    diff -q --binary tga.ppm test/data/exp/tga.ppm.exp
    diff -q --binary tga.scaled test/data/exp/tga.scaled.exp
    diff -q --binary tga.png test/data/exp/tga.png.exp
    assert_success
    
    rm -f tga.ppm tga.scaled tga.png
}

@test "07. ppm aus jpg, ironminster" {
    rm -f ironminster.ppm
    runMake ironminster.ppm

    diff -q --binary ironminster.ppm test/data/exp/ironminster.ppm.exp
    assert_success
    
    rm -f ironminster.ppm
}

@test "08. make png, ironminster" {
    rm -f ironminster.ppm ironminster.scaled ironminster.png
    rm -f tga.ppm tga.scaled tga.png
    
    runMake png

    diff -q --binary ironminster.png test/data/exp/ironminster.png.exp
    diff -q --binary tga.png test/data/exp/tga.png.exp
    assert_success
    
    rm -f ironminster.ppm ironminster.scaled ironminster.png
    rm -f tga.ppm tga.scaled tga.png
}

@test "09. png aus jpg, skaliert (Querformat, SIZE=200), ironminster" {
    rm -f ironminster.ppm ironminster.scaled ironminster.png
    
    runMake ironminster.png SIZE=200

    diff -q --binary ironminster.ppm test/data/exp/ironminster.ppm.exp
    diff -q --binary ironminster.scaled test/data/exp/ironminster.scaled_200.exp
    diff -q --binary ironminster.png test/data/exp/ironminster.png_200.exp
    assert_success
    
    rm -f ironminster.ppm ironminster.scaled ironminster.png
}

@test "10. ppm aus jpg, meme.jpeg" {
    rm -f meme.ppm
    runMake meme.ppm

    diff -q --binary meme.ppm test/data/exp/meme.ppm.exp
    assert_success
    
    rm -f meme.ppm
}

@test "11. make png, meme.jpg" {
    rm -f meme.ppm meme.scaled meme.png
    rm -f tga.ppm tga.scaled tga.png
    
    runMake png

    diff -q --binary meme.png test/data/exp/meme.png.exp
    diff -q --binary tga.png test/data/exp/tga.png.exp
    assert_success
    
    rm -f meme.ppm meme.scaled meme.png
    rm -f tga.ppm tga.scaled tga.png
}

@test "12. png aus jpg, skaliert (Querformat, SIZE=200), meme.jpg" {
    rm -f meme.ppm meme.scaled meme.png
    
    runMake meme.png SIZE=200

    diff -q --binary meme.ppm test/data/exp/meme.ppm.exp
    diff -q --binary meme.scaled test/data/exp/meme.scaled_200.exp
    diff -q --binary meme.png test/data/exp/meme.png_200.exp
    assert_success
    
    rm -f meme.ppm meme.scaled meme.png
}

@test "13. archive target mit beispieltest, angenommen es geht nur um das archive.tgz" {
    rm -f fh-wedel.ppm fh-wedel.scaled fh-wedel.png archive.tgz
    
    runMake archive

    assert_file_exist archive.tgz
    assert_success
    
    rm -f fh-wedel.ppm fh-wedel.scaled fh-wedel.png archive.tgz
}

@test "14. archive target mit beispieltest" {
    rm -f fh-wedel.ppm fh-wedel.scaled fh-wedel.png archive.tgz
    
    runMake archive.tgz

    assert_file_exist archive.tgz
    assert_success
    
    rm -f fh-wedel.ppm fh-wedel.scaled fh-wedel.png archive.tgz
}

@test "15. all beispieltest, angenommen es geht um pngs existieren mit dem .tgz archiv zusammen" {
    rm -f fh-wedel.ppm fh-wedel.scaled fh-wedel.png archive.tgz
    
    runMake all

    assert_file_exist ironminster.png
    assert_file_exist meme.png
    assert_file_exist fh-wedel.jpg
    assert_file_exist archive.tgz
    assert_success
    
    rm -f fh-wedel.ppm fh-wedel.scaled fh-wedel.png archive.tgz
}

@test "16. clean test" {
    runMake all

    assert_file_exist fh-wedel.jpg
    assert_file_exist meme.jpg
    assert_file_exist ironminster.jpg
    assert_file_exist tga.tga
    assert_success
}
