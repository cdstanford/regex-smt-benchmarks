;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[ \w]{3,}([A-Za-z]\.)?([ \w]*\#\d+)?(\r\n| )[ \w]{3,},\x20[A-Za-z]{2}\x20\d{5}(-\d{4})?$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00AA\u00EA9\u00AA\u00AA#9\xD\xA \u00D2a, GY 80579"
(define-fun Witness1 () String (seq.++ "\xaa" (seq.++ "\xea" (seq.++ "9" (seq.++ "\xaa" (seq.++ "\xaa" (seq.++ "#" (seq.++ "9" (seq.++ "\x0d" (seq.++ "\x0a" (seq.++ " " (seq.++ "\xd2" (seq.++ "a" (seq.++ "," (seq.++ " " (seq.++ "G" (seq.++ "Y" (seq.++ " " (seq.++ "8" (seq.++ "0" (seq.++ "5" (seq.++ "7" (seq.++ "9" "")))))))))))))))))))))))
;witness2: "\u00B5\u00B5oT\xD\xA7\u00BA\u00C6, gz 81992"
(define-fun Witness2 () String (seq.++ "\xb5" (seq.++ "\xb5" (seq.++ "o" (seq.++ "T" (seq.++ "\x0d" (seq.++ "\x0a" (seq.++ "7" (seq.++ "\xba" (seq.++ "\xc6" (seq.++ "," (seq.++ " " (seq.++ "g" (seq.++ "z" (seq.++ " " (seq.++ "8" (seq.++ "1" (seq.++ "9" (seq.++ "9" (seq.++ "2" ""))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ ((_ re.loop 3 3) (re.union (re.range " " " ")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))) (re.* (re.union (re.range " " " ")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))))(re.++ (re.opt (re.++ (re.union (re.range "A" "Z") (re.range "a" "z")) (re.range "." ".")))(re.++ (re.opt (re.++ (re.* (re.union (re.range " " " ")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))))(re.++ (re.range "#" "#") (re.+ (re.range "0" "9")))))(re.++ (re.union (str.to_re (seq.++ "\x0d" (seq.++ "\x0a" ""))) (re.range " " " "))(re.++ (re.++ ((_ re.loop 3 3) (re.union (re.range " " " ")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))) (re.* (re.union (re.range " " " ")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))))(re.++ (str.to_re (seq.++ "," (seq.++ " " "")))(re.++ ((_ re.loop 2 2) (re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.range " " " ")(re.++ ((_ re.loop 5 5) (re.range "0" "9"))(re.++ (re.opt (re.++ (re.range "-" "-") ((_ re.loop 4 4) (re.range "0" "9")))) (str.to_re ""))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
