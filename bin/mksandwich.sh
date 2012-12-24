#!/bin/bash

function random() {
    random=32768
    while [ $random -gt $1 ]; do
        random=$RANDOM
    done

    echo $(let $random-1)
}

echo "##########################################"
echo "##    Fatti un panino da Felice!!       ##"
echo "##########################################"
echo ""

echo "Digita gli affettati: "
read -a affettati

echo "Digita i formaggi: "
read -a formaggi

echo "Qualche extra?"
read -a extra

echo "Olio e pepe?"
read oliopepe

output=""
echo ""
echo -ne "Fatti un panino con ${affettati[$(random ${#affettati[@]} )]} "

echo -e "e ${formaggi[$(random ${#formaggi[@]} )]}"

if [ ${#extra[@]} -gt 0 ]; then
    echo "e poi ci metti anche ${extra[$(random ${#extra[@]} )]}"
fi

if [ "$olioepepe" != "no" ]; then
    echo "piu\` olio e pepe!"
fi

echo ""
echo "Onest"

exit 0
