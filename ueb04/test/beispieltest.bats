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


@test "1. Hilfeaufruf" {
    # Kurzform:
    run --separate-stderr "$DUT" -h

    echo "$output" | diff --binary ./test/data/exp/usage.exp -  # nach "-h"
    [ -z "$stderr" ]  # nach "-h"
    assert_success  # nach "-h"

    # Langform:
    run --separate-stderr "$DUT" --help

    echo "$output" | diff --binary ./test/data/exp/usage.exp -  # nach "--help"
    [ -z "$stderr" ]  # nach "--help"
    assert_success  # nach "--help"
}

@test "2. Includegraphics-Ausgabe für Latex_Mini_Dummy.tex" {
    run --separate-stderr "$DUT" ./test/data/in/Latex_Mini_Dummy.tex -g

    assert_output 'imgfoo
imgfoo'

    [ -z "$stderr" ]
    assert_success
}

@test "3. Structure-Ausgabe für Latex_Mini_Dummy.tex" {
    run --separate-stderr "$DUT" ./test/data/in/Latex_Mini_Dummy.tex -s

    echo "$output" | diff --binary ./test/data/exp/bsp.exp -

    [ -z "$stderr" ]
    assert_success
}

@test "4. Usepackage-Ausgabe für Latex_Mini_Dummy.tex" {
    run --separate-stderr "$DUT" ./test/data/in/Latex_Mini_Dummy.tex -u

    assert_output 'fontenc:T1
graphicx:'

    [ -z "$stderr" ]
    assert_success
}

@test "5. Includegraphics-Ausgabe für Latex_Mini_Dummy.tex" {
    run --separate-stderr "$DUT" ./test/data/in/Latex_Mini_Dummy.tex -g

    assert_output 'imgfoo
imgfoo'

    [ -z "$stderr" ]
    assert_success
}

@test "6. Includegraphics-Ausgabe für 1.tex" {
    run --separate-stderr "$DUT" ./test/data/in/1.tex -g

    assert_output 'imgfoo'

    [ -z "$stderr" ]
    assert_success
}

@test "7. Includegraphics-Ausgabe für 4.tex" {
    run --separate-stderr "$DUT" ./test/data/in/4.tex -g

    assert_output 'imgfoo
bar
gnasl'

    [ -z "$stderr" ]
    assert_success
}

@test "8. Includegraphics-Ausgabe für 6.tex" {
    run --separate-stderr "$DUT" ./test/data/in/6.tex -g

    assert_output 'images/other_version/imgfoo.jpg
./images/~/bats
images/../images/old/gnasl'

    [ -z "$stderr" ]
    assert_success
}

@test "9. Includegraphics-Ausgabe für 10.tex" {
    run --separate-stderr "$DUT" ./test/data/in/10.tex -g

    assert_output ''

    [ -z "$stderr" ]
    assert_success
}

@test "10. Includegraphics-Ausgabe für oneline.tex" {
    run --separate-stderr "$DUT" ./test/data/in/oneline.tex -g

    assert_output 'imgfoo'

    [ -z "$stderr" ]
    assert_success
}

@test "11. Includegraphics-Ausgabe für onelinemini.tex" {
    run --separate-stderr "$DUT" ./test/data/in/onelinemini.tex -g

    assert_output 'imgfoo
imgfoo'

    [ -z "$stderr" ]
    assert_success
}

@test "12. Structure-Ausgabe für 1.tex" {
    run --separate-stderr "$DUT" ./test/data/in/1.tex -s

    echo "$output" | diff --binary ./test/data/exp/1.exp -

    [ -z "$stderr" ]
    assert_success
}

@test "13. Structure-Ausgabe für 4.tex" {
    run --separate-stderr "$DUT" ./test/data/in/4.tex -s

    echo "$output" | diff --binary ./test/data/exp/4.exp -

    [ -z "$stderr" ]
    assert_success
}

@test "14. Structure-Ausgabe für 6.tex" {
    run --separate-stderr "$DUT" ./test/data/in/6.tex -s

    echo "$output" | diff --binary ./test/data/exp/6.exp -

    [ -z "$stderr" ]
    assert_success
}

@test "15. Structure-Ausgabe für 10.tex" {
    run --separate-stderr "$DUT" ./test/data/in/10.tex -s

    echo "$output" | diff --binary ./test/data/exp/10.exp -

    [ -z "$stderr" ]
    assert_success
}

@test "16. Structure-Ausgabe für oneline.tex" {
    run --separate-stderr "$DUT" ./test/data/in/oneline.tex -s

    echo "$output" | diff --binary ./test/data/exp/oneline.exp -

    [ -z "$stderr" ]
    assert_success
}

@test "17. Structure-Ausgabe für onelinemini.tex" {
    run --separate-stderr "$DUT" ./test/data/in/onelinemini.tex -s

    echo "$output" | diff --binary ./test/data/exp/onelinemini.exp -

    [ -z "$stderr" ]
    assert_success
}

@test "18. Usepackage-Ausgabe für 1.tex" {
    run --separate-stderr "$DUT" ./test/data/in/1.tex -u

    assert_output 'pgf:
times:
fontenc:T1
hyperref:colorlinks,citecolor=black,filecolor=black,linkcolor=black,urlcolor=black
ngerman:
amsmath:
caption2:
graphicx:'

    [ -z "$stderr" ]
    assert_success
}

@test "19. Usepackage-Ausgabe für 4.tex" {
    run --separate-stderr "$DUT" ./test/data/in/4.tex -u

    assert_output 'pgf:
times:
fontenc:T1
hyperref:colorlinks,citecolor=black,filecolor=black,linkcolor=black,urlcolor=black
ngerman:
amsmath:
caption2:
graphicx:'

    [ -z "$stderr" ]
    assert_success
}

@test "20. Usepackage-Ausgabe für 6.tex" {
    run --separate-stderr "$DUT" ./test/data/in/6.tex -u

    assert_output 'pgf:
times:
fontenc:T1
hyperref:colorlinks,citecolor=black,filecolor=black,linkcolor=black,urlcolor=black
ngerman:
amsmath:
caption2:
graphicx:'

    [ -z "$stderr" ]
    assert_success
}

@test "21. Usepackage-Ausgabe für 10.tex" {
    run --separate-stderr "$DUT" ./test/data/in/10.tex -u

    assert_output ''

    [ -z "$stderr" ]
    assert_success
}

@test "22. Usepackage-Ausgabe für oneline.tex" {
    run --separate-stderr "$DUT" ./test/data/in/oneline.tex -u

    assert_output 'pgf:
times:
fontenc:T1
hyperref:colorlinks,citecolor=black,filecolor=black,linkcolor=black,urlcolor=black
ngerman:
amsmath:
caption2:
graphicx:'

    [ -z "$stderr" ]
    assert_success
}

@test "23. Usepackage-Ausgabe für onelinemini.tex" {
    run --separate-stderr "$DUT" ./test/data/in/onelinemini.tex -u

    assert_output 'graphicx:
    fontenc:'

    [ -z "$stderr" ]
    assert_success
}